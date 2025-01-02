//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct CalculatoriOSView: View {
    let model: CalculatoriOSViewModel
    
    var body: some View {
        //let _ = print("CalculatoriOSView body()")
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                Spacer()
                NumberDisplay(display: model.display)
                    .padding(.horizontal, model.keyboard.padding)
                    .padding(.bottom, model.keyboard.padding * 0.2)
                    .frame(width: model.displayFrame.width, height: model.displayFrame.height)
                HStack {
                    Spacer()
                    KeyboardView(keyboard: model.keyboard)
                        .frame(width: model.keyboard.keyboardFrame.width, height: model.keyboard.keyboardFrame.height)
                    Spacer()
                }
            }
        }
        .onAppear() {
            print("onAppear \(UIDevice.current.orientation)")
            model.newOrientation(UIDevice.current.orientation)
        }
        .onRotate { newOrientation in
            print("onRotate current: \(UIDevice.current.orientation) new: \(newOrientation)")
            model.newOrientation(newOrientation)
        }
    }
}

// Custom view modifier to track rotation
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                print("received did change \(UIDevice.current.orientation)")
                action(UIDevice.current.orientation)
            }
    }
}

// Wrapper
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

#Preview("Dark") {
    CalculatoriOSView(model: CalculatoriOSViewModel(
        deviceWidth: devicePortraitWidth,
        deviceHeight: devicePortraitHeight,
        isTranslator: false,
        isMac: false))
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    CalculatoriOSView(model: CalculatoriOSViewModel(
        deviceWidth: devicePortraitWidth,
        deviceHeight: devicePortraitHeight,
        isTranslator: false,
        isMac: false))
        .preferredColorScheme(.light)
}

