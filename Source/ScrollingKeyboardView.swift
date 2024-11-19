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
        GeometryReader { geometry in
            VStack(spacing: spacing) {
                if geometry.notZero {
                    let keyWidth = 0.25 * (geometry.size.width - 3 * spacing)
                    ForEach(keyboard.keyMatrix.dropLast().indices, id: \.self) { rowIndex in
                        HStack(spacing: spacing) {
                            ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                                KeyView(key: key)
                                    .frame(width: keyWidth)
                            }
                            Spacer(minLength: 0.0)
                        }
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
                                } else { // TextView
                                    KeyView(key: key)
                                        //.background(.green)
                                }
                            }
                        }
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.8), // Fully transparent
                                Color.black.opacity(1)  // Semi-transparent white
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
//                        .frame(height: keyWidth)
                    )
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
                    let fiveRows = geometry.size.height
                    let keyHeight = 0.2 * (fiveRows - 4 * spacing)
                    let fourRows = 4 * keyHeight + 3 * spacing
                    let scrollingKeysheight: CGFloat =
                    CGFloat(keyboard.keyMatrix.count - 1) * keyHeight +
                    CGFloat(keyboard.keyMatrix.count - 2) * spacing
                    ZStack {
                        VStack(alignment: .leading, spacing: spacing) {
                            ScrollView(.vertical, showsIndicators: true) {
                                AllRowsExceptLast(spacing: spacing, keyboard: keyboard)
                                    .frame(width: geometry.size.width, height: scrollingKeysheight)
                                    .padding(.bottom, spacing + keyHeight)
                            }
                            .frame(height: fourRows + spacing + 0.7 * keyHeight)
                            Spacer()
                        }
                        VStack(alignment: .leading, spacing: 0.0) {
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 0.0) {
                                    Spacer()
                                    HStack(spacing: 0.0) {
                                        LastRow(spacing: spacing, keyboard: keyboard)
                                        Spacer(minLength: 0.0)
                                    }
                                    .frame(width: geometry.size.width, height: keyHeight)
                                }
                                Spacer(minLength: 0.0)
                            }
                        }
                        .frame(height: fiveRows)
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
    let _ = keyboard.countryKey.model._name = "Deutsch"
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
        Rectangle()
//        let _ = keyboard.back(true)
        ScrollingKeyboardView(spacing: screen.keySpacing, keyboard: keyboard)
//            .background(.yellow)
            .frame(width: 300, height: 300)
    }
    .background(.black)
}
