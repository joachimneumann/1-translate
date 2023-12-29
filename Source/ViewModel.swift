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
    static let forceScientificKey                   = "forceScientificKey"
    static let decimalSeparatorKey                  = "decimalSeparatorKey"
    static let groupSeparatorKey                    = "groupSeparatorKey"
    static let groupSizeKey                         = "groupSizeKey"
    static let secondLanguageAllowedKey             = "secondLanguageAllowedKey"
    static let firstLanguageKey                     = "firstLanguageKey"
    static let secondLanguageKey                    = "secondLanguageKey"
    static let settingsEnglishUseAndAfterHundredKey = "settingsEnglishUseAndAfterHundredKey"
    static let settingsSpanishUsePuntoKey           = "settingsSpanishUsePuntoKey"
    static let settingsGermanCaptalisationKey       = "settingsGermanCaptalisationKey"
    static let settingsGermanWordSplitterKey        = "settingsGermanWordSplitterKey"
    static let settingsVietnameseThousandKey        = "settingsVietnameseThousandKey"
    static let settingsVietnameseSecondLastKey      = "settingsVietnameseSecondLastKey"
    static let settingsVietnameseCompactKey         = "settingsVietnameseCompactKey"
}

struct StringPreference {
    var previously: [String] = []
    mutating func add(new: String) {
        previously = previously.filter { $0 != new }
        previously.insert(new, at: 0)
//        print("add: ") for p in previously { print(" "+p) }
    }
    
    func get(except notThis: String) -> String {
        for i in 0..<previously.count {
            if previously[i] != notThis {
                return previously[i]
            }
        }
//        print("get: ") for p in previously { print(" "+p) }
        return ""
    }
    
}

class ViewModel: ObservableObject, ShowAs, Separators {
    @Published var showAC = true
    @Published var keyStatusColor: [String: Color] = [:]
    @Published var textColor: [String: Color] = [:]
    @Published var currentDisplay: Display 
    @Published var firstTranslatedNumber: String = ""
    @Published var secondTranslatedNumber: String = ""
    @Published var firstHasVoice: Bool = false
    @Published var secondHasVoice: Bool = false
    @Published var forCopyFirstTranslatedNumber: String = ""
    @Published var firstTranslatedNumberTopBorder: String? = nil
    @Published var secondTranslatedNumberTopBorder: String? = nil
    @Published var forCopySecondTranslatedNumber: String = ""

    var showAsInt = false /// This will update the "-> Int or -> sci button texts
    var showAsFloat = false

    var languageNameList: [String] {
        var ret: [String] = []
        for l in languages.list {
            ret.append(l.name)
        }
        return ret
    }
    
    var indexOfFirstLanguage: Int? = 0 {
        didSet {
            if let index = indexOfFirstLanguage {
                newFirstLanguage(languages.list[index])
            }
        }
    }
    var indexOfSecondLanguage: Int? = 0 {
        didSet {
            if let index = indexOfSecondLanguage {
                newSecondLanguage(languages.list[index])
            }
        }
    }

    let languages = Languages()
    var voice = Voice()

    var previouslySelectedLanguages = StringPreference()
    var firstFont: Font {
        switch firstLanguage.flagName {
        case languages.arabicNumerals.flagName:
            Font(UIFont(name: "Avenir", size: secondLanguageAllowed ? 40 : 50)!)
        default:
            secondLanguageAllowed ? Font.title : Font.largeTitle
        }
    }
    var secondFont: Font {
        switch firstLanguage.flagName {
        case languages.arabicNumerals.flagName:
            Font(UIFont(name: "Avenir", size: 40)!)
        default:
            Font.title
        }
    }
    
    func updateTranslation() {
        // print("update translations")
        var allInOneLine = currentDisplay.allInOneLine
        if groupSeparator != .none {
            allInOneLine = allInOneLine.replacingOccurrences(of: groupSeparator.string, with: "")
        }
        if decimalSeparator != .dot {
            allInOneLine = allInOneLine.replacingOccurrences(of: decimalSeparator.string, with: ".")
        }
        firstTranslatedNumber = firstLanguage.read(allInOneLine)
        firstTranslatedNumberTopBorder = nil
        if firstTranslatedNumber.contains(OVERLINE) {
            let split = firstTranslatedNumber.split(separator: OVERLINE)
            firstTranslatedNumberTopBorder = String(split[0])
            if split.count == 2 {
                firstTranslatedNumber = String(split[1])
            } else {
                firstTranslatedNumber = ""
            }
        }
        forCopyFirstTranslatedNumber = (firstTranslatedNumberTopBorder != nil ? "<overline>" + firstTranslatedNumberTopBorder! + "</overline>" : "") + firstTranslatedNumber
        forCopyFirstTranslatedNumber = forCopyFirstTranslatedNumber.replacingOccurrences(of: Languages.WordSplitter, with: "")

        if secondLanguageAllowed {
            secondTranslatedNumber = secondLanguage.read(allInOneLine)
            secondTranslatedNumberTopBorder = nil
            if secondTranslatedNumber.contains(OVERLINE) {
                let split = secondTranslatedNumber.split(separator: OVERLINE)
                secondTranslatedNumberTopBorder = String(split[0])
                if split.count == 2 {
                    secondTranslatedNumber = String(split[1])
                } else {
                    secondTranslatedNumber = ""
                }
            }
            forCopySecondTranslatedNumber = (secondTranslatedNumberTopBorder != nil ? "<overline>" + secondTranslatedNumberTopBorder! + "</overline>" : "") + secondTranslatedNumber
            forCopySecondTranslatedNumber = forCopySecondTranslatedNumber.replacingOccurrences(of: Languages.WordSplitter, with: "")
        }
        
        firstHasVoice = voice.has(firstLanguage.code)
        secondHasVoice = voice.has(secondLanguage.code)
    }
    /// I initialize the decimalSeparator with the locale preference, but
    /// I ignore the value of Locale.current.groupSeparator
    @AppStorage(AppStorageKeys.forceScientificKey, store: .standard)
    var forceScientific: Bool = false
    
    @AppStorage(AppStorageKeys.decimalSeparatorKey, store: .standard)
    var decimalSeparator: DecimalSeparator = Locale.current.decimalSeparator == "," ? .comma : .dot
    
    @AppStorage(AppStorageKeys.groupSeparatorKey, store: .standard)
    var groupSeparator: GroupSeparator = .none
    
    @AppStorage(AppStorageKeys.groupSeparatorKey, store: .standard)
    var groupSize: GroupSize = .three
    
    @AppStorage(AppStorageKeys.secondLanguageAllowedKey, store: .standard)
    var secondLanguageAllowed: Bool = false
    
    @AppStorage(AppStorageKeys.firstLanguageKey, store: .standard)
    var firstLanguageName: String = "English"
    
    @AppStorage(AppStorageKeys.secondLanguageKey, store: .standard)
    var secondLanguageName: String = "German"
    
    @AppStorage(AppStorageKeys.settingsEnglishUseAndAfterHundredKey, store: .standard)
    var settingsEnglishUseAndAfterHundred: Bool = false {
        didSet {
            languages.english.useAndAfterHundred = settingsEnglishUseAndAfterHundred
        }
    }
    
    @AppStorage(AppStorageKeys.settingsSpanishUsePuntoKey, store: .standard)
    var settingsSpanishUsePunto: SpanishImpl.PuntoComma = .coma {
        didSet {
            languages.spanish.puntoComma = settingsSpanishUsePunto
        }
    }
    
    
    @AppStorage(AppStorageKeys.settingsGermanCaptalisationKey)
    var settingsGermanCaptalisation: Bool = true {
        didSet {
            languages.german.capitalisation = settingsGermanCaptalisation
        }
    }
    
    @AppStorage(AppStorageKeys.settingsGermanWordSplitterKey)
    var settingsGermanWordSplitter: Bool = true {
        didSet {
            languages.german.useWordSplitter = settingsGermanWordSplitter
        }
    }
    
    
    @AppStorage(AppStorageKeys.settingsVietnameseThousandKey)
    var settingsVietnameseThousand: VietnameseImpl.Thousand = .nghìn {
        didSet {
            languages.vietnamese.thousand = settingsVietnameseThousand
        }
    }
    
    @AppStorage(AppStorageKeys.settingsVietnameseSecondLastKey)
    var settingsVietnameseSecondLast: VietnameseImpl.SecondLast = .lẻ {
        didSet {
            languages.vietnamese.secondLast = settingsVietnameseSecondLast
        }
    }
    
    @AppStorage(AppStorageKeys.settingsVietnameseCompactKey)
    var settingsVietnameseCompact: Bool = false {
        didSet {
            languages.vietnamese.compact = settingsVietnameseCompact
        }
    }
    
    @Published var firstLanguage: Language = EnglishImpl() {
        didSet {
            updateTranslation()
            firstLanguageName  = firstLanguage.name
        }
    }
    @Published var secondLanguage: Language = GermanImpl() {
        didSet {
            updateTranslation()
            secondLanguageName = secondLanguage.name
        }
    }

    func newFirstLanguage(_ newLanguage: Language) {
        // print("newFirstLanguage: " + newLanguage.name)
        firstLanguage = newLanguage
        previouslySelectedLanguages.add(new: newLanguage.name)
        if secondLanguage.name == newLanguage.name {
            /// find a different second language
            let newLanguageName = previouslySelectedLanguages.get(except: newLanguage.name)
            if newLanguageName != "" {
                for newLanguage in languages.list {
                    if newLanguage.name == newLanguageName {
                        secondLanguage = newLanguage
                    }
                }
            }
            firstLanguageName  = firstLanguage.name
            secondLanguageName = secondLanguage.name
            for index in 0..<languages.list.count {
                if firstLanguageName == languages.list[index].name {
                    indexOfFirstLanguage = index
                }
                if secondLanguageName == languages.list[index].name {
                    indexOfSecondLanguage = index
                }
            }
        }
    }

    func newSecondLanguage(_ newLanguage: Language) {
        // print("newSecondLanguage: " + newLanguage.name)
        secondLanguage = newLanguage
        previouslySelectedLanguages.add(new: secondLanguage.name)
        if firstLanguage.name == secondLanguage.name {
        /// find a different first language
            let newLanguageName = previouslySelectedLanguages.get(except: secondLanguage.name)
            if newLanguageName != "" {
                for newLanguage in languages.list {
                    if newLanguage.name == newLanguageName {
                        firstLanguage = newLanguage
                    }
                }
            }
            firstLanguageName  = firstLanguage.name
            secondLanguageName = secondLanguage.name
            for index in 0..<languages.list.count {
                if firstLanguageName == languages.list[index].name {
                    indexOfFirstLanguage = index
                }
                if secondLanguageName == languages.list[index].name {
                    indexOfSecondLanguage = index
                }
            }
        }
    }
        
    private var stupidBrain = BrainEngine(precision: 1_000) /// I want to call fast sync functions
    
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

    var initVoiceDone = false
    func initVoice() {
        if !initVoiceDone {
            var languageCodes: [String] = []
            for l in languages.list {
                if let code = l.code {
                    if (!languageCodes.contains(code)) {
                        languageCodes.append(code)
                    }
                }
            }
            voice.getVoicesFor(languages: languageCodes)
            voice.initDoneCallback = updateTranslation
            initVoiceDone = true
        }
    }
    init() {
        /// currentDisplay will be updated shortly by refreshDisplay in onAppear() of Calculator
        /// I set some values here
        currentDisplay = Display(left: "0", right: nil, canBeInteger: false, canBeFloat: false)

        // random preferences
        previouslySelectedLanguages.add(new: languages.english.name)
        previouslySelectedLanguages.add(new: languages.german.name)
        previouslySelectedLanguages.add(new: languages.spanish.name)
        previouslySelectedLanguages.add(new: secondLanguageName)
        previouslySelectedLanguages.add(new: firstLanguageName)


        for symbol in [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",",
            "C", "AC", "±", "%", "/", "x", "-", "+", "="] {
            keyStatusColor[symbol] = keyColor.upColor(for: symbol, isPending: false)
            textColor[symbol] = keyColor.textColor(for: symbol, isPending: false)
        }
        keyStatusColor["plus"] = keyColor.upColor(for: "+", isPending: false)
        // print("viewModel init")
        for index in 0..<languages.list.count {
            if secondLanguageName == languages.list[index].name {
                indexOfSecondLanguage = index
                newSecondLanguage(languages.list[index])
            }
            if firstLanguageName == languages.list[index].name {
                indexOfFirstLanguage = index
                newFirstLanguage(languages.list[index])
            }
        }
        groupSeparator = groupSeparator
        decimalSeparator = decimalSeparator

        // get the AppStorage values into the languages
        settingsEnglishUseAndAfterHundred = settingsEnglishUseAndAfterHundred
        settingsVietnameseCompact = settingsVietnameseCompact
        settingsVietnameseThousand = settingsVietnameseThousand
        settingsVietnameseSecondLast = settingsVietnameseSecondLast
        settingsGermanCaptalisation = settingsGermanCaptalisation
        settingsGermanWordSplitter = settingsGermanWordSplitter
        settingsSpanishUsePunto = settingsSpanishUsePunto
        
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
            Task.detached(priority: .low) {
                await self.defaultTask(for: symbol, screen: screen)
                self.keyState = .notPressed
            }
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
    
    func defaultTask(for symbol: String, screen: Screen) async {
        await MainActor.run() {
            showAsInt = false
            showAsFloat = false
        }
        
        keyState = .highPrecisionProcessing
        displayNumber = stupidBrain.operation(symbol)
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
            updateTranslation()
            self.showAC = currentDisplay.isZero
        }
    }
    
}
