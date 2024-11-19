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
    var _name: String
    let borderColor: Color
    let isCircle: Bool
    
    init(name: String, borderColor: Color, isCircle: Bool) {
        self._name = name
        self.borderColor = borderColor
        self.isCircle = isCircle
    }
    
    var name: String {
        if size.width < size.height * 1.1 {
            if AppleImage(named: _name+"Sqr") != nil {
                return _name+"Sqr"
            }
        }
        if AppleImage(named: _name) != nil {
            return _name
        }
        return "English"
    }
    
//    var image: Image {
//#if TRANSLATE_MAC
//        Image(nsImage: AppleImage(named: name)!)
//#else
//        Image(uiImage: AppleImage(named: name)!)
//#endif
//    }
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
