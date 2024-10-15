//
//  NonScientificKeys.swift
//  ViewBuilder
//
//  Created by Joachim Neumann on 11/20/22.
//

import SwiftUI
import SwiftGmp

struct NonScientificKeyboard: View {
    let screen: Screen
    var viewModel: ViewModel
    
    var body: some View {
        let spacing = screen.keySpacing
        VStack(spacing: spacing) {
            HStack(spacing: spacing) {
                Key(screen, viewModel, ClearOperation.clear)
                Key(screen, viewModel, InplaceOperation.changeSign)
                Key(screen, viewModel, PercentOperation.percent)
                Key(screen, viewModel, TwoOperantOperation.div)
            }
            HStack(spacing: spacing) {
                Key(screen, viewModel, DigitOperation.seven)
                Key(screen, viewModel, DigitOperation.eight)
                Key(screen, viewModel, DigitOperation.nine)
                Key(screen, viewModel, TwoOperantOperation.mul)
            }
            HStack(spacing: spacing) {
                Key(screen, viewModel, DigitOperation.four)
                Key(screen, viewModel, DigitOperation.five)
                Key(screen, viewModel, DigitOperation.six)
                Key(screen, viewModel, TwoOperantOperation.sub)
            }
            HStack(spacing: spacing) {
                Key(screen, viewModel, DigitOperation.one)
                Key(screen, viewModel, DigitOperation.two)
                Key(screen, viewModel, DigitOperation.three)
                Key(screen, viewModel, TwoOperantOperation.add)
            }
            HStack(spacing: spacing) {
                Key(screen, viewModel, DigitOperation.zero)
                Key(screen, viewModel, DigitOperation.zero)
                Key(screen, viewModel, DigitOperation.dot)
                Key(screen, viewModel, EqualOperation.equal)
            }
        }
        .background(.yellow)
    }
}

//struct NonScientificKeys_Previews: PreviewProvider {
//    static var previews: some View {
//        NonScientificKeys(model: Model(), spaceBetweenKeys: 10, size: CGSize(width: 250, height: 300))
//    }
//}

