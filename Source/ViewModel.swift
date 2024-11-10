//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class ViewModel: ObservableObject {
    var screen: Screen
    @Published var persistent = Translate_1Persistent()
    var calculator: Calculator
    @Published var display: Display
    @Published var currentLanguageName: String
    var currentLanguageEnglishName: String?
    @Published var translate_1Manager: Translate_1Manager
    var translate_1Keyboard: Translate_1Keyboard
    var translate_1LanguageSelectorKeyboard: Translate_1LanguageSelectorKeyboard
    var translate_1SelectedLanguagekeyboard: Translate_1SelectedLanguagekeyboard
    @Published var showLanguageSelector: Bool = false
    @Published var showSettings: Bool = false

    private(set) var _voices: Translate_1Voices!
    var voices: Translate_1Voices {
        return _voices
    }

    func process() {
        display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
        display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
        if calculator.displayBuffer.count > 0 {
            var withGrouping: String = calculator.displayBuffer
            inject(into: &withGrouping, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
            if display.fits(withGrouping) {
                display.left = withGrouping
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                if var right = display.right {
                    inject(into: &right, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        }
        
        translate_1Keyboard.back(calculator.privateDisplayBufferHasDigits)
        
        var toTranslate = display.string
        toTranslate.remove(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        translate_1Manager.translateThis(toTranslate, to: persistent.currentLanguageEnum)
    }
    
    func didReturnFromSettings() {
        
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
        if let code = translate_1Manager.code(language) {
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
        if let flagKey = key as? Translate_1FlagKey {
            if let newLanguage = translate_1Manager.languageEnum(forFlagname: flagKey.flagname) {
                persistent.currentLanguageEnum = newLanguage
                currentLanguageName = translate_1Manager.name(persistent.currentLanguageEnum)
                currentLanguageEnglishName = translate_1Manager.englishName(persistent.currentLanguageEnum)
                translate_1Keyboard.countryKey.flagname = flagKey.flagname
                translate_1SelectedLanguagekeyboard.countryKey.flagname = flagKey.flagname
                display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
                display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
                translate_1Keyboard.setSeparatorSymbol(String(display.separatorCharacter))
                translate_1Manager.translateThis(display.string, to: persistent.currentLanguageEnum)
                process()
                return
            }
        }
        
        if let symbolKey = key as? SymbolKey {
            if symbolKey.op.isEqual(to: Translate_1Operation.settings) {
                showSettings = true  // Trigger navigation
                return
            }
            calculator.press(symbolKey.op)
            for row in translate_1Keyboard.keyMatrix {
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
        
    init(screen: Screen = Screen()) {
        currentLanguageName = ""
        currentLanguageEnglishName = nil
        self.screen = screen
        let tempTranslate_1Manager = Translate_1Manager()
        
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        translate_1SelectedLanguagekeyboard = Translate_1SelectedLanguagekeyboard(keySize: screen.keySize)
        translate_1LanguageSelectorKeyboard = Translate_1LanguageSelectorKeyboard(keySize: screen.keySize, translate_1Manager: tempTranslate_1Manager)
        
        translate_1Manager = tempTranslate_1Manager

        translate_1Keyboard = Translate_1Keyboard(keySize: screen.keySize)
        display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
        display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
        translate_1Keyboard.setSeparatorSymbol(String(display.separatorCharacter))

        translate_1Keyboard.callback = execute
        translate_1LanguageSelectorKeyboard.callback = execute
        translate_1SelectedLanguagekeyboard.callback = execute
        
        translate_1Keyboard.countryKey.callback = toggleLanguageSelector
        translate_1Keyboard.countryKey.flagname = translate_1Manager.flagname(persistent.currentLanguageEnum)
        translate_1SelectedLanguagekeyboard.countryKey.callback = toggleLanguageSelector
        translate_1SelectedLanguagekeyboard.countryKey.flagname = translate_1Manager.flagname(persistent.currentLanguageEnum)

        process()
    }
    
}
