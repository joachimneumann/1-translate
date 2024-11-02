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
                        if key.op.isEqual(to: ConfigOperation.spacer) {
                            Spacer()
                        } else {
                            CalculatorKeyView(key: key)
                        }
                    }
                }
            }
        }
    }
}
struct SmallKeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    var smallKeyboard: SmallKeyboard
    let height: CGFloat?
    
    init(spacing: CGFloat, smallKeyboard: SmallKeyboard, height: CGFloat? = nil) {
        self.spacing = spacing
        self.smallKeyboard = smallKeyboard
        self.height = height
    }
    
    var body: some View {
        if height != nil {
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
        SmallKeyboardView(spacing: 20, smallKeyboard: smallKeyboard)
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
