//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct CalculatoriOSView: View {
    let model: ViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            if model.showsSettingsBesideDisplay {
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: model.keyboard.spacing) {
                        if !model.usesSystemToolbar {
                            VStack(spacing: 0) {
                                KeyView(key: model.settingsKey)
                                    .frame(height: model.displayFrame.height)
                                    .zIndex(1)
                                if model.isDisplayExpanded {
                                    VStack(spacing: model.keyboard.spacing) {
                                        KeyView(key: model.copyKey)
                                            .frame(height: model.copyKey.height)
                                            .accessibilityLabel("Copy number")
                                            .accessibilityAddTraits(.isButton)
                                            .accessibilityAction { model.execute(model.copyKey) }
                                        KeyView(key: model.pasteKey)
                                            .frame(height: model.pasteKey.height)
                                            .accessibilityLabel("Paste number")
                                            .accessibilityAddTraits(.isButton)
                                            .accessibilityAction { model.execute(model.pasteKey) }
                                        if let message = model.clipboardMessage {
                                            Text(message)
                                                .font(.caption)
                                                .foregroundColor(Color.Neumorphic.text)
                                                .multilineTextAlignment(.center)
                                                .transition(.opacity)
                                        }
                                    }
                                    .padding(.top, model.keyboard.spacing)
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                }
                            }
                            .frame(width: model.settingsKey.width, height: model.currentDisplayHeight, alignment: .top)
                        }
                        NumberDisplay(display: model.display, isExpanded: model.isDisplayExpanded, compactHeight: model.displayFrame.height)
                            .frame(width: model.displayFrame.width - 2 * model.keyboard.padding)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    model.toggleDisplayExpansion()
                                }
                            }
                    }
                    .padding(.horizontal, model.keyboard.padding)
                    .frame(width: model.keyboard.keyboardFrame.width, height: model.currentDisplayHeight)
                    KeyboardView(keyboard: model.keyboard)
                        .allowsHitTesting(!model.isDisplayExpanded)
                        .accessibilityHidden(model.isDisplayExpanded)
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: model.width, height: model.height, alignment: .top)
                .offset(y: model.displayTopInset)
                .clipped()
            } else {
                VStack(spacing: 0) {
                    Spacer()
                    NumberDisplay(display: model.display)
                        .padding(.horizontal, model.keyboard.padding)
                        .frame(height: model.displayFrame.height)
                    KeyboardView(keyboard: model.keyboard)
                }
            }
        }
        .overlay(alignment: .bottom) {
            if model.usesSystemToolbar, let message = model.clipboardMessage {
                Text(message)
                    .font(.caption)
                    .padding(10)
                    .background(.regularMaterial, in: Capsule())
                    .padding()
                    .transition(.opacity)
                    .allowsHitTesting(false)
            }
        }
    }
}

#Preview("Dark") {
    GeometryReader { geometry in
        let width = min(geometry.size.width, geometry.size.height)
        let height = max(geometry.size.width, geometry.size.height)
        let model = ViewModel()
        let _ = model.updateDimensions(width: width, height: height)
        CalculatoriOSView(model: model)
            .preferredColorScheme(.dark)
    }
}

#Preview("Light") {
    GeometryReader { geometry in
        let width = min(geometry.size.width, geometry.size.height)
        let height = max(geometry.size.width, geometry.size.height)
        let model = ViewModel()
        let _ = model.updateDimensions(width: width, height: height)
        CalculatoriOSView(model: model)
            .preferredColorScheme(.light)
    }
}
