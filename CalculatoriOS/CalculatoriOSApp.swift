//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                let model = CalculatoriOSViewModel(width: geometry.size.width, height: geometry.size.height, isTranslator: false, isMac: false)
                CalculatoriOSView(model: model)
            }
        }
    }
}
