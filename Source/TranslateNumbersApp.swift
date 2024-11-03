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
//                let symbol = SymbolKey(InplaceOperation.sqr)
//                let image = FlagKey(flagname: "Deutsch", borderColor: .green)
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.gray)
//                    VStack {
//                        KeyView(key: symbol)
//                        KeyView(key: image)
//                    }
//                }
                                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}

