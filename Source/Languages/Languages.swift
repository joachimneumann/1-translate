//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import SwiftUI
import NumberTranslator

class Languages {
    @AppStorage("firstNameKey") 
    var firstName: String = "English"
    
    @AppStorage("secondNameKey")
    var secondName: String = "German"
    
    @AppStorage("secondLanguageAllowedKey")
    var secondLanguageAllowed: Bool = false
    
    var first: Language
    var second: Language
    var list: [Language] = []

    init() {
        let translators = Translators()
        first = Language(translators.list[0])
        second = Language(translators.list[1])
        for translator in translators.list {
            let language = Language(translator)
            for language in list {
                if language.translator.name == firstName { first = language }
                if language.translator.name == secondName { second = language }
            }
            list.append(language)
        }
    }
}
