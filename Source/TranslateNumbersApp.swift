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
//                HStack {
//                    let k1 = AKey(DigitOperation.five)
//                    let k2 = AKey(DigitOperation.six)
//                    let _ = k2.isPending = true
//                    AnimatedKey(key: k1)
//                    AnimatedKey(key: k2)
//                }
//                    .padding()

                                BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))

                //                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}

