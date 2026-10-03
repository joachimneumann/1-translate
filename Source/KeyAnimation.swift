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

    var callback: (KeyAnimation) -> () = { _ in }

    private var isPressed = false
    private var visualTransitionTimer: Timer?

    private let transitionDuration: Double = 0.15

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

        callback(self)
        isPressed = false

        transition(to: .up)
    }
}

private extension KeyAnimation {
    func handleTouchInside() {
        guard !isPressed else { return }
        isPressed = true

        transition(to: .down)
    }

    func handleTouchOutside() {
        isPressed = false
        cancelVisualTransition()
        animate(to: .up, duration: transitionDuration)
    }

    func transition(to state: Neumorphic.VisualState) {
        // A new press or release interrupts the previous transition.
        cancelVisualTransition()
        let phaseDuration = transitionDuration / 2
        animate(to: .center, duration: phaseDuration)
        visualTransitionTimer = Timer.scheduledTimer(withTimeInterval: phaseDuration, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.visualTransitionTimer = nil
            self.animate(to: state, duration: phaseDuration)
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
