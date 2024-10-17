//
//  AnimatedKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct AnimatedKey: View {
    @State private var bgColorNonPending: Color
    @State private var bgColorPending: Color
    @State private var animationState: AnimationState = .idle
    @State private var isPressed: Bool = false

    let key: AKey

    enum AnimationState {
        case idle
        case animatingDown
        case animatingUp
    }

    init(key: AKey) {
        self.key = key
        bgColorNonPending = key.sixColors.upColor
        bgColorPending = key.sixColors.pendingUpColor
    }

    var body: some View {
        Text(key.op.getRawValue())
            .padding()
            .frame(width: key.width, height: key.height)
            .background(key.isPending ? bgColorPending : bgColorNonPending)
            .foregroundColor(key.isPending ? key.sixColors.pendingTextColor : key.sixColors.textColor)
            .cornerRadius(10)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !self.isPressed {
                            self.isPressed = true
                            self.handlePress()
                        }
                    }
                    .onEnded { _ in
                        self.isPressed = false
                        self.handleRelease()
                        key.execute()
                    }
            )
    }

    private func handlePress() {
        if animationState == .idle || animationState == .animatingUp {
            if animationState == .animatingUp {
                // Interrupt the up animation and start down animation
            }
            animationState = .animatingDown
            withAnimation(.linear(duration: key.downTime)) {
                bgColorNonPending = key.sixColors.downColor
                bgColorPending = key.sixColors.pendingDownColor
            }
            // Schedule the completion handler after downTime
            DispatchQueue.main.asyncAfter(deadline: .now() + key.downTime) {
                self.downAnimationCompleted()
            }
        }
        // If already animating down, do nothing
    }

    private func handleRelease() {
        if animationState == .animatingDown {
            // The down animation is still running; we'll wait for it to complete
        } else if animationState == .idle {
            // The down animation has already completed
            // Start the up animation immediately
            startUpAnimation()
        }
        // If animating up, do nothing; shouldn't happen as button is being released
    }

    private func downAnimationCompleted() {
        if self.animationState == .animatingDown {
            if self.isPressed {
                // The button is still pressed; remain in downColor
                self.animationState = .idle
                // No further action required
            } else {
                // The button has been released during the down animation
                // Start the up animation
                startUpAnimation()
            }
        }
    }

    private func startUpAnimation() {
        self.animationState = .animatingUp
        withAnimation(.linear(duration: key.upTime)) {
            bgColorNonPending = key.sixColors.upColor
            bgColorPending = key.sixColors.pendingUpColor
        }
        // Schedule the completion handler after upTime
        DispatchQueue.main.asyncAfter(deadline: .now() + key.upTime) {
            self.upAnimationCompleted()
        }
    }

    private func upAnimationCompleted() {
        if self.animationState == .animatingUp {
            self.animationState = .idle
            // If the button is pressed during the up animation,
            // it would have been handled in handlePress()
        }
    }
}
