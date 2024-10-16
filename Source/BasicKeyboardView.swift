//
//  BasicKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct BasicKeyboardView: View {
    var viewModel: ViewModel
    var body: some View {
        VStack {
            ForEach(viewModel.basicKeyboard.rows) { keyRow in
                HStack {
                    ForEach(keyRow.keys) { key in
                        Text(key.label)
                            .foregroundColor(key.txtColor)
                            .frame(width: key.width, height: key.height)
                            .background(key.bgColor)
                            .clipShape(Capsule())
                            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    viewModel.keyDownX(key)
                                }
                                .onEnded { _ in
                                    viewModel.keyUpX(key)
                                })
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = ViewModel()
    BasicKeyboardView(viewModel: viewModel)
}
