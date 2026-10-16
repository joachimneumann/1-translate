//
//  Extensions.swift
//  bg
//
//  Created by Joachim Neumann on 11/27/22.
//

import SwiftUI

#if CALCULATOR_MAC || TRANSLATE_MAC
public typealias AppleFont = NSFont
public typealias AppleColor = NSColor
public typealias AppleImage = NSImage
#else
public typealias AppleFont = UIFont
public typealias AppleColor = UIColor
public typealias AppleImage = UIImage
#endif

extension String {
    func textWidth(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        let notCeil = self.size(withAttributes: attributes).width
        return ceil(notCeil)
    }
}
