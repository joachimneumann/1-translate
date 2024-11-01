//
//  NonScientificKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp
struct AllRows: View {
    let spacing: CGFloat
    var smallKeyboard: SmallKeyboard
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(smallKeyboard.keyMatrix, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row) { key in
                        CalculatorKeyView(key: key)
                    }
                }
            }
        }
    }
}
struct SmallKeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    let height: CGFloat
    var smallKeyboard: SmallKeyboard
    var body: some View {
        if smallKeyboard.scrollAfterRow != nil {
            ScrollView {
                AllRows(spacing: spacing, smallKeyboard: smallKeyboard)
            }
            .frame(height: height)
        } else {
            AllRows(spacing: spacing, smallKeyboard: smallKeyboard)
        }
    }
}

#Preview {
//        let smallKeyboard: SmallKeyboard = TranslatorKeyboard(keySize: CGSize(width: 80.0, height: 50.0))
    let smallKeyboard: SmallKeyboard = LanguageSelectorKeyboard(keySize: CGSize(width: 80.0, height: 50.0), translationManager: TranslationManager())
    VStack {
        Rectangle()
        SmallKeyboardView(spacing: 20, height: 260, smallKeyboard: smallKeyboard)
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
