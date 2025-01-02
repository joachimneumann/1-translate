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
        deviceWidth: 250,
        deviceHeight: 380,
        isTranslator: false,
        isMac: true)
    var body: some Scene {
        WindowGroup {
//            Demo()
            CalculatorMacView(model: model)
                .frame(width: model.width, height: model.height)
            //.background(.yellow)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

