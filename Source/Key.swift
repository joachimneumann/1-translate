//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp

class Key: Identifiable {
    let id = UUID()  // unique identifier
    var isPressed: Bool = false
    private var downTimer: Timer? = nil
    private var downTime: Double = 0.15
    private var upTime: Double = 0.4

    
    func visualDown() {  }
    func visualUp()   {  }
    
    open func view() -> AnyView {
        AnyView(EmptyView())
    }
    
    var callback: (Key) -> () = { _ in }

    func longPress() {
        if let symbolKey = self as? SymbolKey {
            if symbolKey.model.op.isEqual(to: ClearOperation.back) {
                symbolKey.callback(SymbolKey(ClearOperation.clear))
            }
        }
    }

    func down(_ location: CGPoint, in size: CGSize) {
        let tolerance: CGFloat = 0.3 * size.width
        let touchRect = CGRect(
            x: -tolerance,
            y: -tolerance,
            width: size.width + 2.0 * tolerance,
            height: size.height + 2.0 * tolerance)
            /// If the finger moves too far away from the key
            /// handle that like a finger up event
        if touchRect.contains(location) {
            if !isPressed {
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
        } else {
            isPressed = false
            downTimer = nil
            withAnimation(.linear(duration: upTime)) {
                visualUp()
            }
        }
    }

    func up() {
        if isPressed {
            callback(self)
            isPressed = false
            if downTimer != nil { return }
            withAnimation(.linear(duration: upTime)) {
                visualUp()
            }
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
