//
//  KeyView.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import Neumorphic

struct KeyView: View {
    let key: KeyModel
    var body: some View {
        ZStack {
            Color.Neumorphic.main
                .frame(width: key.diameter, height: key.diameter)
                .clipShape(Circle())
                .neumorphicKey(diameter: key.diameter, key.visualState)
            key.view
        }
        .keyGestures(key: key, diameter: key.diameter)
    }
}

#Preview("Dark") {
    Demo()
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo()
        .preferredColorScheme(.light)
}

