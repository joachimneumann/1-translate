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
    
    private func imageExists(named name: String) -> Bool {
        return AppleImage(named: name) != nil
    }
    
    override func view() -> AnyView {
        return AnyView(
            GeometryReader { geometry in
                if geometry.notZero {
                    let name: String =
                        (geometry.size.width < geometry.size.height * 1.1) &&
                        (AppleImage(named: self.imageName+"Sqr") != nil) ?
                        self.imageName+"Sqr" : self.imageName
                    let borderwidth = ceil(geometry.size.height * 0.04)
                    Image(name)
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
    @Previewable @State var x: Imagekey = Imagekey(imageName: "Esperanto", borderColor: .gray)
    ZStack {
        Rectangle()
            .foregroundColor(.yellow)
        x.view()
            .frame(width: 260, height: 260)
    }
}
