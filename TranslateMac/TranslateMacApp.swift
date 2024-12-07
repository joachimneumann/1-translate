//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct TranslateMacApp: App {
    
    let width: CGFloat = 250.0
    let height: CGFloat = 500.0
    let model: TranslateViewModel = TranslateViewModel(.macTranslator, width: 250 - 10, height: 500 - 30)

    var body: some Scene {
        WindowGroup {
            TranslateMacView(model: model)
                .frame(width: width, height: height)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
