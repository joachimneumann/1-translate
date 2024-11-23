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
    var translate_1Manager: TranslateManager
//    var keyboard: TranslateKeyboard? = nil
    var languageSelectionKeyboard: LanguageSelectionKeyboard? = nil
    @Published var showLanguageSelector: Bool = false
    var showSettings: Bool = false

#if TRANSLATE_IOS
    private(set) var _voices: TranslateiOSVoices!
    var voices: TranslateiOSVoices {
        return _voices
    }
#endif
    
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

    func toggle() {
        showLanguageSelector.toggle()
    }

    func set(_ language: NumberTranslator.LanguageEnum) {
        persistent.currentLanguageEnum = language
        display.separatorCharacter = separatorCharacter(forLanguage: language)
        display.groupSize = groupSize(forLanguage: language)
        display.groupingCharacter = groupingCharacter(forLanguage: language)
        smallKeyboard!.setSeparatorSymbol(String(display.separatorCharacter))
        translate_1Manager.translateThis(display.string, to: language)
//        languageSelectionKeyboard!.countryKey.set(language)
        languageSelectionKeyboard!.countryDescriptionKey.top = translate_1Manager.name(language)
        languageSelectionKeyboard!.countryDescriptionKey.bottom = translate_1Manager.englishName(language)
        process()
    }

    override func execute(_ key: Key) {
        if let languageSettingsKey = key as? SymbolKey {
            if languageSettingsKey.model.op.isEqual(to: TranslateOperation.settings) {
                showSettings = true
                return
            }
        }

        
        super.execute(key)
    }
        
    override init(screen: Screen = Screen()) {
        let tempTranslate_1Manager = TranslateManager()
        
        translate_1Manager = tempTranslate_1Manager

        // todo: fix this
        super.init(screen: screen)
        smallKeyboard = TranslateKeyboard(persistent: self.persistent)
        
        languageSelectionKeyboard = LanguageSelectionKeyboard(
            translateViewModel: self,
            keySpacing: screen.keySpacing,
            borderColor: Color(AppleColor.darkGray))

        let current = persistent.currentLanguageEnum
        display.separatorCharacter = separatorCharacter(forLanguage: current)
        display.groupSize = groupSize(forLanguage: current)
        display.groupingCharacter = groupingCharacter(forLanguage: current)
        smallKeyboard!.setSeparatorSymbol(String(display.separatorCharacter))

        smallKeyboard!.callback = execute
//        keyboard.countryKey.set(current)
//        keyboard.countryKey.isToggleButton = true
        languageSelectionKeyboard!.callback = execute
//        languageSelectionKeyboard!.countryKey.set(current)
        languageSelectionKeyboard!.countryDescriptionKey.top = translate_1Manager.name(current)
        languageSelectionKeyboard!.countryDescriptionKey.bottom = translate_1Manager.englishName(current)

        process()
    }
    
}
