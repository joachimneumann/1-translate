//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct TranslateMacApp: App {
    var body: some Scene {
        WindowGroup {
            TranslateMacView(viewModel: Translate_1ViewModel(screen: Screen()))
        }
    }
}
