//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    let model = CalculatoriOSViewModel(width: defaultWidth, height: defaultHeight, isTranslator: false, isMac: false, isScientific: false)
    var body: some Scene {
        WindowGroup {
            CalculatoriOSView(model: model)
        }
    }
}
