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
        Button {
            //viewmodel.toggleSelectLanguage
            print("XX")
        } label: {
            Image(model.flagName)
                .resizable()
                .scaledToFill()
                .frame(width: self.model.reducedWidth, height: self.model.reducedheight)
                .clipShape(Capsule())
                .padding(self.model.padding)
                .overlay(
                    Capsule()
                        .stroke(self.model.borderColor, lineWidth: self.model.borderWidth)
                )
                .padding(self.model.padding)
        }
//        .buttonStyle(BlackButtonStyle(bg: model.backgroundColor))
    }
}

struct BlackButtonStyle: ButtonStyle {
    let bg: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(.red)
    }
}

@Observable class Imagekey: Key {
    let model: ImageKeyViewModel
    
    init(_ name: String, borderColor: Color = Color(AppleColor.darkGray), isCircle: Bool = false) {
        self.model = ImageKeyViewModel(name: name, borderColor: borderColor, isCircle: isCircle)
        super.init()
    }
        
    override func view() -> AnyView {
        AnyView(GeometryReader { geometry in
            if geometry.size != .zero {
                ImageKeyView(model: self.model)
                .onAppear {
                    self.model.size = geometry.size
                }
                .onChange(of: geometry.size) { oldValue, newValue in
                    self.model.size = newValue
                }
            }
        })
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
            Imagekey("Español").view()
        }
        .frame(height: 200)
    }
}
