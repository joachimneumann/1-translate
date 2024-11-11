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
            VStack(spacing: spacing) {
                HStack(spacing: spacing) {
                    ForEach(lastRow, id: \.id) { key in
                        KeyView(key: key)
                    }
                }
            }
        }
    }
}

struct KeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    var keyboard: Keyboard
    let height: CGFloat?
    
    init(spacing: CGFloat, keyboard: Keyboard, height: CGFloat? = nil) {
        self.spacing = spacing
        self.keyboard = keyboard
        self.height = height
    }
    
    var body: some View {
        let _ = print("KeyboardView")
        if height != nil {
            VStack(spacing: spacing) {
                ScrollView {
                    AllRowsExceptLast(spacing: spacing, keyboard: keyboard)
                }
                .frame(height: height)
                LastRow(spacing: spacing, keyboard: keyboard)
            }
        } else {
            AllRows(spacing: spacing, keyboard: keyboard)
        }
    }
}

import NumberTranslator
#Preview {
    let screen = Screen()
    let translate_1Manager = Translate_1Manager()

//    let keyboard = Translate_1SelectLanguage(keySize: screen.keySize, translate_1Manager: Translate_1Manager(), keySpacing: screen.keySpacing)
//    let _ = keyboard.countryKey.imageName = translate_1Manager.flagname(NumberTranslator.LanguageEnum.german)
//    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
//    let _ = keyboard.countryDescriptionKey.bottom = "(German)"

    let keyboard: SmallKeyboard = Translate_1Keyboard(keySize: screen.keySize)
//    let keyboard: SmallKeyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager())

    VStack {
        Rectangle()
        let _ = keyboard.back(true)
        KeyboardView(spacing: screen.keySpacing, keyboard: keyboard, height: screen.keyboardHeight4Rows)
            .background(.black)
            .padding(.bottom, 10)
    }
    .background(.black)
}
