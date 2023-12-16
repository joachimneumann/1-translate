//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI

protocol ShowAs {
    var showAsInt: Bool   { get }
    var showAsFloat: Bool { get }
}

struct AppStorageKeys {
    static let forceScientific                   = "forceScientific"
    static let decimalSeparator                  = "decimalSeparator"
    static let groupSeparator                    = "groupSeparator"
    static let secondLanguageAllowed             = "secondLanguageAllowed"
    static let firstLanguage                     = "firstLanguage"
    static let secondLanguage                    = "secondLanguage"
    static let activeIndex                       = "activeIndex"
    static let settingsEnglishUseAndAfterHundred = "settingsEnglishUseAndAfterHundred"
    static let settingsSpanishUsePunto           = "settingsSpanishUsePunto"
    static let settingsGermanCaptalisation       = "settingsGermanCaptalisation"
    static let settingsGermanSoftHyphen          = "settingsGermanSoftHyphen"
    static let settingsVietnameseThousand        = "settingsVietnameseThousand"
    static let settingsVietnameseSecondLast      = "settingsVietnameseSecondLast"
    static let settingsVietnameseCompact         = "settingsVietnameseCompact"
}

struct StringPreference {
    var previously: [String] = []
    mutating func add(new: String) {
        previously = previously.filter { $0 != new }
        previously.insert(new, at: 0)
    }
    
    func get(except notThis: String) -> String {
        for i in 0..<previously.count {
            if previously[i] != notThis {
                return previously[i]
            }
        }
        return ""
    }

}
class ViewModel: ObservableObject, ShowAs, Separators {
    @Published var showAsInt = false /// This will update the "-> Int or -> sci button texts
    @Published var showAsFloat = false
    @Published var isCopying: Bool = false
    @Published var isPasting: Bool = false
    @Published var showAC = true
    @Published var backgroundColor: [String: Color] = [:]
    @Published var textColor: [String: Color] = [:]
    @Published var currentDisplay: Display {
        didSet {
            updateTranslation()
        }
    }
    @Published var settingsEnglishExample: String = ""
    @Published var settingsGermanExample: String = ""
    @Published var settingsVietnameseExample: String = ""
    @Published var settingsSpanishExample: String = ""
    @Published var firstTranslatedNumber: String = ""
    @Published var secondTranslatedNumber: String = ""

    let translateEnglish = TranslateEnglish()
    let translateGerman = TranslateGerman()
    let translateVietnamese = TranslateVietnamese()
    let translateSpanish = TranslateSpanish()
    let translateCatalan = TranslateCatalan()
    let translatePolish = TranslatePolish()
    let translateDanish = TranslateDanish()
    let translateThai = TranslateThai()

    var translators: [BasicTranslator] // set in init()

    var previouslySelectedLanguages = StringPreference()
    
    func updateTranslation() {
        firstTranslatedNumber = firstTranslator.translate(currentDisplay.allInOneLine) ??  "?"
        secondTranslatedNumber = secondTranslator.translate(currentDisplay.allInOneLine) ??  "?"
    }
    /// I initialize the decimalSeparator with the locale preference, but
    /// I ignore the value of Locale.current.groupSeparator
    @AppStorage(AppStorageKeys.forceScientific, store: .standard)
    var forceScientific: Bool = false
    
    @AppStorage(AppStorageKeys.decimalSeparator, store: .standard)
    var decimalSeparator: DecimalSeparator = Locale.current.decimalSeparator == "," ? .comma : .dot {
        didSet {
            for translator in translators {
                translator.decimalSeparator = decimalSeparator.string
            }
        }
    }
    
    @AppStorage(AppStorageKeys.groupSeparator, store: .standard)
    var groupSeparator: GroupSeparator = .none {
        didSet {
            for translator in translators {
                translator.groupSeparator = groupSeparator.string
            }
        }
    }
    
    @AppStorage(AppStorageKeys.secondLanguageAllowed, store: .standard)
    var secondLanguageAllowed: Bool = false {
        didSet {
            if secondLanguageAllowed {
                /// make sure the first language is not the same
                if secondLanguage == firstLanguage {
                    // OOPS. Find a new second language
                    var substituteFound = false
                    for substituteTranslator in translators {
                        if !substituteFound && substituteTranslator.language != firstLanguage {
                            secondLanguage = substituteTranslator.language
                            substituteFound = true
                        }
                    }
                }
            }
        }
    }
    
    @AppStorage(AppStorageKeys.firstLanguage, store: .standard)
    var firstLanguage: String = "" { //translateEnglish.language {
        didSet {
            for translator in translators {
                if translator.language == firstLanguage {
                    firstTranslator = translator
                    updateTranslation()
                    previouslySelectedLanguages.add(new: translator.language)
                    /// is the second language the same?
                    if secondLanguageAllowed && (secondLanguage == translator.language) {
                        // OOPS. Find a new second language
                        secondLanguage = previouslySelectedLanguages.get(except: translator.language)
                    }
                }
            }
        }
    }

    @AppStorage(AppStorageKeys.secondLanguage, store: .standard)
    var secondLanguage: String = "" { //translateEnglish.language {
        didSet {
            for translator in translators {
                if translator.language == secondLanguage {
                    secondTranslator = translator
                    updateTranslation()
                    previouslySelectedLanguages.add(new: translator.language)
                    /// is the first language the same?
                    if firstLanguage == translator.language {
                        // OOPS. Find a new first language
                        firstLanguage = previouslySelectedLanguages.get(except: translator.language)
                    }
                }
            }
        }
    }
    
    @AppStorage(AppStorageKeys.settingsEnglishUseAndAfterHundred, store: .standard)
    var settingsEnglishUseAndAfterHundred: Bool = false {
        didSet {
            if settingsEnglishUseAndAfterHundred {
                translateEnglish.afterHundred = " and "
            } else {
                translateEnglish.afterHundred = " "
            }
            settingsEnglishExample = translateEnglish.translate(105)!
        }
    }

    @AppStorage(AppStorageKeys.settingsSpanishUsePunto, store: .standard)
    var settingsSpanishUsePunto: PuntoComma = .coma {
        didSet {
            translateSpanish.dotString = settingsSpanishUsePunto.rawValue
            // make sure that the selected decimal and group seperator do not mess up the example
            let tempSpanish = TranslateSpanish()
            tempSpanish.decimalSeparator = "."
            tempSpanish.groupSeparator = ""
            settingsSpanishExample = tempSpanish.translate(1.5) ?? "Error"
        }
    }


    @AppStorage(AppStorageKeys.settingsGermanCaptalisation)
    var settingsGermanCaptalisation: Bool = true {
        didSet {
            translateGerman.capitalisation = settingsGermanCaptalisation
            if let translatedExample = translateGerman.translate(88) {
                settingsGermanExample = translatedExample
            } else {
                settingsGermanExample = "Error"
            }
        }
    }

    @AppStorage(AppStorageKeys.settingsGermanSoftHyphen)
    var settingsGermanSoftHyphen: Bool = false {
        didSet {
            translateGerman.useSoftHyphen = settingsGermanSoftHyphen
            if let translatedExample = translateGerman.translate(88) {
                settingsGermanExample = translatedExample
            } else {
                settingsGermanExample = "Error"
            }
        }
    }

    
    @AppStorage(AppStorageKeys.settingsVietnameseThousand)
    var settingsVietnameseThousand: VietnameseThousand = .nghìn {
        didSet {
            translateVietnamese.thousand = settingsVietnameseThousand
            if let translatedExample = translateVietnamese.translate(303333) {
                settingsVietnameseExample = translatedExample
            } else {
                settingsVietnameseExample = "Error"
            }
        }
    }
    
    @AppStorage(AppStorageKeys.settingsVietnameseSecondLast)
    var settingsVietnameseSecondLast: VietnameseSecondLast = .lẻ {
        didSet {
            translateVietnamese.secondLast = settingsVietnameseSecondLast
            if let translatedExample = translateVietnamese.translate(303333) {
                settingsVietnameseExample = translatedExample
            } else {
                settingsVietnameseExample = "Error"
            }
        }
    }
    
    @AppStorage(AppStorageKeys.settingsVietnameseCompact)
    var settingsVietnameseCompact: Bool = false {
        didSet {
            translateVietnamese.compact = settingsVietnameseCompact
            if let translatedExample = translateVietnamese.translate(303333) {
                settingsVietnameseExample = translatedExample
            } else {
                settingsVietnameseExample = "Error"
            }
        }
    }
        
    @Published var firstTranslator: BasicTranslator
    @Published var secondTranslator: BasicTranslator

    var precisionDescription = "unknown"
    var showPrecision: Bool = false
    var secondActive = false
    
    @AppStorage("precision", store: .standard) private (set) var precision: Int = 1000
    @AppStorage("rad", store: .standard) var rad: Bool = false
    
    private let brain: Brain /// initialized later with _precision.wrappedValue
    private var stupidBrain = BrainEngine(precision: 100) /// I want to call fast sync functions
    
    private let keysThatRequireValidNumber = ["±", "%", "/", "x", "-", "+", "=", "( ", " )", "m+", "m-", "x^2", "x^3", "x^y", "e^x", "y^x", "2^x", "10^x", "One_x", "√", "3√", "y√", "logy", "ln", "log2", "log10", "x!", "sin", "cos", "tan", "asin", "acos", "atan", "EE", "sinh", "cosh", "tanh", "asinh", "acosh", "atanh"]
    private static let MAX_DISPLAY_LEN = 10_000 /// too long strings in Text() crash the app
    private let keyColor = KeyColor()
    
    private var upHasHappended = false
    private var downAnimationFinished = false
    
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
        /// currentDisplay will be updated shortly by refreshDisplay in onAppear() of Calculator
        /// I set some values here
        currentDisplay = Display(left: "0", right: nil, canBeInteger: false, canBeFloat: false)
        brain = Brain(precision: _precision.wrappedValue)
        precisionDescription = _precision.wrappedValue.useWords
        
        translators = [
            translateEnglish,
            translateGerman,
            translateVietnamese,
            translateSpanish,
            translateCatalan,
            translatePolish,
            translateDanish,
            translateThai]
        firstTranslator = translateEnglish
        secondTranslator = translateEnglish

        for translator in translators {
            if translator.language == firstLanguage {
                firstTranslator = translator
            }
            if translator.language == secondLanguage {
                secondTranslator = translator
            }
            previouslySelectedLanguages.add(new: translator.language)
        }

        for symbol in [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",",
            "C", "AC", "±", "%", "/", "x", "-", "+", "=",
            "( ", " )", "mc", "m+", "m-", "mr",
            "2nd", "x^2", "x^3", "x^y", "e^x", "y^x", "2^x", "10^x",
            "One_x", "√", "3√", "y√", "logy", "ln", "log2", "log10",
            "x!", "sin", "cos", "tan", "asin", "acos", "atan", "e", "EE",
            "Deg", "Rad", "sinh", "cosh", "tanh", "asinh", "acosh", "atanh", "π", "Rand"] {
            backgroundColor[symbol] = keyColor.upColor(for: symbol, isPending: false)
            textColor[symbol] = keyColor.textColor(for: symbol, isPending: false)
        }
        backgroundColor["plus"] = keyColor.upColor(for: "+", isPending: false)
        
        /// trigger the didSet action of the persistently stored variables
        groupSeparator = groupSeparator
        decimalSeparator = decimalSeparator
        settingsEnglishUseAndAfterHundred = settingsEnglishUseAndAfterHundred
        settingsVietnameseCompact = settingsVietnameseCompact
        settingsGermanCaptalisation = settingsGermanCaptalisation
        settingsSpanishUsePunto = settingsSpanishUsePunto
    }
        
    /// the update of the precision in brain can be slow.
    /// Therefore, I only want to do that when leaving the settings screen
    func updatePrecision(to newPrecision: Int) async {
        await MainActor.run {
            precision = newPrecision
            precisionDescription = self.precision.useWords
        }
        let _ = await brain.setPrecision(newPrecision)
        
        /// also change the precision in the displayNumber
        let new = Number("0", precision: newPrecision)
        new.setValue(other: displayNumber)
        await MainActor.run {
            displayNumber = new
        }
    }
    
    ///  To give a clear visual feedback to the user that the button has been pressed,
    ///  the animation will always wait for the downAnimation to finish
    func showDisabledColors(for symbol: String) async {
        await MainActor.run {
            withAnimation(.easeIn(duration: downTime)) {
                backgroundColor[symbol] = keyColor.disabledColor
            }
        }
        try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
        await MainActor.run {
            withAnimation(.easeIn(duration: upTime)) {
                backgroundColor[symbol] = keyColor.upColor(for: symbol, isPending: symbol == previouslyPendingOperator)
            }
        }
    }
    
    func showDownColors(for symbol: String) async {
        upHasHappended = false
        downAnimationFinished = false
        await MainActor.run {
            withAnimation(.easeIn(duration: downTime)) {
                backgroundColor[symbol] = keyColor.downColor(for: symbol, isPending: symbol == previouslyPendingOperator)
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
                backgroundColor[symbol] = keyColor.upColor(for: symbol, isPending: symbol == previouslyPendingOperator)
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
        
        let calculatorSymbol = ["sin", "cos", "tan", "asin", "acos", "atan"].contains(symbol) && !rad ? symbol+"D" : symbol
        switch symbol {
        case "2nd":
            secondActive.toggle()
            backgroundColor["2nd"] = keyColor.secondColor(active: secondActive)
        case "Rad":
            rad = true
            Task(priority: .high) {
                await showUpColors(for: symbol)
            }
            showPrecision = false
        case "Deg":
            rad = false
            Task(priority: .high) {
                await showUpColors(for: symbol)
            }
            showPrecision = false
        default:
            guard keyState == .notPressed else { return }
            
            let valid = displayNumber.isValid || !keysThatRequireValidNumber.contains(symbol)
            guard valid else { return }
            
            if symbol == "AC" {
                showPrecision.toggle()
            } else {
                showPrecision = false
            }
            
            keyState = .pressed
            upHasHappended = true
            Task(priority: .high) {
                if downAnimationFinished {
                    await showUpColors(for: symbol)
                }
                await setPendingColors(for: symbol)
            }
            Task.detached(priority: .low) {
                await self.defaultTask(for: calculatorSymbol, screen: screen)
                self.keyState = .notPressed
            }
        }
    }
    
    func setPendingColors(for symbol: String) async {
        if let previous = previouslyPendingOperator {
            await MainActor.run() {
                withAnimation(.easeIn(duration: downTime)) {
                    backgroundColor[previous] = keyColor.upColor(for: previous, isPending: false)
                    textColor[previous] = keyColor.textColor(for: previous, isPending: false)
                }
            }
        }
        if ["/", "x", "-", "+", "x^y", "y^x", "y√"].contains(symbol) {
            await MainActor.run() {
                withAnimation(.easeIn(duration: downTime)) {
                    backgroundColor[symbol] = keyColor.upColor(for: symbol, isPending: true)
                    textColor[symbol] = keyColor.textColor(for: symbol, isPending: true)
                    previouslyPendingOperator = symbol
                }
            }
        } else {
            previouslyPendingOperator = nil
        }
    }
    
    func defaultTask(for symbol: String, screen: Screen) async {
        
        await MainActor.run() {
            showAsInt = false
            showAsFloat = false
        }
        
        keyState = .highPrecisionProcessing
        displayNumber = await brain.operation(symbol)
        await refreshDisplay(screen: screen)
    }
    
    func refreshDisplaySync(screen: Screen) {
        Task {
            await refreshDisplay(screen: screen)
        }
    }
    
    func refreshDisplay(screen: Screen) async {
        let tempDisplay = Display(displayNumber, screen: screen, separators: self, showAs: self, forceScientific: forceScientific)
        await MainActor.run() {
            currentDisplay = tempDisplay
            self.showAC = currentDisplay.isZero
            firstTranslatedNumber = firstTranslator.translate(currentDisplay.allInOneLine) ??  "?"
            secondTranslatedNumber = secondTranslator.translate(currentDisplay.allInOneLine) ??  "?"
        }
    }
    
    func copyFromPasteBin(screen: Screen) async -> Bool {
        //        if UIPasteboard.general.hasStrings {
        //            if let pasteString = UIPasteboard.general.string {
        //                print("pasteString", pasteString, pasteString.count)
        //                if pasteString.count > 0 {
        //                    if Gmp.isValidGmpString(pasteString, bits: 1000) {
        //                        displayNumber = await brain.replaceLast(withString: pasteString)
        //                        await refreshDisplay(screen: screen)
        //                        return true
        //                    }
        //                }
        //            }
        //        }
        return false
    }
    
    func copyToPastBin(screen: Screen) async {
        //        let copyData = Display(displayNumber, screen: screen, noLimits: true, showAs: self, forceScientific: screen.forceScientific)
        //        UIPasteboard.general.string = copyData.allInOneLine
    }
}
