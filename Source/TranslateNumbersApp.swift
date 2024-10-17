//
//  TranslateNumbersApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import Foundation
import SwiftGmp
import SwiftUI

public typealias AppleFont = UIFont

@main
struct TranslateNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                // BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))
                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}

