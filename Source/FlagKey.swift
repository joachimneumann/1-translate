//
//  FlagKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 20.11.2024.

import NumberTranslator
import SwiftUI

class FlagKey: Key {
    let persistent: TranslatePersistent
    let languageEnum: NumberTranslator.LanguageEnum
    init(persistent: TranslatePersistent, languageEnum: NumberTranslator.LanguageEnum? = nil) {
        self.persistent = persistent
        self.languageEnum = languageEnum ?? persistent.currentLanguageEnum
    }
    override func view() -> AnyView {
        AnyView(FlagView(model: FlagViewModel(persistent: persistent, languageEnum: languageEnum)))
    }
}
//
//import SwiftUI
//import SwiftGmp
//import NumberTranslator
//
//@Observable class FlagKey: Key, ObservableObject {
//    private var languageEnum: NumberTranslator.LanguageEnum
//    private var persistent: TranslatePersistent
//    private var image: Image
//    var isToggleButton: Bool
//    var pressed: () -> ()
//    private let borderColor: Color = Color(AppleColor.darkGray)
//#if TRANSLATE_MAC
//    let backgroundColor = Color(red: 52/255, green: 54.0 / 255.0, blue: 56.0 / 255.0, opacity: 1.0)
//#else
//    let backgroundColor = Color.black
//#endif
//    
//    //    init(name: String) {
//    //
//    //    }
//    
//    init(_ languageEnum: NumberTranslator.LanguageEnum, persistent: TranslatePersistent) {
//        self.languageEnum = languageEnum
//        self.image = Image(persistent.flagName(languageEnum))
//        self.persistent = persistent
//        self.isToggleButton = false
//    }
//    
//    func set(_ language: NumberTranslator.LanguageEnum) {
//        self.languageEnum = languageEnum
//        self.image = Image(persistent.flagName(languageEnum))
//    }
//    
//    var borderWidth: CGFloat = 0.0
//    var padding: CGFloat {
//        0.5 * borderWidth
//    }
//
//    func image(in rect: CGSize) -> Image {
//        let name = persistent.flagName(languageEnum)
//        if rect.width < rect.height * 1.1 {
//            if AppleImage(named: name+"Sqr") != nil {
//                return Image(name+"Sqr")
//           }
//        } else {
//            if AppleImage(named: name) != nil {
//                return Image(name)
//            }
//        }
//        return Image("English")
//    }
//    
//    override func view() -> AnyView {
//        return AnyView(GeometryReader { geometry in
//            CustomPressableButton(
//                languageEnum: self.languageEnum,
//                persistent: self.persistent,
//                image: self.image,
//                padding: self.padding,
//                borderColor: self.borderColor,
//                borderWidth: self.borderWidth,
//                isToggleButton: self.isToggleButton)
//            .onAppear() {
//                self.borderWidth = ceil(min(geometry.size.width, geometry.size.height) * 0.04)
//                self.image = self.image(in: geometry.size)
//            }
//        })
//    }
//    
//    struct CustomPressableButton: View {
//        let languageEnum: NumberTranslator.LanguageEnum
//        var persistent: TranslatePersistent
//        let image: Image
//        let padding: CGFloat
//        let borderColor: Color
//        let borderWidth: CGFloat
//        let isToggleButton: Bool
//
//        @GestureState private var isPressed = false
//        @State private var isDragging = false
//
//        var body: some View {
//            image
//                .resizable()
//                .frame(maxWidth: .infinity)
//                .clipShape(Capsule())
//                .padding(padding)
//                .brightness(isPressed ? 0.2 : 0.0)
//                .overlay(
//                    Capsule()
//                        .stroke(borderColor, lineWidth: borderWidth)
//                )
//                .padding(padding)
//                .scaleEffect(isPressed ? 0.95 : 1.0) // Optional scale effect
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
//                                if isToggleButton {
//                                    persistent.toggle()
//                                } else {
//                                    persistent.languageSelected?.set(languageEnum)
//                                }
//                            }
//                            isDragging = false // Reset drag state
//                        }
//                )
//        }
//    }
//    
//}
//
//

#Preview {
    let persistent = TranslatePersistent()
    let _ = persistent.currentLanguageEnum = .italian
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagKey(persistent: persistent, languageEnum: .german).view()
            FlagKey(persistent: persistent, languageEnum: .english).view()
            FlagKey(persistent: persistent, languageEnum: .ukrainian).view()
            FlagKey(persistent: persistent).view()
        }
        .frame(height: 100)
    }
}
