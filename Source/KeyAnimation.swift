//
//  KeyAnimation.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp
import Neumorphic
#if CALCULATOR_IOS && os(iOS)
import UIKit
#endif

@Observable class KeyAnimation: Identifiable {
    var visualState: Neumorphic.VisualState = .up
    private(set) var visualResetID = 0
    private(set) var isPending = false
    var isEnabled = true
    let id = UUID()

    var callback: (KeyAnimation) -> () = { _ in }
    var pressBegan: (KeyAnimation) -> () = { _ in }

    private var isPressed = false
    private var pressStartedAt: TimeInterval?
    private var visualTransitionTimer: Timer?
#if CALCULATOR_IOS && os(iOS)
    private static let pressFeedback = UIImpactFeedbackGenerator(style: .soft)
    private var hasPlayedPressFeedback = false
#endif

    private let pressDuration: Double = 0.08
    private let releaseDuration: Double = 0.18
    private let pressedHoldDuration: Double = 0.10

    deinit {
        cancelVisualTransition()
    }

    func setPending(_ pending: Bool) {
        guard isPending != pending else { return }
        isPending = pending

        // A touched key waits until key-up to choose its resting state.
        guard !isPressed else { return }
        transition(to: pending ? .down : .up)
    }

    func longPress() {
        // Ignore long press, except clear/back -> clear all.
        guard isEnabled, let model = self as? KeyModel,
              let op = model.symbolKey?.op,
              op.isEqual(to: ClearOperation.clear) || op.isEqual(to: ClearOperation.clearEntry) || op.isEqual(to: ClearOperation.back) else { return }
        model.callback(KeyModel(op: ClearOperation.clear))
    }

    func down(_ location: CGPoint, in size: CGSize) {
        guard isEnabled else { return }
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
#if CALCULATOR_IOS && os(iOS)
        hasPlayedPressFeedback = false
#endif
        guard isEnabled else {
            handleTouchOutside()
            return
        }
        guard isPressed else { return }

        let releasedEarly = pressStartedAt.map {
            ProcessInfo.processInfo.systemUptime - $0 < pressDuration
        } ?? false
        callback(self)
        isPressed = false
        pressStartedAt = nil

        if isPending {
            if releasedEarly {
                snapToDown()
            } else {
                cancelVisualTransition()
                animate(to: .down, duration: pressDuration / 2)
            }
            return
        }

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
        pressBegan(self)

#if CALCULATOR_IOS && os(iOS)
        // Re-entering a key during the same touch should not repeat the haptic.
        if !hasPlayedPressFeedback {
            hasPlayedPressFeedback = true
            Self.pressFeedback.impactOccurred(intensity: 0.4)
            Self.pressFeedback.prepare()
        }
#endif
        if !isPending {
            transition(to: .down)
        }
    }

    func handleTouchOutside() {
        isPressed = false
        pressStartedAt = nil
        cancelVisualTransition()
        animate(to: isPending ? .down : .up, duration: releaseDuration)
    }

    func transition(to state: Neumorphic.VisualState) {
        // A new press or release interrupts the previous transition.
        cancelVisualTransition()
        let phaseDuration = (state == .down ? pressDuration : releaseDuration) / 2
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
