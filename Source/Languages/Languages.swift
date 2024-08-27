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
    
    var first: Language
    var list: [Language] = []

    init() {
        let translators = Translators()
        first = Language(translators.list[0])
        for translator in translators.list {
            let language = Language(translator)
            for language in list {
                if language.translator.name == firstName { first = language }
            }
            list.append(language)
        }
    }
}
