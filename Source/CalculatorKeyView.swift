//
//  CalculatorKeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct CalculatorKeyView: View {
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
    
        // print("AKey init \(key.op.getRawValue())")
        //
        // I use this print statement to check
        // if all keys are redrawn when a single key
        // is pressed (which is not want I want, of course)
    }

    var body: some View {
        Label(symbol: key.op.getRawValue(), size: key.keySize.height, color: key.isPending ? key.sixColors.pendingTextColor : key.sixColors.textColor)
            .padding()
            .frame(width: key.keySize.width, height: key.keySize.height)
            .background(key.isPending ? bgColorPending : bgColorNonPending)
            .clipShape(Capsule())
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

import SwiftGmp

#Preview {
    CalculatorKeyView(key: AKey(InplaceOperation.sqrt3))
}
