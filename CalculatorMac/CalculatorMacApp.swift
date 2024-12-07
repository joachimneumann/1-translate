//
//  CalculatorMacApp.swift
//  CalculatorMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI



@main
struct CalculatorMacApp: App {
    
    let width: CGFloat = 250
    let height: CGFloat = 400
    let model: ViewModel = ViewModel(.macTranslator, width: 250 - 10, height: 400 - 30)

    var body: some Scene {
        WindowGroup {
            CalculatorMacView(model: model)
                .frame(width: width, height: height)
                //.background(.yellow)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
