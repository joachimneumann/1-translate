//
//  TranslateiOSApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import Foundation
import SwiftGmp
import SwiftUI

@main
struct TranslateiOSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Demo(diameter: 80)
                    .preferredColorScheme(.light)
                //            GeometryReader { geometry in
//                TranslateiOSView(viewModel: TranslateViewModel())
                //            }
            }
        }
    }
}

