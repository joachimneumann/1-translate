//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI

protocol VisualUpDownDelegate {
    func visualUp()
    func visualDown()
}

class Key: Identifiable, VisualUpDownDelegate {
    var visualUpDownDelegate: VisualUpDownDelegate? = nil
    let id = UUID()  // unique identifier
    var isPressed: Bool = false
    private var downTimer: Timer? = nil
    private var downTime: Double = 0.15
    private var upTime: Double = 0.4

    
    func visualDown() { visualUpDownDelegate?.visualDown() }
    func visualUp()   { visualUpDownDelegate?.visualUp() }
    
    open func view() -> AnyView {
        AnyView(EmptyView())
    }
    
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
