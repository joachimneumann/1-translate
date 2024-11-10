//
//  Translate_1App.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import Foundation
import SwiftGmp
import SwiftUI

public typealias AppleFont = UIFont

@main
struct Translate_1App: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //            GeometryReader { geo in
                Translate_1View(viewModel: ViewModel(screen: Screen()))
                //            }
            }
        }
    }
}

