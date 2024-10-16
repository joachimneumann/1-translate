//
//  TranslateNumbersApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import SwiftUI

public typealias AppleFont = UIFont


@main
struct TranslateNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                BasicKeyboardView(basicKeyboard: BasicKeyboard())
//                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}
