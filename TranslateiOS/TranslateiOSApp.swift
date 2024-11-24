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
    let viewModel = TranslateViewModel(screen: Screen())
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //            GeometryReader { geometry in
                TranslateiOSView(viewModel: viewModel)
                //            }
            }
        }
    }
}

