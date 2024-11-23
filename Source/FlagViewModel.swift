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
    private let languageEnum: NumberTranslator.LanguageEnum
    private var toggle: (() -> Void)?
    private var update: ((NumberTranslator.LanguageEnum) -> Void)?

    var image: Image
    var borderWidth: CGFloat = 0.0
    var padding: CGFloat = 0.0
    let borderColor: Color = Color(AppleColor.darkGray)

    init(persistent: TranslatePersistent,
         languageEnum: NumberTranslator.LanguageEnum? = nil,
         toggle: (() -> Void)? = nil,
         update: ((NumberTranslator.LanguageEnum) -> Void)? = nil) {
        self.persistent = persistent
        self.languageEnum = languageEnum ?? persistent.currentLanguageEnum
        print("FlagViewModel \(self.languageEnum.rawValue)")
        self.toggle = toggle
        self.update = update
        image = Image("English")
    }
    
    func pressed() {
        if let toggle = toggle {
            toggle()
        } else {
            if let update = update {
                update(languageEnum)
            }
        }
    }
    
    func newSize(_ rect: CGSize) {
        print("FlagViewModel \(rect) \(languageEnum.rawValue)")
        var imageName = "English"
        let name = persistent.flagName(languageEnum)
        if rect.width < rect.height * 1.1 && AppleImage(named: name + "Sqr") != nil {
            imageName = name + "Sqr"
        } else {
            if AppleImage(named: name) != nil {
                imageName = name
            }
        }
        print("imageName \(imageName)")
        image = Image(imageName)
        borderWidth = ceil(min(rect.width, rect.height) * 0.04)
        padding = 0.5 * borderWidth
    }
}
