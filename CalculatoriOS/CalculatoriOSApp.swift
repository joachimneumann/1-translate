//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    let viewModel = ViewModel(.standard, width: defaultWidth, height: defaultHeight)
    var body: some Scene {
        WindowGroup {
            CalculatoriOSView(model: viewModel)
        }
    }
}
