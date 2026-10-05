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
    private(set) var visualResetID = 0
    let id = UUID()

    var callback: (KeyAnimation) -> () = { _ in }

    private var isPressed = false
    private var pressStartedAt: TimeInterval?
    private var visualTransitionTimer: Timer?

    private let transitionDuration: Double = 0.15
    private let pressedHoldDuration: Double = 0.06

    deinit {
        cancelVisualTransition()
    }

    func longPress() {
        // Ignore long press, except clear/back -> clear all.
        guard let model = self as? KeyModel,
              let op = model.symbolKey?.op,
              op.isEqual(to: ClearOperation.clear) || op.isEqual(to: ClearOperation.back) else { return }
        model.callback(KeyModel(op: ClearOperation.clear))
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

        let releasedEarly = pressStartedAt.map {
            ProcessInfo.processInfo.systemUptime - $0 < transitionDuration
        } ?? false
        callback(self)
        isPressed = false
        pressStartedAt = nil

        if releasedEarly {
            snapToDown()
            scheduleVisualTransition(after: pressedHoldDuration) { key in
                key.transition(to: .up)
            }
        } else {
            transition(to: .up)
        }
    }
}

private extension KeyAnimation {
    func handleTouchInside() {
        guard !isPressed else { return }
        isPressed = true
        pressStartedAt = ProcessInfo.processInfo.systemUptime

        transition(to: .down)
    }

    func handleTouchOutside() {
        isPressed = false
        pressStartedAt = nil
        cancelVisualTransition()
        animate(to: .up, duration: transitionDuration)
    }

    func transition(to state: Neumorphic.VisualState) {
        // A new press or release interrupts the previous transition.
        cancelVisualTransition()
        let phaseDuration = transitionDuration / 2
        animate(to: .center, duration: phaseDuration)
        scheduleVisualTransition(after: phaseDuration) { key in
            key.animate(to: state, duration: phaseDuration)
        }
    }

    func snapToDown() {
        cancelVisualTransition()
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            visualState = .down
            // Recreate the visuals to stop an animation already targeting .down.
            visualResetID += 1
        }
    }

    func scheduleVisualTransition(after delay: TimeInterval, action: @escaping (KeyAnimation) -> Void) {
        cancelVisualTransition()
        visualTransitionTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.visualTransitionTimer = nil
            action(self)
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
