//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct TranslateMacApp: App {
    
    let width: CGFloat = 574.0
    let height: CGFloat = 293.0
    

    var body: some Scene {
        let screen = Screen(CGSize(width: width, height: height))
        WindowGroup {
            NavigationStack {
                TranslateMacView(viewModel: Translate_1ViewModel(screen: screen))
                    .frame(width: width, height: height)
            }
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
