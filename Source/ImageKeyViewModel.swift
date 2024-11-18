//
//  ImageKeyViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI
@Observable class ImageKeyViewModel: ObservableObject, SizeAwareModel {
    var size: CGSize = CGSize.zero
    var brightness: Double = 0.0
    var name: String
    let borderColor: Color
    let square: Bool
    
    init(name: String, borderColor: Color = Color(AppleColor.darkGray), square: Bool = false) {
        self.name = name
        self.borderColor = borderColor
        self.square = square
    }
    var image: AppleImage {
        if size.width < size.height * 1.1 &&
            AppleImage(named: name+"Sqr") != nil {
            return AppleImage(named: name+"Sqr")!
        } else {
            return AppleImage(named: name)!
        }
    }
    var reducedWidth: CGFloat {
        if square {
            return min(size.width, size.height)  - 2 * borderWidth
        } else {
            return size.width - 2 * borderWidth
        }
    }
    var reducedheight: CGFloat {
        if square {
            return min(size.width, size.height)  - 2 * borderWidth
        } else {
            return size.height - 2 * borderWidth
        }
    }
    var borderWidth: CGFloat {
        ceil(min(size.width, size.height) * 0.04)
    }
    var padding: CGFloat {
        0.5 * borderWidth
    }
}
