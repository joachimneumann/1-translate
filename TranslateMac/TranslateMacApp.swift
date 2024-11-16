//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct TranslateMacApp: App {
    
    let width: CGFloat = 550
    let height: CGFloat = 400
    

    var body: some Scene {
        let screen = Screen(CGSize(width: width, height: height))
        WindowGroup {
            NavigationStack {
                TranslateMacView(viewModel: TranslateViewModel(screen: screen))
                    .frame(width: width, height: height)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
    }
}
