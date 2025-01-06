//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct CalculatoriOSView: View {
    let model: ViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                Spacer()
                NumberDisplay(display: model.display)
                    .padding(.horizontal, model.keyboard.padding)
                    .frame(height: model.displayFrame.height)
                KeyboardView(keyboard: model.keyboard)
            }
        }
    }
}

#Preview("Dark") {
    GeometryReader { geometry in
        let width = min(geometry.size.width, geometry.size.height)
        let height = max(geometry.size.width, geometry.size.height)
        let model = ViewModel(width: width, height: height)
        CalculatoriOSView(model: model)
            .preferredColorScheme(.dark)
    }
}

#Preview("Light") {
    GeometryReader { geometry in
        let width = min(geometry.size.width, geometry.size.height)
        let height = max(geometry.size.width, geometry.size.height)
        let model = ViewModel(width: width, height: height)
        CalculatoriOSView(model: model)
            .preferredColorScheme(.light)
    }
}

