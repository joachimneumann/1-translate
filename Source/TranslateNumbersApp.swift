//
//  TranslateNumbersApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import SwiftUI
import SwiftGmp

public typealias AppleFont = UIFont

@main
struct TranslateNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))
//                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}
