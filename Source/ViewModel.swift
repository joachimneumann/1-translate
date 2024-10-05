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
    var showAC = true
    var keyStatusColor: [String: Color] = [:]
    var textColor: [String: Color] = [:]
    var _1Translation: TranslationResult = TranslationResult(displayText: "", overline: nil, spokenText: nil)
    var persistent = Persistent()

    var calculator = Calculator(precision: 40) /// I want to call fast sync functions
    private let keysThatRequireValidNumber = ["±", "%", "/", "x", "-", "+", "="]
    private static let MAX_DISPLAY_LEN = 10_000 /// too long strings in Text() crash the app
    private let keyColor = KeyColor()

    private var upHasHappended: [String: Bool] = [:]
    private var downAnimationFinished: [String: Bool] = [:]
    

    private let downTime = 0.1
    private let upTime = 0.4
    private var previouslyPendingOperator: String? = nil
    var numberTranslator: XNumberTranslator
    private(set) var _voices: Voices!
    var voices: Voices {
        return _voices
    }
//    var voices: Voices

    init() {
        numberTranslator = XNumberTranslator()
        self._voices = Voices(numberTranslator: numberTranslator)


        /// currentDisplay will be updated shortly by refreshDisplay in onAppear() of Calculator
        /// I set some values here

        for symbol in [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",",
            "C", "AC", "±", "%", "/", "x", "-", "+", "="] {
            keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: false)
            textColor[symbol] = keyColor.textColor(for: symbol, isPending: false)
        }
        keyStatusColor["plus"] = keyColor.upColor(for: "+", isPending: false)
        
//        for language in languages.list {
//            language.hasVoice = false
//            if language.translator.code != nil {
//                if voices.voiceDict[language.translator.code!] != nil {
//                    language.hasVoice = true
//                }
//            }
//        }
        updateTranslation()
    }

    var firstFont: Font {
        Font.largeTitle
    }
    
//    var translator: Translator {
//        get {
//            languages.language.translator
//        }
//        set(newValue) {
//            languages.language.translator = newValue
//        }
//    }
        
    func cleanSeparators(_ text: String) -> String {
        var ret = text
        if persistent.groupSeparator != .none {
            ret = ret.replacingOccurrences(of: persistent.groupSeparator.string, with: "")
        }
        if persistent.decimalSeparator != .dot {
            ret = ret.replacingOccurrences(of: persistent.decimalSeparator.string, with: ".")
        }
        return ret
    }

    func updateTranslation() {
        let allInOneLine = cleanSeparators(calculator.lr.string)
        _1Translation = numberTranslator.getResult(allInOneLine)
    }
    
    ///  To give a clear visual feedback to the user that the button has been pressed,
    ///  the animation will always wait for the downAnimation to finish
    func showDisabledColors(for symbol: String) async {
        await MainActor.run {
            withAnimation(.easeIn(duration: downTime)) {
                keyStatusColor[symbol] = keyColor.disabledColor
            }
        }
        try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
        await MainActor.run {
            withAnimation(.easeIn(duration: upTime)) {
                keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: symbol == previouslyPendingOperator)
            }
        }
    }

    func showUpColors(for symbol: String) {
        /// Set the background color back to normal
        withAnimation(.easeIn(duration: upTime)) {
            keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: symbol == previouslyPendingOperator)
        }
    }
    
    func touchDown(for symbol: String) {
        upHasHappended[symbol] = false
        downAnimationFinished[symbol] = false
        withAnimation(.easeIn(duration: downTime)) {
            keyStatusColor[symbol] = keyColor.downColor(for: symbol, isPending: symbol == previouslyPendingOperator)
        }
        Task(priority: .userInitiated) {
            try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
            downAnimationFinished[symbol] = true
            if upHasHappended[symbol] ?? false {
                showUpColors(for: symbol)
            }
        }
    }
    
    func touchUp(of symbol: String, screen: Screen) {
        upHasHappended[symbol] = true
        if downAnimationFinished[symbol] ?? false {
            showUpColors(for: symbol)
        }
    }
    
//    func setPendingColors(for symbol: String) async {
//        if let previous = previouslyPendingOperator {
//            await MainActor.run() {
//                withAnimation(.easeIn(duration: downTime)) {
//                    keyStatusColor[previous] = keyColor.upColor(for: previous, isPending: false)
//                    textColor[previous] = keyColor.textColor(for: previous, isPending: false)
//                }
//            }
//        }
//        if ["/", "x", "-", "+", "x^y", "y^x", "y√"].contains(symbol) {
//            await MainActor.run() {
//                withAnimation(.easeIn(duration: downTime)) {
//                    keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: true)
//                    textColor[symbol] = keyColor.textColor(for: symbol, isPending: true)
//                    previouslyPendingOperator = symbol
//                }
//            }
//        } else {
//            previouslyPendingOperator = nil
//        }
//    }
    
//    func defaultTask(for symbol: String, screen: Screen) {
//        calculator.asResult(symbol)
//        refreshDisplay(screen: screen)
//        lastScreen = screen
//    }
    var lastScreen: Screen?
    func refreshDisplay() {
        if let lastScreen {
            refreshDisplay(screen: lastScreen)
        }
    }

    func refreshDisplay(screen: Screen) {
//        let tempDisplay = Display(displayNumber, screen: screen, separators: self.persistent, groupSize: translator.groupSize, forceScientific: false )
//        currentDisplay = tempDisplay
//        updateTranslation()
//        self.showAC = currentDisplay.isZero
    }

}
