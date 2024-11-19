//
//  ImageKeyViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI
@Observable class ImageKeyViewModel: ObservableObject {
    
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
    
    var image: Image {
#if TRANSLATE_MAC
        if size.width < size.height * 1.1 &&
            AppleImage(named: name+"Sqr") != nil {
            return Image(nsImage: AppleImage(named: name+"Sqr")!)
        } else {
            return Image(nsImage: AppleImage(named: name)!)
        }
#else
        if size.width < size.height * 1.1 &&
            AppleImage(named: name+"Sqr") != nil {
            return Image(uiImage: AppleImage(named: name+"Sqr")!)
        } else {
            return Image(uiImage: AppleImage(named: name)!)
        }
#endif
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
