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
                //            GeometryReader { geo in
                TranslateiOSView(viewModel: TranslateViewModel(screen: Screen()))
                //            }
            }
        }
    }
}

