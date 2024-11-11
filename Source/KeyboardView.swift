//
//  KeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct AllRows: View {
    let spacing: CGFloat
    @ObservedObject var keyboard: Keyboard  // Use @ObservedObject for updates

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
    @ObservedObject var keyboard: Keyboard  // Use @ObservedObject for updates

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
    @ObservedObject var keyboard: Keyboard  // Use @ObservedObject for updates

    var body: some View {
        if let lastRow = keyboard.keyMatrix.last {
            HStack(spacing: spacing) {
                ForEach(lastRow, id: \.id) { key in
                    KeyView(key: key)
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
        if height != nil {
            VStack(spacing: 0.0) {
                ScrollView {
                    AllRowsExceptLast(spacing: spacing, keyboard: keyboard)
                }
                .frame(height: height)
                LastRow(spacing: spacing, keyboard: keyboard)
                    .padding(.top, spacing)
                    .padding(.bottom, 0.0)
            }
        } else {
            AllRows(spacing: spacing, keyboard: keyboard)
        }
    }
}

#Preview {
    let screen = Screen()
//    let height: CGFloat? = nil
    let keySize: CGSize = CGSize(width: 80.0, height: 50.0)

    //    let keyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager(), countryKey: Key())
    let keyboard: SmallKeyboard = Translate_1Keyboard(keySize: keySize)
//    let keyboard: SmallKeyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager())
    VStack {
        Rectangle()
        KeyboardView(spacing: 20, keyboard: keyboard, height: screen.keyboardHeight4Rows)
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
