//
//  TranslateViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class TranslateViewModel: ViewModel {
    @Published var persistent = TranslatePersistent()
    @Published var currentLanguageName: String
    var currentLanguageEnglishName: String?
    @Published var translate_1Manager: TranslateManager
    @Published var keyboard: TranslateKeyboard
    var selectLanguage: TranslateSelectLanguage
    @Published var showLanguageSelector: Bool = false
    @Published var showSettings: Bool = false

#if TRANSLATE_IOS
    private(set) var _voices: TranslateiOSVoices!
    var voices: TranslateiOSVoices {
        return _voices
    }
#endif
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

    func groupSize(forLanguage language: NumberTranslator.LanguageEnum) -> Int {
        translate_1Manager.groupSize(language)
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

    override func process() {
        super.process()
        var toTranslate = display.string
        toTranslate.remove(separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        translate_1Manager.translateThis(toTranslate, to: persistent.currentLanguageEnum)
    }

    override func execute(_ key: Key) {
        if let flagKey = key as? Imagekey {
            if let newLanguage = translate_1Manager.languageEnum(forFlagname: flagKey.model._name) {
                persistent.currentLanguageEnum = newLanguage
                currentLanguageName = translate_1Manager.name(persistent.currentLanguageEnum)
                currentLanguageEnglishName = translate_1Manager.englishName(persistent.currentLanguageEnum)
                keyboard.countryKey.model._name = flagKey.model._name
                display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
                display.groupSize = groupSize(forLanguage: persistent.currentLanguageEnum)
                display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
                keyboard.setSeparatorSymbol(String(display.separatorCharacter))
                translate_1Manager.translateThis(display.string, to: persistent.currentLanguageEnum)
                selectLanguage.countryKey.model._name = translate_1Manager.flagname(persistent.currentLanguageEnum)
                selectLanguage.countryDescriptionKey.top = translate_1Manager.name(persistent.currentLanguageEnum)
                selectLanguage.countryDescriptionKey.bottom = translate_1Manager.englishName(persistent.currentLanguageEnum)
                process()
                return
            }
        }
        
        if let languageSettingsKey = key as? SymbolKey {
            if languageSettingsKey.model.op.isEqual(to: TranslateOperation.settings) {
                showSettings = true
                return
            }
        }

        
        super.execute(key)
    }
        
    override init(screen: Screen = Screen()) {
        currentLanguageName = ""
        currentLanguageEnglishName = nil
        let tempTranslate_1Manager = TranslateManager()
        
        selectLanguage = TranslateSelectLanguage(
            translate_1Manager: tempTranslate_1Manager,
            keySpacing: screen.keySpacing,
            borderColor: Color(AppleColor.darkGray))

        translate_1Manager = tempTranslate_1Manager

        keyboard = TranslateKeyboard()
        super.init(screen: screen)
        smallKeyboard = keyboard

        display.separatorCharacter = separatorCharacter(forLanguage: persistent.currentLanguageEnum)
        display.groupSize = groupSize(forLanguage: persistent.currentLanguageEnum)
        display.groupingCharacter = groupingCharacter(forLanguage: persistent.currentLanguageEnum)
        keyboard.setSeparatorSymbol(String(display.separatorCharacter))

        keyboard.callback = execute
        selectLanguage.callback = execute
        
        keyboard.countryKey.callback = toggleLanguageSelector
        keyboard.countryKey.model._name = translate_1Manager.flagname(persistent.currentLanguageEnum)
        selectLanguage.countryKey.callback = toggleLanguageSelector
        selectLanguage.countryKey.model._name = translate_1Manager.flagname(persistent.currentLanguageEnum)
        selectLanguage.countryDescriptionKey.top = translate_1Manager.name(persistent.currentLanguageEnum)
        selectLanguage.countryDescriptionKey.bottom = translate_1Manager.englishName(persistent.currentLanguageEnum)

        process()
    }
    
}
