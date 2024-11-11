//
//  Translate_1ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class Translate_1ViewModel: ViewModel {
    @Published var translate_1Persistent = Translate_1Persistent()
    @Published var currentLanguageName: String
    var currentLanguageEnglishName: String?
    @Published var translate_1Manager: Translate_1Manager
    var translate_1Keyboard: Translate_1Keyboard
    var translate_1LanguageSelectorKeyboard: Translate_1LanguageSelectorKeyboard
    var translate_1SelectedLanguagekeyboard: Translate_1SelectedLanguagekeyboard
    @Published var showLanguageSelector: Bool = false
    @Published var showLanguage_1Settings: Bool = false

    private(set) var _voices: Translate_1Voices!
    var voices: Translate_1Voices {
        return _voices
    }

    func toggleLanguageSelector(key: Key) {
        showLanguageSelector.toggle()
    }
    

    override func process() {
        super.process()
        var toTranslate = display.string
        toTranslate.remove(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        translate_1Manager.translateThis(toTranslate, to: translate_1Persistent.currentLanguageEnum)
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
        if translate_1Persistent.showGrouping {
            if separatorCharacter(forLanguage: language) == "." {
                return ","
            } else {
                return "."
            }
        } else {
            return nil
        }
    }

    override func execute(_ key: Key) {
        if let flagKey = key as? Imagekey {
            if let newLanguage = translate_1Manager.languageEnum(forFlagname: flagKey.imageName) {
                translate_1Persistent.currentLanguageEnum = newLanguage
                currentLanguageName = translate_1Manager.name(translate_1Persistent.currentLanguageEnum)
                currentLanguageEnglishName = translate_1Manager.englishName(translate_1Persistent.currentLanguageEnum)
                translate_1Keyboard.countryKey.imageName = flagKey.imageName
                translate_1SelectedLanguagekeyboard.countryKey.imageName = flagKey.imageName
                display.separatorCharacter = separatorCharacter(forLanguage: translate_1Persistent.currentLanguageEnum)
                display.groupingCharacter = groupingCharacter(forLanguage: translate_1Persistent.currentLanguageEnum)
                translate_1Keyboard.setSeparatorSymbol(String(display.separatorCharacter))
                translate_1Manager.translateThis(display.string, to: translate_1Persistent.currentLanguageEnum)
                process()
                return
            }
        }
        
        super.execute(key)
    }
        
    override init(screen: Screen = Screen()) {
        currentLanguageName = ""
        currentLanguageEnglishName = nil
        let tempTranslate_1Manager = Translate_1Manager()
        
        translate_1SelectedLanguagekeyboard = Translate_1SelectedLanguagekeyboard(keySize: screen.keySize)
        translate_1LanguageSelectorKeyboard = Translate_1LanguageSelectorKeyboard(keySize: screen.keySize, translate_1Manager: tempTranslate_1Manager)
        
        translate_1Manager = tempTranslate_1Manager

        translate_1Keyboard = Translate_1Keyboard(keySize: screen.keySize)

        super.init(screen: screen)

        display.separatorCharacter = separatorCharacter(forLanguage: translate_1Persistent.currentLanguageEnum)
        display.groupingCharacter = groupingCharacter(forLanguage: translate_1Persistent.currentLanguageEnum)
        translate_1Keyboard.setSeparatorSymbol(String(display.separatorCharacter))

        translate_1Keyboard.callback = execute
        translate_1LanguageSelectorKeyboard.callback = execute
        translate_1SelectedLanguagekeyboard.callback = execute
        
        translate_1Keyboard.countryKey.callback = toggleLanguageSelector
        translate_1Keyboard.countryKey.imageName = translate_1Manager.flagname(translate_1Persistent.currentLanguageEnum)
        translate_1LanguageSelectorKeyboard.countryKey.callback = toggleLanguageSelector
        translate_1LanguageSelectorKeyboard.countryKey.imageName = translate_1Manager.flagname(translate_1Persistent.currentLanguageEnum)

        process()
    }
    
}
