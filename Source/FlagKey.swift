//
//  FlagKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

@Observable class FlagKey: Key {
    var flagname: String
    var borderColor: Color
    var borderwidth: CGFloat
    var brightness: Double = 0.0
    
    init(flagname: String, borderColor: Color? = nil, borderwidth: CGFloat = 5.0) {
        self.flagname = flagname
        if let borderColor = borderColor {
            self.borderColor = borderColor
            self.borderwidth = borderwidth
        } else {
            self.borderColor = .clear
            self.borderwidth = 0.0
        }
        super.init()
    }
    
    override func visualDown() {
        brightness = 0.3
    }
    override func visualUp() {
        brightness = 0.0
    }
    override func view() -> AnyView {
        return AnyView(
            Image(flagname)
                .resizable()
                .frame(width: width-2*borderwidth, height: height-2*borderwidth)
                .clipShape(Capsule())
                .padding(0.5*borderwidth)
                .brightness(brightness)
                .overlay(
                    Capsule()
                        .stroke(borderColor, lineWidth: borderwidth)
                )
                .brightness(brightness)
                .padding(0.5*borderwidth)
        )
    }
}


#Preview {
    @Previewable @State var x: FlagKey = FlagKey(flagname: "English", borderColor: .green)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
    }
}
