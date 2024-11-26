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
                    ForEach(keyboard.keyMatrix.dropLast().indices, id: \.self) { rowIndex in
                        HStack(spacing: spacing) {
                            ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                                KeyView(key: key)
                            }
                        }
                    }
                    Spacer(minLength: spacing)
                }
            }
        }
    }
}

struct LastRow: View {
    let spacing: CGFloat
    let keyWidth: CGFloat
    var keyboard: Keyboard  // Use @ObservedObject for updates
    
    var body: some View {
        if let lastRow = keyboard.keyMatrix.last {
            HStack(spacing: spacing) {
                ForEach(lastRow, id: \.id) { key in
                    if let key = key as? TextKey {
                        KeyView(key: key)
                    } else {
                        KeyView(key: key)
                            .frame(width: keyWidth)
                    }
                }
            }
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        bg.opacity(0.5), // Fully transparent
//                        bg.opacity(1.0)  // Semi-transparent white
//                    ]),
//                    startPoint: .top,
//                    endPoint: .center
//                )
//            )
        }
    }
}

struct ScrollingKeyboardView: View {
    @State private var model: ScrollingKeyboardViewModel
    @State private var navigateToConfigView = false
    
    
    init(model: ScrollingKeyboardViewModel) {
        self.model = model
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.notZero {
                ZStack {
                    VStack(alignment: .leading, spacing: 0.0) {
                        ScrollView(.vertical, showsIndicators: true) {
                            AllRowsExceptLast(spacing: model.spacing, keyboard: model.keyboard)
                                .frame(height: model.scrollingContentHeight)
                        }
                        .frame(height: model.fourRows + model.spacing)
                        LastRow(
                            spacing: model.spacing,
                            keyWidth: model.keyWidth,
                            keyboard: model.keyboard)
                        .frame(height: model.keyHeight)
                    }
                }
                .onAppear {
                    self.model.newSize(geometry.size)
                }
            }
        }
    }
}


#if TRANSLATE_IOS
import NumberTranslator
#endif


#Preview {
    
#if TRANSLATE_IOS || TRANSLATE_MAC
    let keyboard: LanguageSelectionKeyboard = LanguageSelectionKeyboard(
        translateViewModel: TranslateViewModel())
//    let _ = keyboard.countryKey.set(.german)
//    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
    //    let keyboard: SmallKeyboard = Translate_1Keyboard()
#else
    let keyboard: SmallKeyboard = CalculatoriOSKeyboard()
#endif
    let model = ScrollingKeyboardViewModel(spacing: 10.0, keyboard: keyboard)
    
    
    //    let translate_1Manager = Translate_1Manager()
    
    //    let keyboard = Translate_1SelectLanguage(keySize: 10, translate_1Manager: Translate_1Manager(), keySpacing: 10)
    //    let _ = keyboard.countryKey.imageName = translate_1Manager.flagname(NumberTranslator.LanguageEnum.german)
    //    let _ = keyboard.countryDescriptionKey.top = "Deutsch"
    //    let _ = keyboard.countryDescriptionKey.bottom = "(German)"
    
    //    let keyboard: SmallKeyboard = Translate_1LanguageSelectorKeyboard(keySize: keySize, translate_1Manager: Translate_1Manager())
    
    VStack(spacing: 0.0) {
        Rectangle()
        ScrollingKeyboardView(model: model)
//            .frame(width: 300, height: 300)
    }
    .background(model.backgroundColor)
}
