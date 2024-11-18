//
//  Imagekey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

struct ImageKeyView: View {
    var model: ImageKeyViewModel
    
    var body: some View {
        self.model.image
            .resizable()
            .scaledToFill()
            .frame(width: self.model.reducedWidth, height: self.model.reducedheight)
            .clipShape(Capsule())
            .padding(self.model.padding)
            .brightness(self.model.brightness)
            .overlay(
                Capsule()
                    .stroke(self.model.borderColor, lineWidth: self.model.borderWidth)
            )
            .brightness(self.model.brightness)
            .padding(self.model.padding)
    }
}

struct ImageKeyGeo: View {
    var model: ImageKeyViewModel
    
    init(_ model: ImageKeyViewModel) {
        self.model = model
    }
    init(_ name: String) {
        self.model = ImageKeyViewModel(name: name, borderColor: .gray, isCircle: true)
    }
    var body: some View {
        GeometryReader { geometry in
            if geometry.size != .zero {
                ImageKeyView(model: self.model)
                .onAppear {
                    model.size = geometry.size
                }
                .onChange(of: geometry.size) { oldValue, newValue in
                    model.size = newValue
                }
            }
        }
    }
}

@Observable class Imagekey: Key {
    let model: ImageKeyViewModel
    
    init(_ name: String, borderColor: Color = Color(AppleColor.darkGray), isCircle: Bool = false) {
        self.model = ImageKeyViewModel(name: name, borderColor: borderColor, isCircle: isCircle)
        super.init()
        self.visualUpDownDelegate = model
    }
        
    override func view() -> AnyView {
        AnyView(ImageKeyGeo(model))
    }
}


#Preview {
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            Imagekey("English").view()
            Imagekey("Esperanto").view()
            Imagekey("Deutsch").view()
            ImageKeyGeo("Español")
        }
    }
}
