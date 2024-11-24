//
//  FlagViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 23.11.2024.
//

import SwiftUI
import NumberTranslator

@Observable class FlagViewModel {
    private let persistent: TranslatePersistent
    private var languageEnum: NumberTranslator.LanguageEnum
    private var toggle: (() -> Void)?
    private var setLanguage: ((NumberTranslator.LanguageEnum) -> Void)?

    var image: Image
    var borderWidth: CGFloat = 0.0
    var padding: CGFloat = 0.0
    let borderColor: Color = Color(AppleColor.darkGray)
    var isSquare: Bool = false
    
    init(persistent: TranslatePersistent,
         languageEnum: NumberTranslator.LanguageEnum? = nil,
         toggle: (() -> Void)? = nil,
         setLanguage: ((NumberTranslator.LanguageEnum) -> Void)? = nil) {
        self.persistent = persistent
        self.languageEnum = languageEnum ?? persistent.currentLanguageEnum
        self.toggle = toggle
        self.setLanguage = setLanguage
        image = Image("English")
//        print("FlagViewModel init \(self.languageEnum.rawValue)")
    }
    
    func pressed() {
        if let toggle = toggle {
            toggle()
        } else {
            if let setLanguage = setLanguage {
                setLanguage(languageEnum)
            }
        }
    }
    
    func newLanguageEnum(_ languageEnum: NumberTranslator.LanguageEnum) {
//        print("FlagViewModel newLanguageEnum \(languageEnum.rawValue)")
        self.languageEnum = languageEnum

        if isSquare {
            image = Image(persistent.flagName(languageEnum) + "Sqr")
        } else {
            image = Image(persistent.flagName(languageEnum))
        }
    }
    
    func newSize(_ rect: CGSize) {
//        print("FlagViewModel newSize \(rect) \(languageEnum.rawValue)")
        if rect.width < rect.height * 1.1 && AppleImage(named: persistent.flagName(languageEnum) + "Sqr") != nil {
            isSquare = true
        } else {
            isSquare = false
        }
        newLanguageEnum(languageEnum)
        borderWidth = ceil(min(rect.width, rect.height) * 0.04)
        padding = 0.5 * borderWidth
    }
}
