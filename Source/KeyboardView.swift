//
//  KeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI


struct KeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    var keyboard: Keyboard
    let height: CGFloat?
    
    init(spacing: CGFloat, keyboard: Keyboard, height: CGFloat? = nil) {
        print("1")
        self.spacing = spacing
        self.keyboard = keyboard
        self.height = height
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(keyboard.keyMatrix.indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                        KeyView(key: key)
                    }
                }
            }
        }
    }
}

#if TRANSLATE_IOS
import NumberTranslator
#endif


#Preview {
    let screen = Screen()
    
    
#if TRANSLATE_IOS || TRANSLATE_MAC
//    let keyboard: TranslateSelectLanguage = TranslateSelectLanguage(
//        translate_1Manager: TranslateManager(),
//        keySpacing: 10,
//        borderColor: .green)
//    let _ = keyboard.countryKey.model.name = "Deutsch"
//    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
    let keyboard: SmallKeyboard = TranslateKeyboard(persistent: TranslatePersistent())
#else
    let keyboard: SmallKeyboard = CalculatoriOSKeyboard()
#endif

    
//    let translate_1Manager = Translate_1Manager()

//    let keyboard = Translate_1SelectLanguage(keySize: screen.keySize, translate_1Manager: Translate_1Manager(), keySpacing: screen.keySpacing)
//    let _ = keyboard.countryKey.imageName = translate_1Manager.flagname(NumberTranslator.LanguageEnum.german)
//    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
//    let _ = keyboard.countryDescriptionKey.bottom = "(German)"

//    let keyboard: SmallKeyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager())

    VStack {
        Rectangle()
//        let _ = keyboard.back(true)
        KeyboardView(spacing: screen.keySpacing, keyboard: keyboard, height: screen.keyboardHeight)
            .padding(.bottom, 10)
    }
    .background(.black)
}
