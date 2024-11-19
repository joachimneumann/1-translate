//
//  ImageKeyViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI
@Observable class ImageKeyViewModel {
    
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
        var appleImage: AppleImage = AppleImage(named: "English")!
        let appleImageRect: AppleImage? = AppleImage(named: name)
        let appleImageSqr: AppleImage? = AppleImage(named: name+"Sqr")
        if let appleImageRect = appleImageRect {
            appleImage = appleImageRect
        }
        if size.width < size.height * 1.1 {
            if let appleImageSqr = appleImageSqr {
                appleImage = appleImageSqr
            }
        }
#if TRANSLATE_MAC
        return Image(nsImage: appleImage)
#else
        return Image(uiImage: appleImage)
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
