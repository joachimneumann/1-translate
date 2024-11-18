//
//  ImageKeyViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI
@Observable class ImageKeyViewModel: ObservableObject, VisualUpDownDelegate {
    
    var size: CGSize = CGSize.zero
    var brightness: Double = 0.0
    var name: String
    let borderColor: Color
    let isCircle: Bool
    
    init(name: String, borderColor: Color, isCircle: Bool) {
        self.name = name
        self.borderColor = borderColor
        self.isCircle = isCircle
    }
    
    func visualUp() {
        brightness = 0.0
    }
    
    func visualDown() {
        brightness = 0.3

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
        if isCircle {
            return min(size.width, size.height)  - 2 * borderWidth
        } else {
            return size.width - 2 * borderWidth
        }
    }
    var reducedheight: CGFloat {
        if isCircle {
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
