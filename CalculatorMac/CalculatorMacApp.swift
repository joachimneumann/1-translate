//
//  CalculatorMacApp.swift
//  CalculatorMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI



@main
struct CalculatorMacApp: App {
    let model: ViewModel = ViewModel(
        width: 250,
        height: 400,
        isTranslator: false,
        isMac: true,
        isScientific: true)
    var body: some Scene {
        WindowGroup {
            CalculatorMacView(model: model)
                .frame(width: model.width, height: model.height)
            //.background(.yellow)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

