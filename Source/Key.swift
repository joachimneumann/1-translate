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
    private var secondAnimationTimer: Timer? = nil
    private var downTime: Double = 0.2//0.15*1.5
    private var upTime  : Double = 0.2//0.4*1.5
    var visualPressed: VisualPressedState = .up

    func visualDown1() { visualPressed = .center }
    func visualDown2() { visualPressed = .down }
    func visualUp1()   { visualPressed = .center }
    func visualUp2()   { visualPressed = .up }

    open func view() -> AnyView {
        AnyView(EmptyView())
    }
    
    var callback: (Key) -> () = { _ in }
    var calculatorCallback: (CalculatorKey) -> () = { _ in }

    let animation1Factor: Double = 0.5//0.25
    let animation2Factor: Double = 0.5//1.0 - 0.25
    
    func longPress() {
        //print("key longPress isPressed \(isPressed)")
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
        //print("key down isPressed \(isPressed)")
        let tolerance: CGFloat = 0.3 * size.width
        let touchRect = CGRect(
            x: -tolerance,
            y: -tolerance,
            width: size.width + 2.0 * tolerance,
            height: size.height + 2.0 * tolerance)
            /// If the finger moves too far away from the key
            /// handle that like a finger up event
        if touchRect.contains(location) {
            print("key down inside isPressed \(isPressed)")
            if !isPressed {
                isPressed = true
                withAnimation(.spring(duration: downTime * animation1Factor)) {
                    print("visualDown1")
                    visualDown1()
                }
                if let timer = secondAnimationTimer, timer.isValid {
                    timer.invalidate()
                }
                secondAnimationTimer = Timer.scheduledTimer(withTimeInterval: downTime * animation1Factor, repeats: false) { _ in
                    print("visualDown2")
                    withAnimation(.spring(duration: self.downTime * self.animation2Factor)) {
                        self.visualDown2()
                    }
                }
                if let timer = downTimer, timer.isValid {
                    timer.invalidate()
                }
                downTimer = Timer.scheduledTimer(withTimeInterval: 1.4*downTime, repeats: false) { _ in
                    self.downTimerFired()
                }
            }
        } else {
            print("key down outside isPressed \(isPressed)")
            isPressed = false
            downTimer = nil
            secondAnimationTimer = nil
            // no intermediate state when moving outside
            withAnimation(.spring(duration: upTime)){//} * animation1Factor)) {
                visualUp2()
            }
        }
    }

    func up() {
        //print("key up isPressed \(isPressed)")
        if isPressed {
            callback(self)
            isPressed = false
            if downTimer != nil { return }
            withAnimation(.spring(duration: upTime * animation1Factor)) {
                visualUp1()
            }
            if let timer = secondAnimationTimer, timer.isValid {
                timer.invalidate()
            }
            secondAnimationTimer = Timer.scheduledTimer(withTimeInterval: upTime * animation1Factor, repeats: false) { _ in
                withAnimation(.spring(duration: self.upTime * self.animation2Factor)) {
                    self.visualUp2()
                }
            }
        }
    }

    private func downTimerFired() {
        downTimer = nil
        if !isPressed {
            withAnimation(.spring(duration: upTime * animation1Factor)) {
                visualUp1()
            }
            if let timer = secondAnimationTimer, timer.isValid {
                timer.invalidate()
            }
            secondAnimationTimer = Timer.scheduledTimer(withTimeInterval: upTime * animation1Factor, repeats: false) { _ in
                withAnimation(.spring(duration: self.upTime * self.animation2Factor)) {
                    self.visualUp2()
                }
            }
        }
    }
}
