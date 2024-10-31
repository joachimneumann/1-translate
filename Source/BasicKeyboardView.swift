//
//  BasicKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

struct BasicKeyboardView: View {
    @State private var navigateToConfigView = false

    let spacing: CGFloat
    var basicKeyboard: BasicKeyboard
    let configKeyImageName: String
    let configKeyBorderColor: Color?
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(basicKeyboard.rows) { keyRow in
                HStack(spacing: spacing) {
                    ForEach(keyRow.keys) { key in
                        CalculatorKeyView(key: key, navigateToConfigView: $navigateToConfigView)
                    }
                }
            }
        }
        .background(
            NavigationLink(
                destination: LanguageSelector(viewModel: ViewModel(screen: Screen(CGSize(width: 100, height: 100)))), 
                isActive: $navigateToConfigView,
                label: {
                    EmptyView()
                }
            )
            .hidden() // Hide the NavigationLink
        )
    }
}

#Preview {
    let basicKeyboard: BasicKeyboard = BasicKeyboard(keySize: CGSize(width: 80.0, height: 50.0))
    VStack {
        Rectangle()
        BasicKeyboardView(spacing: 20, basicKeyboard: basicKeyboard, configKeyImageName: "English", configKeyBorderColor: Color(UIColor.lightGray))
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
