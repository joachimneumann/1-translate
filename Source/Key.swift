//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI

class Key: Identifiable {
    let id = UUID()  // unique identifier
    var isPressed: Bool = false
    var height: CGFloat = 100.0 {
        didSet {
            let tolerance: CGFloat = 0.3 * height
            toleranceRect = CGRect(
                x: -tolerance,
                y: -tolerance,
                width: width + 2.0 * tolerance,
                height: height + 2.0 * tolerance)
        }
    }
    var toleranceRect: CGRect = CGRectZero
    private var downTimer: Timer? = nil
    private var downTime: Double = 0.15
    private var upTime: Double = 0.4

    var width: CGFloat = 100.0
    
    func visualDown() { }
    func visualUp()   { }
    func view() -> AnyView { AnyView(EmptyView()) }
    var callback: (Key) -> () = { _ in }

    func down() {
        isPressed = true
        withAnimation(.linear(duration: downTime)) {
            visualDown()
        }
        if let existingTimer = downTimer, existingTimer.isValid {
            existingTimer.invalidate()
        }
        downTimer = Timer.scheduledTimer(withTimeInterval: downTime, repeats: false) { _ in
            self.downTimerFired()
        }
    }

    func up() {
        if !isPressed {
            /// This can happen when up() is triggered by the finger moving
            /// away from the key and then the finger us released.
            return
        }
        isPressed = false
        if downTimer != nil { return }
        withAnimation(.linear(duration: upTime)) {
            visualUp()
        }
    }

    private func downTimerFired() {
        downTimer = nil
        if !isPressed {
            withAnimation(.linear(duration: upTime)) {
                visualUp()
            }
        }
    }
}

class XXXX {
//    var height: CGFloat = 100.0
//    let width: CGFloat = 100.0
//    let symbolKey: SymbolKey? = nil
//    let imageKey: ImageKey? = nil
//    func visualDown() {
//        if let symbolKey = symbolKey {
//            symbolKey.visualDown()
//        }
//        if let imageKey = imageKey {
//            imageKey.visualDown()
//        }
//    }
//    func visualUp()   {
//        if let symbolKey = symbolKey {
//            symbolKey.visualUp()
//        }
//        if let imageKey = imageKey {
//            imageKey.visualUp()
//        }
//    }
//    func view() -> AnyView {
//        if let symbolKey = symbolKey {
//            return symbolKey.view()
//        }
//        if let imageKey = imageKey {
//            return imageKey.view()
//        }
//        return AnyView(EmptyView())
//    }
//    init(width: CGFloat, height: CGFloat) {
//        self.width = width
//        self.height = height
//    }
//    init(width: CGFloat, height: CGFloat, symbol: String, txtColor: Color, upColor: Color, downColor: Color) {
//        self.width = width
//        self.height = height
//        symbolKey = SymbolKey(symbol: symbol, txtColor: txtColor, upColor: upColor, downColor: downColor)
//    }
//    init(width: CGFloat, height: CGFloat, imageName: String, borderColor: Color, borderwidth: CGFloat) {
//        self.width = width
//        self.height = height
//        imageKey = ImageKey(imageName: imageName, borderColor: borderColor, borderwidth: borderwidth)
//    }
}
