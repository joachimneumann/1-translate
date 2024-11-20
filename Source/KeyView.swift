//
//  KeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI

struct KeyView: View {
    var key: Key
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.notZero {
                if let imageKey = key as? Imagekey {
                    imageKey.view()
                } else {
                    key.view()
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    key.down(value.location, in: geometry.size)
                                }
                                .onEnded { value in
                                    key.up()
                                })
                        .simultaneousGesture(
                            LongPressGesture(minimumDuration: 0.7)
                                .onEnded { value in
                                    key.longPress()
                                }
                        )
                }
            }
        }
    }
}

import SwiftGmp
#Preview {
    let symbol1 = SymbolKey(InplaceOperation.sqr)
    let symbol3 = SymbolKey(DigitOperation.one)
    let symbol2 = SymbolKey(DigitOperation.five)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 10) {
            KeyView(key: symbol1)
            KeyView(key: symbol2)
            KeyView(key: symbol3)
        }
        .frame(width: 320, height: 100)
    }
}
