//
//  CalculatorMacApp.swift
//  CalculatorMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI



@main
struct CalculatorMacApp: App {
    
    let width: CGFloat = 574.0
    let height: CGFloat = 293.0
    
    var body: some Scene {
        WindowGroup {
            CalculatorMacView()
                .frame(width: width, height: height)
                .background(.yellow)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
