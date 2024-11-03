//
//  ImageKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

@Observable class ImageKey: BaseKey {
    let imageName: String
    let borderColor: Color
    let borderwidth: CGFloat
    var brightness: Double = 0.0
    
//    init(width: CGFloat, height: CGFloat, op: any OpProtocol) {
//        self.im
//        super.init(width: width, height: height)
//    }
    init(width: CGFloat, height: CGFloat, imageName: String, borderColor: Color, borderwidth: CGFloat) {
        self.imageName = imageName
        self.borderColor = borderColor
        self.borderwidth = borderwidth
        super.init(width: width, height: height)
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
    @Previewable @State var x: ImageKey = ImageKey(width: 100.0, height: 100.0, imageName: "English", borderColor: .green, borderwidth: 5.0)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
    }
}
