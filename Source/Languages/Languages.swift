//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import SwiftUI
import NumberTranslator

class Languages {
    @AppStorage("nameKey")
    var name: String = "English"
    
    var language: Language
    var list: [Language] = []

    init() {
        let translators = Translators()
        language = Language(translators.list[0])
        for translator in translators.list {
            let newLanguage = Language(translator)
            list.append(newLanguage)
            if translator.name == name { language = newLanguage }
        }
    }
}
