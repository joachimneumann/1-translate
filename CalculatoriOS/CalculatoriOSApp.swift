//
//  CalculatoriOSApp.swift
//  CalculatoriOS
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

@main
struct CalculatoriOSApp: App {
    @StateObject private var model = ViewModel()

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                CalculatoriOSView(model: model)
                    .onAppear {
                        model.updateDimensions(width: geometry.size.width, height: geometry.size.height)
                    }
            }
        }
    }
}
//
//struct CalculatoriOSApp: App {
//    @StateObject private var model = ViewModel()
//
//    var body: some Scene {
//        WindowGroup {
//            GeometryReader { geometry in
//                let _ = print("CalculatoriOSApp GeometryReader")
//                model.updateDimensions(width: geometry.size.width, height: geometry.size.height)
//                CalculatoriOSView(model: model)
//            }
//        }
//    }
//}
