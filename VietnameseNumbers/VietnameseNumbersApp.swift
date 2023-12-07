//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Joachim Neumann on 20/09/2021.
//

import SwiftUI

public typealias AppleFont = UIFont


@main
struct VietnameseNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                VietnameseNumbers(screen: Screen(geo.size))
            }
        }
    }
}
