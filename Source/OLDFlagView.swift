////
////  FlagView.swift
////  Calculator
////
////  Created by Joachim Neumann on 23.11.2024.
////
//
//
//import SwiftUI
//
//struct FlagView: View {
//    let model: FlagKey
//
//    @GestureState private var isPressed = false
//    @State private var isDragging = false
//    
//    var body: some View {
//        //let _ = print("flagView init")
//        GeometryReader { geometry in
//            model.image
//                .resizable()
//                .scaledToFill()
//                .frame(width: geometry.size.width, height: geometry.size.height)
//                .clipShape(Capsule())
//                .brightness(isPressed ? 0.2 : 0.0)
//                .scaleEffect(isPressed ? 0.95 : 1.0)
//                .animation(.easeInOut, value: isPressed)
//                .simultaneousGesture(
//                    DragGesture(minimumDistance: 0)
//                        .onChanged { value in
//                            // Detect if the drag is turning into a scroll gesture
//                            if abs(value.translation.height) > 10 {
//                                isDragging = true
//                            }
//                        }
//                        .updating($isPressed) { _, isPressed, _ in
//                            if !isDragging {
//                                isPressed = true
//                            }
//                        }
//                        .onEnded { value in
//                            if !isDragging {
//                                model.pressed()
//                            }
//                            isDragging = false // Reset drag state
//                        }
//                )
//                .onAppear() {
//                    //print("onAppear geometry.size \(geometry.size)")
//                    model.newSize(geometry.size)
//                }
//        }
//    }
//}
//
//#Preview {
//    let flagKey1 = FlagKey(persistent: TranslatePersistent())
//    let flagKey2 = FlagKey( persistent: TranslatePersistent(), languageEnum: .romanNumerals)
//
//    ZStack {
//        Rectangle()
//            .foregroundColor(.gray)
//        HStack(spacing: 0.0) {
//            FlagView(model: flagKey1)
//            FlagView(model: flagKey2)
//            FlagView(model: flagKey1)
//            FlagView(model: flagKey2)
//        }
//        .frame(height: 200)
//        .background(.black)
//    }
//}
