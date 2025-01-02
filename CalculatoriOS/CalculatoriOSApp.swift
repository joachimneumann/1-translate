//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    let model = CalculatoriOSViewModel(deviceWidth: devicePortraitWidth, deviceHeight: devicePortraitHeight, isTranslator: false, isMac: false)
    var body: some Scene {
        WindowGroup {
            CalculatoriOSView(model: model)
        }
    }
}
