//
//  TranslatePersistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

                                
class TranslatePersistent {
    var translationManager = TranslateManager()
    
    @AppStorage("currentLanguageString", store: .standard)
    var currentLanguageString: String = "English"
    
    var currentLanguageEnum: NumberTranslator.LanguageEnum {
        get {
            return translationManager.languageEnum(for: currentLanguageString) ?? .english
        }
        set {
            currentLanguageString = translationManager.name(newValue)
        }
    }

    func flagName(_ language: NumberTranslator.LanguageEnum) -> String {
        translationManager.flagName(language)
    }
    
    @AppStorage("showGrouping", store: .standard)
    var showGrouping: Bool = true

    @AppStorage("offerReadingAloudKey", store: .standard)
    var offerReadingAloud: Bool = true
}
