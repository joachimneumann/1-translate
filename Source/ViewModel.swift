//import SwiftUI
//import NumberTranslator
//import SwiftGmp
//
//@MainActor
//@Observable class ViewModel {
//    var calculator: Calculator
//    private(set) var _voices: Voices!
//    var numberTranslator: XNumberTranslator
//    var basicKeyboard: BasicKeyboard!
//
//    init() {
//        print("ViewModel init()")
//
//        // Initialize numberTranslator and calculator first
//        numberTranslator = XNumberTranslator()
//        calculator = Calculator(precision: 20)
//
//        // Initialize dependent properties AFTER the first phase is complete
//        self.basicKeyboard = BasicKeyboard(calculator: calculator)
//        self._voices = Voices(numberTranslator: numberTranslator)
//    }
//}


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
    var calculator: Calculator
    private(set) var _voices: Voices!
    var numberTranslator: XNumberTranslator
    var showAC = true
    var persistent = Persistent()

    var _1Translation: TranslationResult = TranslationResult(displayText: "", overline: nil, spokenText: nil)

    private let keysThatRequireValidNumber = ["±", "%", "/", "*", "-", "+", "="]
    private static let MAX_DISPLAY_LEN = 10_000 /// too long strings in Text() crash the app
    private let keyColor = KeyColor()

    private var upHasHappended: [String: Bool] = [:]
    private var downAnimationFinished: [String: Bool] = [:]
    
    private let downTime = 0.15
    private let upTime = 0.4
    public var currentLR: LR = LR("0")
    public var currentLRWithSeparators: LR = LR("0")

    var voices: Voices {
        return _voices
    }

    init() {
        print("ViewModel init()")

        // Initialize numberTranslator and calculator first
        numberTranslator = XNumberTranslator()
        calculator = Calculator(precision: 40, maxOutputLength: 15) // 999 trillion

        // Initialize dependent properties AFTER the first phase is complete
        _voices = Voices(numberTranslator: numberTranslator)

        calculator.decimalSeparator = persistent.decimalSeparator
        calculator.separateGroups = persistent.separateGroups

        updateTranslation()
    }

//    func keyDownX(_ aKey: AKey) {
//        if aKey.label == "AC" {
//            print("AC!")
////            basicKeyboard.back(true)
//        }
//        print("down \(aKey.label)")
//    }
//    func keyUpX(_ aKey: AKey) {
//        print("up   \(aKey.label)")
//    }

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
        print("updateTranslation")
        let allInOneLine = currentLR.string
        _1Translation = numberTranslator .getResult(allInOneLine)
    }
    
    private func updateBackgroundColors(exceptFor: Key) {
//        Task(priority: .userInitiated) {
//            for var xx in XXs {
//                if xx.op.getRawValue() != exceptFor.symbol {
//                    let pending = calculator.isPendingOperator[xx.op.getRawValue()] ?? false
//                    let allowed = calculator.isAllowedOperator[xx.op.getRawValue()] ?? true
//                    if !allowed {
//                        xx.bgColor = keyColor.disabledColor
//                    } else {
//                        if pending {
//                            xx.bgColor = keyColor.pendingBackgroundUpColorFor(op: xx.op)
//                        } else {
//                            xx.bgColor = keyColor.backgroundUpColorFor(op: xx.op)
//                        }
//                    }
//                }
//            }
//        }
    }
    
    func touchDown(for thisKey: inout Key) {
//        // print("touchDown \(thisKey.symbol)")
//        upHasHappended[thisKey.symbol] = false
//        downAnimationFinished[thisKey.symbol] = false
//        withAnimation(.easeIn(duration: downTime)) {
//            thisKey.xx.bgColor = keyColor.backgroundDownColorFor(op: thisKey.op)
//        }
////        Task(priority: .userInitiated) {
////            try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
//            // print("down: upHasHappended \(upHasHappended))")
//            downAnimationFinished[thisKey.symbol] = true
//            if upHasHappended[thisKey.symbol] ?? false {
//                withAnimation(.easeIn(duration: upTime)) {
//                    let pending = calculator.isPendingOperator[thisKey.op.getRawValue()] ?? false
//                    if pending {
//                        thisKey.xx.bgColor = keyColor.pendingBackgroundUpColorFor(op: thisKey.op)
//                    } else {
//                        thisKey.xx.bgColor = keyColor.backgroundUpColorFor(op: thisKey.op)
//                    }
//                }
//            }
////        }
    }
    
    func touchUp(of key: inout Key, screen: Screen) {
//        defaultTask(for: key, screen: screen)
//        updateBackgroundColors(exceptFor: key)
//        upHasHappended[key.symbol] = true
//        // print("up: downAnimationFinished \(downAnimationFinished[key.symbol]!)")
//        if downAnimationFinished[key.symbol] ?? false {
//            withAnimation(.easeIn(duration: upTime)) {
//                let pending = calculator.isPendingOperator[key.op.getRawValue()] ?? false
//                if pending {
//                    key.xx.bgColor = keyColor.pendingBackgroundUpColorFor(op: key.op)
//                } else {
//                    key.xx.bgColor = keyColor.backgroundUpColorFor(op: key.op)
//                }
//            }
//        }
    }
    
    func defaultTask(for key: Key, screen: Screen) {
        print("defaultTask")
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
        print("refreshDisplay")
        currentLR = calculator.lr
        currentLRWithSeparators = calculator.addSeparators(lr: currentLR)
        updateTranslation()
//        self.showAC = currentDisplay.isZero
    }

}
