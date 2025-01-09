//
//  CalculatorMacApp.swift
//  CalculatorMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI



@main
struct CalculatorMacApp: App {
    let model: ViewModel = ViewModel(isTranslator: false,
        isMac: true)
    var body: some Scene {
        WindowGroup {
            CalculatorMacView(model: model)
                .onAppear {
                    print("App: appear")
                    model.updateDimensions(width: 576, height: 322)
                }
                .frame(width: 576, height: 322)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

