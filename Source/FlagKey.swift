//
//  FlagKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 20.11.2024.

import NumberTranslator
import SwiftUI

class FlagKey: Key {
    let persistent: TranslatePersistent
    let languageEnum: NumberTranslator.LanguageEnum
    let model: FlagViewModel
    
    init(persistent: TranslatePersistent,
         languageEnum: NumberTranslator.LanguageEnum? = nil,
         toggle: (() -> ())? = nil,
         setLanguage: ((NumberTranslator.LanguageEnum) -> ())? = nil){
        self.persistent = persistent
        self.languageEnum = languageEnum ?? persistent.currentLanguageEnum
        self.model = FlagViewModel(
            persistent: persistent,
            languageEnum: languageEnum,
            toggle: toggle,
            setLanguage: setLanguage)
    }
    override func view() -> AnyView {
        AnyView(FlagView(model: model))
    }
}

#Preview {
    let persistent = TranslatePersistent()
    let _ = persistent.currentLanguageEnum = .italian
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagKey(persistent: persistent, languageEnum: .german).view()
            FlagKey(persistent: persistent, languageEnum: .english).view()
            FlagKey(persistent: persistent, languageEnum: .ukrainian).view()
            FlagKey(persistent: persistent).view()
        }
        .frame(height: 100)
    }
}
