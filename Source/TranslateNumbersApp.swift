//
//  TranslateNumbersApp.swift
//
//  Created by Joachim Neumann on 20/09/2021.
//

import SwiftUI
import SwiftGmp

public typealias AppleFont = UIFont

@main
struct TranslateNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                AnimatedButtonLabel()
//                BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))
//                TranslateNumbers(screen: Screen(geo.size))
            }
        }
    }
}


import Foundation


//struct AnimatedLabel: View {
//    @State private var isPressed = false
//    @State private var labelColor: Color = .gray
//    let upColor: Color = .gray
//    let downColor: Color = .white
//    let upTime: Double = 1.0//0.5  // Seconds
//    let downTime: Double = 1.0//0.3  // Seconds
//
//    var body: some View {
//        Text("Press Me")
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(labelColor)
//            .cornerRadius(10)
//            .foregroundColor(.red)
//            .onTapGesture(perform: handlePress) // Optional: Allow tap gesture to animate to downColor
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { _ in
//                        print("down...")
//                        if !isPressed {
//                            animateToDownColor()
//                        }
//                    }
//                    .onEnded { _ in
//                        print("up...")
//                        isPressed = false
//                        animateToUpColor()
//                    }
//            )
//            .animation(.easeInOut, value: labelColor)  // Smooth out state changes
//    }
//
//    private func animateToDownColor() {
//        print("animateToDownColor")
//        isPressed = true
//        withAnimation(.easeIn(duration: downTime)) {
//            labelColor = downColor
//        }
//    }
//
//    private func animateToUpColor() {
//        // Check if the down animation completed
//        DispatchQueue.main.asyncAfter(deadline: .now() + downTime) {
////            guard !isPressed else { return }  // Prevents re-triggering if button is held down
//            withAnimation(.easeIn(duration: upTime)) {
//                labelColor = upColor
//            }
//        }
//    }
//
//    private func handlePress() {
//        animateToDownColor()  // Optional: Tap also transitions to downColor
//    }
//}
//
struct AnimatedButtonLabel: View {
    @State private var bgColor: Color = .gray  // Start with upColor
    @State private var animationState: AnimationState = .idle
    @State private var isPressed: Bool = false

    let upColor: Color = .gray
    let downColor: Color = .white
    let textColor: Color = .red
    let upTime: Double = 1.0  // Seconds
    let downTime: Double = 1.0  // Seconds

    enum AnimationState {
        case idle
        case animatingDown
        case animatingUp
    }

    var body: some View {
        Text("Press Me")
            .padding()
            .frame(maxWidth: .infinity)
            .background(bgColor)
            .foregroundColor(textColor)
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
                    }
            )
    }

    private func handlePress() {
        if animationState == .idle || animationState == .animatingUp {
            if animationState == .animatingUp {
                // Interrupt the up animation and start down animation
            }
            animationState = .animatingDown
            withAnimation(.linear(duration: downTime)) {
                self.bgColor = self.downColor
            }
            // Schedule the completion handler after downTime
            DispatchQueue.main.asyncAfter(deadline: .now() + downTime) {
                self.downAnimationCompleted()
            }
        }
        // If already animating down, do nothing
    }

    private func handleRelease() {
        // If animating down, we wait until the animation completes
        // and then start the up animation in the completion handler
    }

    private func downAnimationCompleted() {
        if self.animationState == .animatingDown {
            if self.isPressed {
                // The button is still pressed; remain in downColor
                self.animationState = .idle
            } else {
                // Start the up animation
                self.animationState = .animatingUp
                withAnimation(.linear(duration: upTime)) {
                    self.bgColor = self.upColor
                }
                // Schedule the completion handler after upTime
                DispatchQueue.main.asyncAfter(deadline: .now() + upTime) {
                    self.upAnimationCompleted()
                }
            }
        }
    }

    private func upAnimationCompleted() {
        if self.animationState == .animatingUp {
            self.animationState = .idle
            // If the button is pressed during the up animation,
            // it would have already been handled in handlePress()
        }
    }
}
