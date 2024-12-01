//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct TranslateMacApp: App {
    
    let width: CGFloat = 500
    let height: CGFloat = 350
    

    var body: some Scene {
//        let screen = Screen(CGSize(width: width, height: height))
        WindowGroup {
            Demo()
//                .preferredColorScheme(.dark)
//            NavigationStack {
                TranslateMacView()
                    .frame(width: width, height: height)
//            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
    }
}
