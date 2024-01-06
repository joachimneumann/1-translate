//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI

@Observable class ViewModel: ShowAs {
    var showAC = true
    var keyStatusColor: [String: Color] = [:]
    var textColor: [String: Color] = [:]
    var currentDisplay: Display
    var _1ForDisplay: String = ""
    var _1ForDisplayOverline: String? = nil
    var _1ForCopy: String = ""
    var _1ForSpeaking: String? = ""
    var _2ForDisplay: String = ""
    var _2ForDisplayOverline: String? = nil
    var _2ForCopy: String = ""
    var _2ForSpeaking: String? = ""
    var persistent: Persistent
    var languages = Languages()

    var showAsInt = false /// This will update the "-> Int or -> sci button texts
    var showAsFloat = false
    private var stupidBrain = BrainEngine(precision: 1_000) /// I want to call fast sync functions
    private let keysThatRequireValidNumber = ["±", "%", "/", "x", "-", "+", "="]
    private static let MAX_DISPLAY_LEN = 10_000 /// too long strings in Text() crash the app
    private let keyColor = KeyColor()
    
    private var upHasHappended = false
    private var downAnimationFinished = false
    var voices: Voices = Voices()

    private enum KeyState {
        case notPressed
        case pressed
        case highPrecisionProcessing
        case highPrecisionProcessingDisabled
    }
    
    private var keyState: KeyState = .notPressed //{ didSet { print("keyState ->", keyState) } }
    private let downTime = 0.1
    private let upTime = 0.4
    private var displayNumber = Number("0", precision: 10)
    private var previouslyPendingOperator: String? = nil
            
    init() {
        persistent = Persistent()

        /// currentDisplay will be updated shortly by refreshDisplay in onAppear() of Calculator
        /// I set some values here
        currentDisplay = Display(left: "0", right: nil, canBeInteger: false, canBeFloat: false)

        for symbol in [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",",
            "C", "AC", "±", "%", "/", "x", "-", "+", "="] {
            keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: false)
            textColor[symbol] = keyColor.textColor(for: symbol, isPending: false)
        }
        keyStatusColor["plus"] = keyColor.upColor(for: "+", isPending: false)
        // print("viewModel init")
        voices.refreshVoiceDict(list: languages.list)
        updateTranslation()
    }
        
    func cleanSeperators(_ text: String) -> String {
        var ret = text
        if persistent.groupSeparator != .none {
            ret = ret.replacingOccurrences(of: persistent.groupSeparator.string, with: "")
        }
        if persistent.decimalSeparator != .dot {
            ret = ret.replacingOccurrences(of: persistent.decimalSeparator.string, with: ".")
        }
        return ret
    }

    func forCopy(_ text: String, _ overline: String?) -> String {
        let text = text.replacingOccurrences(of: Languages.WordSplitter, with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: Languages.WordSplitter, with: "")
        return "<overline>" + overline + "</overline>" + text
    }
    
    func forSpeaking(_ text: String) -> String {
        let text = text.replacingOccurrences(of: Languages.WordSplitter, with: " ")
        return text
    }
    
    func splitForDisplay(_ text: String) -> (String, String?) {
        guard text.contains(OVERLINE) else { return (text, nil) }
        let split = text.split(separator: OVERLINE)
        if split.count == 1 { return ("", String(split[0])) }
        if split.count == 2 { return (String(split[1]), String(split[0])) }
        return (text, nil)
    }
    

    func updateTranslation() {
        let allInOneLine = cleanSeperators(currentDisplay.allInOneLine)
        let translated = languages.first.read(allInOneLine)
        (_1ForDisplay, _1ForDisplayOverline) = splitForDisplay(translated)
        _1ForCopy = forCopy(_1ForDisplay, _1ForDisplayOverline)
        _1ForSpeaking = nil
        if  let code = languages.first.voiceLanguageCode {
            if voices.voiceDict[code] != nil {
                _1ForSpeaking = forSpeaking(_1ForDisplay)
                _1ForSpeaking = languages.first.speakingPostProcessing(_1ForSpeaking!)
            }
        }

        if languages.persistent.secondLanguageAllowed {
            let translated = languages.second.read(allInOneLine)
            (_2ForDisplay, _2ForDisplayOverline) = splitForDisplay(translated)
            _2ForCopy = forCopy(_2ForDisplay, _2ForDisplayOverline)
            _2ForSpeaking = forSpeaking(_2ForDisplay)
            _2ForSpeaking = nil
            if  let code = languages.second.voiceLanguageCode {
                if voices.voiceDict[code] != nil {
                    _2ForSpeaking = forSpeaking(_2ForDisplay)
                    _2ForSpeaking = languages.second.speakingPostProcessing(_2ForSpeaking!)
                }
            }
        }
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
    
    func showDownColors(for symbol: String) async {
        upHasHappended = false
        downAnimationFinished = false
        await MainActor.run {
            withAnimation(.easeIn(duration: downTime)) {
                keyStatusColor[symbol] = keyColor.downColor(for: symbol, isPending: symbol == previouslyPendingOperator)
            }
        }
        //print("down: downColor sleep START", downTime)
        try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
        //print("down: downColor sleep STOP")
        downAnimationFinished = true
        //print("down: upHasHappended", upHasHappended)
        if upHasHappended {
            await showUpColors(for: symbol)
        }
    }
    
    func showUpColors(for symbol: String) async {
        /// Set the background color back to normal
        await MainActor.run {
            withAnimation(.easeIn(duration: upTime)) {
                keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: symbol == previouslyPendingOperator)
            }
        }
    }
    
    func touchDown(for symbol: String) {
        //print("touchDown1 keyState =", keyState)
        if keyState == .highPrecisionProcessing {
            keyState = .highPrecisionProcessingDisabled
            Task(priority: .userInitiated) {
                await showDisabledColors(for: symbol)
            }
            return
        }
        
        Task(priority: .userInitiated) {
            let validOrAllowed = displayNumber.isValid || !keysThatRequireValidNumber.contains(symbol)
            //print("touchDown2 keyState =", keyState, "validOrAllowed =", validOrAllowed)
            guard keyState == .notPressed && validOrAllowed else {
                //keyState = .disabledPressed
                await showDisabledColors(for: symbol)
                return
            }
            await showDownColors(for: symbol)
        }
    }
    
    func touchUp(of symbol: String, screen: Screen) {
        if keyState == .highPrecisionProcessingDisabled {
            keyState = .notPressed
            /// this allows the user to try pressing a button again
            return
        }
        
        switch symbol {
        default:
            guard keyState == .notPressed else { return }
            
            let valid = displayNumber.isValid || !keysThatRequireValidNumber.contains(symbol)
            guard valid else { return }
            
            keyState = .pressed
            upHasHappended = true
            Task(priority: .high) {
                if downAnimationFinished {
                    await showUpColors(for: symbol)
                }
                await setPendingColors(for: symbol)
            }
            self.defaultTask(for: symbol, screen: screen)
            self.keyState = .notPressed
        }
    }
    
    func setPendingColors(for symbol: String) async {
        if let previous = previouslyPendingOperator {
            await MainActor.run() {
                withAnimation(.easeIn(duration: downTime)) {
                    keyStatusColor[previous] = keyColor.upColor(for: previous, isPending: false)
                    textColor[previous] = keyColor.textColor(for: previous, isPending: false)
                }
            }
        }
        if ["/", "x", "-", "+", "x^y", "y^x", "y√"].contains(symbol) {
            await MainActor.run() {
                withAnimation(.easeIn(duration: downTime)) {
                    keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: true)
                    textColor[symbol] = keyColor.textColor(for: symbol, isPending: true)
                    previouslyPendingOperator = symbol
                }
            }
        } else {
            previouslyPendingOperator = nil
        }
    }
    
    func defaultTask(for symbol: String, screen: Screen) {
        showAsInt = false
        showAsFloat = false
        
        keyState = .highPrecisionProcessing
        displayNumber = stupidBrain.operation(symbol)
        refreshDisplay(screen: screen)
    }
    
    func refreshDisplay(screen: Screen) {
        let tempDisplay = Display(displayNumber, screen: screen, separators: self.persistent, showAs: self, forceScientific: false )
        currentDisplay = tempDisplay
        updateTranslation()
        self.showAC = currentDisplay.isZero
    }

}
