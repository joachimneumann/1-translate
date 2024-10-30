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
    @State private var imageBrightness: Double = 0.0

    @Binding var navigateToConfigView: Bool

    let key: Key
    let borderwidth: CGFloat = 2

    enum AnimationState {
        case idle
        case animatingDown
        case animatingUp
    }

    init(key: Key, navigateToConfigView: Binding<Bool>) {
        self.key = key
        self._navigateToConfigView = navigateToConfigView
        bgColorNonPending = key.sixColors.upColor
        bgColorPending = key.sixColors.pendingUpColor
    
        // print("AKey init \(key.op.getRawValue())")
        //
        // I use this print statement to check if
        // all keys are redrawn when a single key
        // is pressed. I do not want that, of course.
    }

    var body: some View {
        if let imageName = key.imageName {
            if let borderColor = key.borderColor {
                Image(imageName)
                    .resizable()
                    .frame(width: key.keySize.width-borderwidth, height: key.keySize.height-borderwidth)
                    .brightness(imageBrightness)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule().stroke(borderColor, lineWidth: borderwidth)
                    )
                    .onLongPressGesture(minimumDuration: 0.5) {
                        if key.op.isEqual(to: ClearOperation.back) {
                            let ACKey = Key(ClearOperation.clear)
                            key.callback(ACKey)
                        }
                    } onPressingChanged: { inProgress in
                        if inProgress {
                            if !self.isPressed {
                                self.isPressed = true
                                self.handlePress()
                            }
                        } else {
                            self.isPressed = false
                            self.handleRelease()
                            navigateToConfigView = true
                            key.callback(key)
                        }
                    }
            } else {
                Image(imageName)
                    .resizable()
                    .frame(width: key.keySize.width, height: key.keySize.height)
                    .clipShape(Capsule())
            }
        } else {
            Label(symbol: key.op.getRawValue(), size: key.keySize.height, color: key.isPending ? key.sixColors.pendingTextColor : key.sixColors.textColor)
                .padding()
                .frame(width: key.keySize.width, height: key.keySize.height)
                .background(key.isPending ? bgColorPending : bgColorNonPending)
                .clipShape(Capsule())
                .onLongPressGesture(minimumDuration: 0.5) {
                    if key.op.isEqual(to: ClearOperation.back) {
                        let ACKey = Key(ClearOperation.clear)
                        key.callback(ACKey)
                    }
                } onPressingChanged: { inProgress in
                    if inProgress {
                        if !self.isPressed {
                            self.isPressed = true
                            self.handlePress()
                        }
                    } else {
                        self.isPressed = false
                        self.handleRelease()
                        key.callback(key)
                    }
                }
        }
    }

    private func handlePress() {
        if animationState == .idle || animationState == .animatingUp {
            if animationState == .animatingUp {
                // Interrupt the up animation and start down animation
            }
            animationState = .animatingDown
            withAnimation(.linear(duration: key.downTime)) {
                imageBrightness = 0.3
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
            imageBrightness = 0.0
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
    @Previewable @State var x: Bool = false
    CalculatorKeyView(key: Key(InplaceOperation.sqrt3), navigateToConfigView: $x)
}
