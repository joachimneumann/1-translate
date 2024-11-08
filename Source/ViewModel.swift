//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

@Observable class ViewModel {
    let screen: Screen
    var persistent = Persistent()
    var calculator: Calculator
    var display: Display
    var currentLanguageName: String
    var currentLanguageEnglishName: String?
    var translationManager: TranslationManager
    var translatorKeyboard: TranslatorKeyboard
    var languageSelectorKeyboard: LanguageSelectorKeyboard
    var selectedLanguageKeyboard: SelectedLanguagekeyboard
    let monoFontDisplay: MonoFontDisplay
    var showLanguageSelector: Bool = false
    var navigateToSettings: Bool = false
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            var withGrouping: String = calculator.displayBuffer
            print("withGrouping 1: \(withGrouping)")
            print("separatorCharacter: \(display.separatorCharacter)")
            print("groupingCharacter: \(display.groupingCharacter == nil ? "nil" : String(display.groupingCharacter!))")
            withGrouping.inject(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
            print("withGrouping 2: \(withGrouping)")
            if display.fits(withGrouping) {
                display.left = withGrouping
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                display.left.inject(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                if var right = display.right {
                    right.inject(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            display.left.inject(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        }
        
        translatorKeyboard.back(calculator.privateDisplayBufferHasDigits)

        var toTranslate = display.string
        toTranslate.remove(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        translationManager.translateThis(toTranslate, to: persistent.currentLanguageEnum)
    }
    
    func toggleLanguageSelector(key: Key) {
        showLanguageSelector.toggle()
    }
    
    func decimalSeparator(for languageCode: String, countryCode: String? = nil) -> String? {
        var localeIdentifier = languageCode
        
        // Append the country code if it's provided and not empty
        if let countryCode = countryCode, !countryCode.isEmpty {
            if !localeIdentifier.isEmpty {
                localeIdentifier += "_"
            }
            localeIdentifier += countryCode
        }
        
        // Use Locale.current if both codes are missing
        let locale: Locale = Locale(identifier: localeIdentifier)
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter.decimalSeparator
    }

        
    func separatorCharacter(forLanguage language: NumberTranslator.LanguageEnum) -> Character {
        if let code = translationManager.code(language) {
            if let separator = decimalSeparator(for: code) {
                return Character(separator)
            }
        }
        return "."
    }
    func groupingCharacter(forLanguage language: NumberTranslator.LanguageEnum) -> Character? {
        if persistent.showGrouping {
            if separatorCharacter(forLanguage: language) == "." {
                return ","
            } else {
                return "."
            }
        } else {
            return nil
        }
    }

    func execute(_ key: Key) {
        if let flagKey = key as? FlagKey {
            if let newLanguage = translationManager.languageEnum(forFlagname: flagKey.flagname) {
                persistent.currentLanguageEnum = newLanguage
                currentLanguageName = translationManager.name(persistent.currentLanguageEnum)
                currentLanguageEnglishName = translationManager.englishName(persistent.currentLanguageEnum)
                translatorKeyboard.countryKey.flagname = flagKey.flagname
                selectedLanguageKeyboard.countryKey.flagname = flagKey.flagname
                display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
                display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
                translatorKeyboard.setSeparatorSymbol(String(display.separatorCharacter))
                translationManager.translateThis(display.string, to: persistent.currentLanguageEnum)
                process()
                return
            }
        }
        
        if let symbolKey = key as? SymbolKey {
            if symbolKey.op.isEqual(to: ConfigOperation.settings) {
                navigateToSettings = true  // Trigger navigation
                return
            }
            calculator.press(symbolKey.op)
            for row in translatorKeyboard.keyMatrix {
                for k in row {
                    if let symbolKey = k as? SymbolKey {
                        if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.op) }) {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).pendingUpColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).pendingDownColor)
                        } else {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).upColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).downColor)
                        }
                    }
                }
            }
            process()
        }
    }
    
    //    private(set) var _voices: Voices!
    //
    //
    //    var voices: Voices {
    //        return _voices
    //    }
    
    init(screen: Screen = Screen()) {
        currentLanguageName = ""
        currentLanguageEnglishName = nil
        self.screen = screen
        let tempTranslationManager = TranslationManager()
        
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        monoFontDisplay = MonoFontDisplay(displayWidth: 10)
        selectedLanguageKeyboard = SelectedLanguagekeyboard(keySize: screen.keySize)
        languageSelectorKeyboard = LanguageSelectorKeyboard(keySize: screen.keySize, translationManager: tempTranslationManager)
        
        translationManager = tempTranslationManager

        translatorKeyboard = TranslatorKeyboard(keySize: screen.keySize)
        display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
        display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
        translatorKeyboard.setSeparatorSymbol(String(display.separatorCharacter))

        translatorKeyboard.callback = execute
        languageSelectorKeyboard.callback = execute
        selectedLanguageKeyboard.callback = execute
        
        translatorKeyboard.countryKey.callback = toggleLanguageSelector
        translatorKeyboard.countryKey.flagname = translationManager.flagname(persistent.currentLanguageEnum)
        selectedLanguageKeyboard.countryKey.callback = toggleLanguageSelector
        selectedLanguageKeyboard.countryKey.flagname = translationManager.flagname(persistent.currentLanguageEnum)

        process()
    }
    
}
