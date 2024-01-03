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
                let _ = print("TranslateNumbersApp body")
                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}
