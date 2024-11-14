//
//  Imagekey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

@Observable class Imagekey: Key {
    var imageName: String
    var borderColor: Color
    var borderwidth: CGFloat
    var brightness: Double = 0.0
    
    init(imageName: String, borderColor: Color?, borderwidth: CGFloat) {
        self.imageName = imageName
        if let borderColor = borderColor {
            self.borderColor = borderColor
            self.borderwidth = 3.0//borderwidth
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
            Image(imageName)
                .resizable()
                .scaledToFill()
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
    @Previewable @State var x: Imagekey = Imagekey(imageName: "Vietnamese", borderColor: .green, borderwidth: 3)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
    }
}
