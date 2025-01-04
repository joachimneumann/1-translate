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
            GeometryReader { geometry in
                let width = min(geometry.size.width, geometry.size.height)
                let height = max(geometry.size.width, geometry.size.height)
                let model = TranslateViewModel(width: width, height: height, isMac: false)
                TranslateiOSView(model: model)
            }
        }
//        WindowGroup {
//            NavigationStack {
////                Demo()
//                TranslateiOSView(model: viewModel)
//            }
//        }
    }
}


