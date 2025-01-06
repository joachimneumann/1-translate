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
                let model = ViewModel(width: geometry.size.width, height: geometry.size.height)
                CalculatoriOSView(model: model)
            }
        }
    }
}
