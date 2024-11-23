//
//  FlagKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 20.11.2024.
//

import SwiftUI
import SwiftGmp

class EmptySelectLanguageProtocol: SelectLanguageProtocol {
    func toggleLanguageSelector() {
        print("EmptySelectLanguageProtocol toggle")
    }
    func setLanguage(_ language: String) {
        print("EmptySelectLanguageProtocol \(language)")
    }
}


@Observable class FlagKey: Key, ObservableObject {
    
    private var _name: String = ""
    var selectLanguage: SelectLanguageProtocol
    var isToggleButton: Bool
    let borderColor: Color = Color(AppleColor.darkGray)
#if TRANSLATE_MAC
    let backgroundColor = Color(red: 52/255, green: 54.0 / 255.0, blue: 56.0 / 255.0, opacity: 1.0)
#else
    let backgroundColor = Color.black
#endif
    
    //    init(name: String) {
    //
    //    }
    
    init(_ name: String) {
        self._name = name
        self.selectLanguage = EmptySelectLanguageProtocol()
        self.isToggleButton = false
    }
    var name: String {
        _name
    }
    func setName(_ name: String) {
        self._name = name
        self.objectWillChange.send()
    }
    var image: Image = Image("English")
    
    var borderWidth: CGFloat = 0.0
    var padding: CGFloat {
        0.5 * borderWidth
    }

    override func view() -> AnyView {
        return AnyView(GeometryReader { geometry in
            CustomPressableButton(
                selectLanguage: self.selectLanguage,
                image: self.image,
                padding: self.padding,
                borderColor: self.borderColor,
                borderWidth: self.borderWidth,
                isToggleButton: self.isToggleButton,
                name: self.name)
            .onAppear() {
                self.borderWidth = ceil(min(geometry.size.width, geometry.size.height) * 0.04)
                if geometry.size.width < geometry.size.height * 1.1 {
                    if AppleImage(named: self._name+"Sqr") != nil {
                        self.image = Image(self._name+"Sqr")
                   }
                } else {
                    if AppleImage(named: self._name) != nil {
                        self.image = Image(self._name)
                    } else {
                        self.image = Image("English")
                    }
                }
            }
        })
    }
    
    struct CustomPressableButton: View {
        var selectLanguage: SelectLanguageProtocol
        let image: Image
        let padding: CGFloat
        let borderColor: Color
        let borderWidth: CGFloat
        let isToggleButton: Bool
        let name: String

        @GestureState private var isPressed = false
        @State private var isDragging = false

        var body: some View {
            image
                .resizable()
                .frame(maxWidth: .infinity)
                .clipShape(Capsule())
                .padding(padding)
                .brightness(isPressed ? 0.2 : 0.0)
                .overlay(
                    Capsule()
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .padding(padding)
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
                                if isToggleButton {
                                    selectLanguage.toggleLanguageSelector()
                                } else {
                                    selectLanguage.setLanguage(name)
                                }
                            }
                            isDragging = false // Reset drag state
                        }
                )
        }
    }
    
}


struct FlagView: View {
    var flagKey: FlagKey
    
    var body: some View {
        flagKey.view()
    }
}

#Preview {



    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagView(flagKey: FlagKey("Deutsch"))
            FlagView(flagKey: FlagKey("Dansk"))
            FlagView(flagKey: FlagKey("Babylonian"))
            FlagView(flagKey: FlagKey("Español"))
        }
        .frame(height: 100)
    }
}
