//
//  FlagView.swift
//  Calculator
//
//  Created by Joachim Neumann on 23.11.2024.
//


import SwiftUI

struct FlagView: View {
    let model: FlagViewModel

    @GestureState private var isPressed = false
    @State private var isDragging = false

    var body: some View {
        GeometryReader { geometry in
            model.image
                .resizable()
                .frame(maxWidth: .infinity)
                .clipShape(Capsule())
                .padding(model.padding)
                .brightness(isPressed ? 0.2 : 0.0)
                .overlay(
                    Capsule()
                        .stroke(model.borderColor, lineWidth: model.borderWidth)
                )
                .padding(model.padding)
                .scaleEffect(isPressed ? 0.95 : 1.0) // Optional scale effect
                .animation(.easeInOut, value: isPressed)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // Detect if the drag is turning into a scroll gesture
                            if abs(value.translation.height) > 10 {
                                isDragging = true
                            }
                        }
                        .updating($isPressed) { _, isPressed, _ in
                            if !isDragging {
                                isPressed = true
                            }
                        }
                        .onEnded { value in
                            if !isDragging {
                                model.pressed()
                            }
                            isDragging = false // Reset drag state
                        }
                )
                .onAppear() {
                    //print("onAppear geometry.size \(geometry.size)")
                    model.newSize(geometry.size)
                }
        }
    }
}

#Preview {
    let flagViewModel1 = FlagViewModel(persistent: TranslatePersistent())
    let flagViewModel2 = FlagViewModel(persistent: TranslatePersistent(), languageEnum: .german)

    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagView(model: flagViewModel1)
            FlagView(model: flagViewModel2)
            FlagView(model: flagViewModel1)
            FlagView(model: flagViewModel2)
        }
        .frame(height: 100)
    }
}
