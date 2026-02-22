//
//  KeyAnimation.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp
import Neumorphic

@Observable class KeyAnimation: Identifiable {
    var visualState: Neumorphic.VisualState = .up
    let id = UUID()

    var callback: (KeyAnimation) -> () = { _ in
        print("NOT IMPLEMENTED CALLBACK")
    }

    private var isPressed = false
    private var visualTransitionTimer: Timer?

    private let downTime: Double = 0.15
    private let upTime: Double = 0.15
    private let firstPhaseFactor: Double = 0.5
    private let secondPhaseFactor: Double = 0.5

    deinit {
        cancelVisualTransition()
    }

    func longPress() {
        // Ignore long press, except clear/back -> clear all.
        if let model = self as? KeyModel {
            if let symbol = model.symbolKey {
                if symbol.op.isEqual(to: ClearOperation.clear) || symbol.op.isEqual(to: ClearOperation.back) {
                    model.callback(KeyModel(op: ClearOperation.clear))
                }
            }
        }
    }

    func down(_ location: CGPoint, in size: CGSize) {
        let tolerance: CGFloat = 0.3 * size.width
        let touchRect = CGRect(
            x: -tolerance,
            y: -tolerance,
            width: size.width + (2.0 * tolerance),
            height: size.height + (2.0 * tolerance)
        )

        if touchRect.contains(location) {
            handleTouchInside()
        } else {
            handleTouchOutside()
        }
    }

    func up() {
        guard isPressed else { return }

        callback(self)
        isPressed = false

        // Release always interrupts a pending press animation.
        cancelVisualTransition()
        animateToUpInTwoPhases()
    }
}

private extension KeyAnimation {
    func handleTouchInside() {
        guard !isPressed else { return }
        isPressed = true

        animateToDownInTwoPhases()
    }

    func handleTouchOutside() {
        isPressed = false
        cancelVisualTransition()
        animate(to: .up, duration: upTime)
    }

    func animateToDownInTwoPhases() {
        animate(to: .center, duration: downTime * firstPhaseFactor)
        scheduleVisualTransition(after: downTime * firstPhaseFactor) {
            self.animate(to: .down, duration: self.downTime * self.secondPhaseFactor)
        }
    }

    func animateToUpInTwoPhases() {
        animate(to: .center, duration: upTime * firstPhaseFactor)
        scheduleVisualTransition(after: upTime * firstPhaseFactor) {
            self.animate(to: .up, duration: self.upTime * self.secondPhaseFactor)
        }
    }

    func scheduleVisualTransition(after delay: Double, action: @escaping () -> Void) {
        cancelVisualTransition()
        visualTransitionTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }

    func cancelVisualTransition() {
        visualTransitionTimer?.invalidate()
        visualTransitionTimer = nil
    }

    func animate(to state: Neumorphic.VisualState, duration: Double) {
        withAnimation(.linear(duration: duration)) {
            visualState = state
        }
    }
}
