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
    var size: CGSize = CGSize.zero
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
    var flagName: String {
        if size.width < size.height * 1.1 {
            if AppleImage(named: _name+"Sqr") != nil {
                return _name+"Sqr"
            }
        }
        if AppleImage(named: _name) != nil {
            return _name
        }
        return "English"
    }
    
    var image: Image {
        Image(flagName)
    }
    var borderWidth: CGFloat {
        ceil(min(size.width, size.height) * 0.04)
    }
    var reducedWidth: CGFloat {
        size.width - 2 * borderWidth
    }
    var reducedheight: CGFloat {
        size.height - 2 * borderWidth
    }
    var padding: CGFloat {
        0.5 * borderWidth
    }
    
    override func view() -> AnyView {
        AnyView(GeometryReader { geometry in
            Button {
                print("flag \(self.name) pressed. isToggleButton=\(self.isToggleButton)")
                if self.isToggleButton {
                    self.selectLanguage.toggleLanguageSelector()
                } else {
                    self.selectLanguage.setLanguage(self.name)
                }
            } label: {
                self.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: self.reducedWidth, height: self.reducedheight)
                    .clipShape(Capsule())
                    .padding(self.padding)
                    .overlay(
                        Capsule()
                            .stroke(self.borderColor, lineWidth: self.borderWidth)
                    )
                    .padding(self.padding)
            }
            .onAppear() {
                self.size = geometry.size
            }
        })
    }

}
