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
                let symbol = SymbolKey(width: 100.0, height: 100.0, op: InplaceOperation.sqr)
                let image = ImageKey(width: 100.0, height: 100.0, imageName: "Deutsch", borderColor: .green, borderwidth: 5.0)
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                    VStack {
                        BaseKeyView(baseKey: symbol)
                        BaseKeyView(baseKey: image)
                    }
                }
                //                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}

