//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

@MainActor
@Observable class ViewModel {
    var calculator = Calculator(precision: 40, maxOutputLength: 15) // 999 trillion
    var numberTranslator: XNumberTranslator
    var _1Translation: TranslationResult = TranslationResult(displayText: "", overline: nil, spokenText: nil)

    var backgroundColorDict: [String: Color] = [:]
    var textColorDict: [String: Color] = [:]

    var showAC = true
    var persistent = Persistent()
    var keyArray: [Key] = []

    private let keysThatRequireValidNumber = ["±", "%", "/", "x", "-", "+", "="]
    private static let MAX_DISPLAY_LEN = 10_000 /// too long strings in Text() crash the app
    private let keyColor = KeyColor()

    private var upHasHappended: [String: Bool] = [:]
    private var downAnimationFinished: [String: Bool] = [:]
    
    private let downTime = 0.15
    private let upTime = 0.4
    private(set) var _voices: Voices!
    public var currentLR: LR = LR("0")
    public var currentLRWithSeparators: LR = LR("0")
    var voices: Voices {
        return _voices
    }
//    var voices: Voices

    init() {
        numberTranslator = XNumberTranslator()
        self._voices = Voices(numberTranslator: numberTranslator)
        calculator.decimalSeparator = persistent.decimalSeparator
        calculator.separateGroups = persistent.separateGroups

        for op in calculator.allOperationsSorted {
            backgroundColorDict[op.getRawValue()] = keyColor.backgroundUpColorFor(op: op)
            textColorDict[op.getRawValue()] = keyColor.textColorFor(op: op)
        }
        updateTranslation()
    }

    var firstFont: Font {
        Font.largeTitle
    }
    
    func cleanSeparators(_ text: String) -> String {
        var ret = text
        if persistent.separateGroups {
            ret = ret.replacingOccurrences(of: String(persistent.decimalSeparator.groupCharacter), with: "")
        }
        if persistent.decimalSeparator != .dot {
            ret = ret.replacingOccurrences(of: String(persistent.decimalSeparator.character), with: ".")
        }
        return ret
    }

    func updateTranslation() {
        let allInOneLine = currentLR.string
        _1Translation = numberTranslator .getResult(allInOneLine)
    }
    
    private func updateBackgroundColors(exceptFor: Key) {
        Task(priority: .userInitiated) {
            for key in keyArray {
                if key.symbol != exceptFor.symbol {
                    let pending = calculator.isPendingOperator[key.op.getRawValue()] ?? false
                    let allowed = calculator.isAllowedOperator[key.op.getRawValue()] ?? true
                    if !allowed {
                        backgroundColorDict[key.symbol] = keyColor.disabledColor
                    } else {
                        if pending {
                            backgroundColorDict[key.symbol] = keyColor.pendingBackgroundUpColorFor(op: key.op)
                        } else {
                            backgroundColorDict[key.symbol] = keyColor.backgroundUpColorFor(op: key.op)
                        }
                    }
                }
            }
        }
    }
    func touchDown(for thisKey: Key) {
        // print("touchDown \(thisKey.symbol)")
        upHasHappended[thisKey.symbol] = false
        downAnimationFinished[thisKey.symbol] = false
        withAnimation(.easeIn(duration: downTime)) {
            backgroundColorDict[thisKey.symbol] = keyColor.backgroundDownColorFor(op: thisKey.op)
        }
        Task(priority: .userInitiated) {
            try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
            // print("down: upHasHappended \(upHasHappended))")
            downAnimationFinished[thisKey.symbol] = true
            if upHasHappended[thisKey.symbol] ?? false {
                withAnimation(.easeIn(duration: upTime)) {
                    let pending = calculator.isPendingOperator[thisKey.op.getRawValue()] ?? false
                    if pending {
                        backgroundColorDict[thisKey.symbol] = keyColor.pendingBackgroundUpColorFor(op: thisKey.op)
                    } else {
                        backgroundColorDict[thisKey.symbol] = keyColor.backgroundUpColorFor(op: thisKey.op)
                    }
                }
            }
        }
    }
    
    func touchUp(of key: Key, screen: Screen) {
        defaultTask(for: key, screen: screen)
        updateBackgroundColors(exceptFor: key)
        upHasHappended[key.symbol] = true
        // print("up: downAnimationFinished \(downAnimationFinished[key.symbol]!)")
        if downAnimationFinished[key.symbol] ?? false {
            withAnimation(.easeIn(duration: upTime)) {
                let pending = calculator.isPendingOperator[key.op.getRawValue()] ?? false
                if pending {
                    backgroundColorDict[key.symbol] = keyColor.pendingBackgroundUpColorFor(op: key.op)
                } else {
                    backgroundColorDict[key.symbol] = keyColor.backgroundUpColorFor(op: key.op)
                }
            }
        }
    }
    
    func defaultTask(for key: Key, screen: Screen) {
        calculator.press(key.op)
        refreshDisplay(screen: screen)
        lastScreen = screen
    }
    
    var lastScreen: Screen? = nil
    
    func refreshDisplay() {
        if let lastScreen {
            refreshDisplay(screen: lastScreen)
        }
    }

    func refreshDisplay(screen: Screen) {
        currentLR = calculator.lr
        currentLRWithSeparators = calculator.addSeparators(lr: currentLR)
        updateTranslation()
//        self.showAC = currentDisplay.isZero
    }

}
