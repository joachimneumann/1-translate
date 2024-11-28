//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp

enum VisualPressedState {
    case up
    case center
    case down
}

@Observable class Key: Identifiable {
    let id = UUID()  // unique identifier
    private var isPressed: Bool = false
    private var downTimer: Timer? = nil
    private var downTime: Double = 1.15
    private var upTime: Double = 1.4
    var visualPressed: VisualPressedState = .up

    func visualDown1() { visualPressed = .center }
    func visualDown2() { visualPressed = .down }
    func visualUp1()   { visualPressed = .center }
    func visualUp2()   { visualPressed = .up }

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

    func down(_ location: CGPoint, in diameter: CGFloat) {
        down(location, in: CGSize(width: diameter, height: diameter))
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
                withAnimation(.linear(duration: downTime * 0.5)) {
                    visualDown1()
                }
                withAnimation(.linear(duration: downTime * 0.5).delay(downTime * 0.5)) {
                    visualDown2()
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
            withAnimation(.linear(duration: upTime * 0.5)) {
                visualUp1()
            }
            withAnimation(.linear(duration: upTime * 0.5).delay(upTime * 0.5)) {
                visualUp2()
            }
        }
    }

    func up() {
        if isPressed {
            callback(self)
            isPressed = false
            if downTimer != nil { return }
            withAnimation(.linear(duration: upTime * 0.5)) {
                visualUp1()
            }
            withAnimation(.linear(duration: upTime * 0.5).delay(upTime * 0.5)) {
                visualUp2()
            }
        }
    }

    private func downTimerFired() {
        downTimer = nil
        if !isPressed {
            withAnimation(.linear(duration: upTime * 0.5)) {
                visualUp1()
            }
            withAnimation(.linear(duration: upTime * 0.5).delay(upTime * 0.5)) {
                visualUp2()
            }
        }
    }
}
