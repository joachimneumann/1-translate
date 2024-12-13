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
                .frame(width: key.width, height: key.height)
                .clipShape(Capsule())
                .neumorphicKey(width: key.width, height: key.height, key.visualState)
            key.view
        }
        .keyGestures(key: key, width: key.width, height: key.height)
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

