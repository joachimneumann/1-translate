//
//  FlagView.swift
//  Calculator
//
//  Created by Joachim Neumann on 20.11.2024.
//

import SwiftUI

struct FlagView: View {
    var flagKey: FlagKey
    
    var body: some View {
        flagKey.view()
    }
}


#Preview {
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagView(flagKey: FlagKey("Deutsch"))
            FlagView(flagKey: FlagKey("Dansk"))
            FlagView(flagKey: FlagKey("Babylonian"))
            FlagView(flagKey: FlagKey("Español"))
        }
        .frame(height: 100)
    }
}
