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
    var translationManager: TranslationManager
//    var keyboard: TranslateKeyboard? = nil
    @Published var showLanguageSelector: Bool = false
    var showSettings: Bool = false

#if TRANSLATE_IOS
    private(set) var _voices: TranslateiOSVoices!
    var voices: TranslateiOSVoices {
        return _voices
    }
#endif
    
    init(isMac: Bool = false) {
        translationManager = TranslationManager()
        super.init(isTranslator: true, isMac: isMac)

        

        // todo: fix this
//        smallKeyboard = TranslateKeyboard(persistent: self.persistent, toggle: toggle)
        
//        languageSelectionKeyboard = LanguageSelectionKeyboard(
//            translateViewModel: self)
//
//        let current = persistent.currentLanguageEnum
//        display.separatorCharacter = separatorCharacter(forLanguage: current)
//        display.groupSize = groupSize(forLanguage: current)
//        display.groupingCharacter = groupingCharacter(forLanguage: current)
//        smallKeyboard!.setSeparatorSymbol(String(display.separatorCharacter))
//
//        smallKeyboard!.callback = execute
//        keyboard.countryKey.set(current)
//        keyboard.countryKey.isToggleButton = true
//        languageSelectionKeyboard!.callback = execute
//        languageSelectionKeyboard!.countryKey.set(current)
//        languageSelectionKeyboard!.countryDescriptionKey.top = translationManager.name(current)
//        languageSelectionKeyboard!.countryDescriptionKey.bottom = translationManager.englishName(current)

        process()
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

    func groupSize(forLanguage language: NumberTranslator.LanguageEnum) -> Int {
        translationManager.groupSize(language)
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
        translationManager.translateThis(toTranslate, to: persistent.currentLanguageEnum)
    }

    func toggle() {
        showLanguageSelector.toggle()
    }

    func setLanguage(_ language: NumberTranslator.LanguageEnum) {
        persistent.currentLanguageEnum = language
        display.separatorCharacter = separatorCharacter(forLanguage: language)
        display.groupSize = groupSize(forLanguage: language)
        display.groupingCharacter = groupingCharacter(forLanguage: language)
//        smallKeyboard!.setSeparatorSymbol(String(display.separatorCharacter))
//        if let k = smallKeyboard! as? TranslateKeyboard {
//            k.countryKey.newLanguageEnum(language)
//        }
//        translationManager.translateThis(display.string, to: language)
//        languageSelectionKeyboard!.countryKey.newLanguageEnum(language)
//        languageSelectionKeyboard!.countryDescriptionKey.top = translationManager.name(language)
//        languageSelectionKeyboard!.countryDescriptionKey.bottom = translationManager.englishName(language)
        process()
    }

    override func execute(_ key: KeyAnimation) {
        if let keyModel = key as? KeyModel {
            if keyModel.flag != nil {
                toggle()
            } else {
                process()
                keyboard.back(calculator.privateDisplayBufferHasDigits)
                super.execute(key)
            }
        }
    }
        

    
}
