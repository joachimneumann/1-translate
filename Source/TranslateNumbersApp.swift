//
//  TranslateNumbersApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import Foundation
import SwiftGmp
import SwiftUI

public typealias AppleFont = UIFont

@main
struct TranslateNumbersApp: App {
    @State private var showLanguageSelector = false
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                TranslateNumbers(screen: Screen(geo.size))
                    .environment(\.showLanguageSelector, $showLanguageSelector)
            }
        }
    }
}


struct ShowLanguageSelector: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var showLanguageSelector: Binding<Bool> {
        get { self[ShowLanguageSelector.self] }
        set { self[ShowLanguageSelector.self] = newValue }
    }
}
