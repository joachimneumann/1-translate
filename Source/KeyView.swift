//
//  KeyView.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct KeyView: View {
    let key: KeyModel
    var body: some View {
        ZStack {
            Color.Neumorphic.main
                .frame(width: key.diameter, height: key.diameter)
                .clipShape(Circle())
                .neumorphic(diameter: key.diameter, key.visualState)
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

