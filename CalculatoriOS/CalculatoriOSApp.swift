//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    let viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            CalculatoriOSView(model: viewModel)
        }
    }
}
