//
//  KeyColor.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import SwiftGmp

struct KeyColor {
    private struct ThreeColors {
        var textColor: Color
        var upColor: Color
        var downColor: Color
        private init(textColor: Color, upColor: Color, downColor: Color) {
            self.textColor = textColor
            self.upColor = upColor
            self.downColor = downColor
        }
        init(_ textGrayscale: CGFloat, _ upGrayscale: CGFloat, _ downGrayscale: CGFloat) {
            self.init(textColor: Color(white: textGrayscale),
                      upColor:   Color(white: upGrayscale),
                      downColor: Color(white: downGrayscale))
        }
    }
    
#if os(macOS)
    //    private let digitColors             = ThreeColors(0.90, 0.80, 0.45)
    //    private let operatorColors          = ThreeColors(0.90, 0.40, 0.70)
    //    private let pendingOperatorColors   = ThreeColors(0.30, 0.90, 0.80)
    //    private let scientificColors        = ThreeColors(0.90, 0.30, 0.32)
    //    private let pendingScientificColors = ThreeColors(0.30, 0.70, 0.60)
    //    private let secondColors            = ThreeColors(0.90, 0.30, 0.12)
    //    private let secondActiveColors      = ThreeColors(0.20, 0.60, 0.60)
    private let digitColors             = ThreeColors(1.000, 0.490, 0.690)
    private let operatorColors          = ThreeColors(0.925, 0.396, 0.498)
    private let pendingOperatorColors   = ThreeColors(0.300, 0.900, 0.800)
    private let scientificColors        = ThreeColors(0.925, 0.396, 0.498)
    private let pendingScientificColors = ThreeColors(0.300, 0.700, 0.600)
    private let secondColors            = ThreeColors(0.925, 0.396, 0.498)
    private let secondActiveColors      = ThreeColors(0.925, 0.300, 0.498)
#else
    private let digitColors             = ThreeColors(1.00, 0.20, 0.45)
    private let operatorColors          = ThreeColors(1.00, 0.50, 0.70)
    private let pendingOperatorColors   = ThreeColors(0.30, 0.90, 0.80)
    private let scientificColors        = ThreeColors(1.00, 0.12, 0.32)
    private let pendingScientificColors = ThreeColors(0.30, 0.70, 0.60)
    private let secondColors            = ThreeColors(1.00, 0.12, 0.12)
    private let secondActiveColors      = ThreeColors(0.20, 0.60, 0.60)
#endif
    
    let disabledColor = Color.red
    
    private func threeColors(op: any OpProtocol) -> ThreeColors {
        switch op {
        case is InplaceOperation, is TwoOperantOperation, is PercentOperation, is ClearOperation, is EqualOperation:
            return operatorColors
        default:
            return digitColors
        }
    }
    private func pendingThreeColors(op: any OpProtocol) -> ThreeColors {
        switch op {
        case is InplaceOperation, is TwoOperantOperation, is PercentOperation:
            return pendingOperatorColors
        default:
            return threeColors(op: op)
        }
    }
    func backgroundUpColorFor(op: any OpProtocol) -> Color {
        threeColors(op: op).upColor
    }
    func pendingBackgroundUpColorFor(op: any OpProtocol) -> Color {
        pendingThreeColors(op: op).upColor
    }
    func backgroundDownColorFor(op: any OpProtocol) -> Color {
        threeColors(op: op).downColor
    }
    func textColorFor(op: any OpProtocol) -> Color {
        threeColors(op: op).textColor
    }

}
