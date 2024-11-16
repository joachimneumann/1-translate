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
    var brightness: Double = 0.0
    
    init(imageName: String, borderColor: Color?) {
        self.imageName = imageName
        if let borderColor = borderColor {
            self.borderColor = borderColor
        } else {
            self.borderColor = .clear
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
            GeometryReader { geometry in
                if geometry.notZero {
                    let borderwidth = geometry.size.height * 0.08
                    Image(self.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width-2*borderwidth, height: geometry.size.height-2*borderwidth)
                        .clipShape(Capsule())
                        .padding(0.5*borderwidth)
                        .brightness(self.brightness)
                        .overlay(
                            Capsule()
                                .stroke(self.borderColor, lineWidth: borderwidth)
                        )
                        .brightness(self.brightness)
                        .padding(0.5*borderwidth)
                }
            }
        )
    }
}


#Preview {
    @Previewable @State var x: Imagekey = Imagekey(imageName: "Vietnamese", borderColor: .gray)
    ZStack {
        Rectangle()
            .foregroundColor(.black)
        x.view()
            .frame(width: 100, height: 60)
    }
}
