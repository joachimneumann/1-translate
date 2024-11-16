//
//  KeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct AllRows: View {
    let spacing: CGFloat
    var keyboard: Keyboard  // Use @ObservedObject for updates

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

struct AllRowsExceptLast: View {
    let spacing: CGFloat
    var keyboard: Keyboard

    var body: some View {
        VStack(spacing: spacing) {
            ForEach(keyboard.keyMatrix.dropLast().indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                        KeyView(key: key)
                    }
                }
            }
        }
    }
}

struct LastRow: View {
    let spacing: CGFloat
    var keyboard: Keyboard  // Use @ObservedObject for updates

    var body: some View {
        if let lastRow = keyboard.keyMatrix.last {
            GeometryReader { geometry in
                if geometry.notZero {
                    let keyWidth = 0.25 * (geometry.size.width - 3 * spacing)
                    VStack(spacing: spacing) {
                        HStack(spacing: spacing) {
                            ForEach(lastRow, id: \.id) { key in
                                if let key = key as? SymbolKey {
                                    KeyView(key: key)
                                        .frame(width: keyWidth)
                                } else if let key = key as? Imagekey {
                                    KeyView(key: key)
                                        .frame(width: keyWidth)
                                } else {
                                    KeyView(key: key)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ScrollingKeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    var keyboard: Keyboard
    let scrolling: Bool
    
    init(spacing: CGFloat, keyboard: Keyboard) {
        self.spacing = spacing
        self.keyboard = keyboard
        scrolling = keyboard.keyMatrix.count > 4
    }
    
    var body: some View {
        GeometryReader { geometry in
            if scrolling {
                if geometry.notZero {
                    let keyboardheight = geometry.size.height
                    let keyHeight = 0.2 * (keyboardheight - 4 * spacing)
                    let scrollingKeysheight: CGFloat =
                    CGFloat(keyboard.keyMatrix.count - 1) * keyHeight +
                    CGFloat(keyboard.keyMatrix.count - 2) * spacing
                    let _ = print("keyboardheight \(keyboardheight)")
                    let _ = print("keyHeight \(keyHeight)")
                    let _ = print("scrollingKeysheight \(scrollingKeysheight)")
                    VStack(spacing: spacing) {
                        ScrollView(.vertical, showsIndicators: true) {
                            AllRowsExceptLast(spacing: spacing, keyboard: keyboard)
                                .frame(width: geometry.size.width, height: scrollingKeysheight)
                        }

                        LastRow(spacing: spacing, keyboard: keyboard)
                            .frame(height: keyHeight)
#if TRANSSLATE_MAC
                            .offset(x: -7.5)
#endif
//                            .background(.green)
                    }
                }
            } else {
                AllRows(spacing: spacing, keyboard: keyboard)
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
    let keyboard: TranslateSelectLanguage = TranslateSelectLanguage(
        translate_1Manager: TranslateManager(),
        keySpacing: 10,
        borderColor: Color(AppleColor.darkGray))
    let _ = keyboard.countryKey.imageName = "Deutsch"
    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
//    let keyboard: SmallKeyboard = Translate_1Keyboard()
#else
    let keyboard: SmallKeyboard = CalculatoriOSKeyboard()
#endif

    
//    let translate_1Manager = Translate_1Manager()

//    let keyboard = Translate_1SelectLanguage(keySize: screen.keySize, translate_1Manager: Translate_1Manager(), keySpacing: screen.keySpacing)
//    let _ = keyboard.countryKey.imageName = translate_1Manager.flagname(NumberTranslator.LanguageEnum.german)
//    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
//    let _ = keyboard.countryDescriptionKey.bottom = "(German)"

//    let keyboard: SmallKeyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager())

    VStack(spacing: 0.0) {
        let _ = print("keyboardHeight5Rows \(screen.keyboardHeight5Rows)")
        let _ = print("spacing \(screen.keySpacing)")
        Rectangle()
//        let _ = keyboard.back(true)
        ScrollingKeyboardView(spacing: screen.keySpacing, keyboard: keyboard)
            .background(.yellow)
            .frame(width: screen.calculatorWidth, height: screen.keyboardHeight5Rows)
    }
    .background(.gray)
}
