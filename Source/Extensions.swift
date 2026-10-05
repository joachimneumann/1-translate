//
//  Extensions.swift
//  bg
//
//  Created by Joachim Neumann on 11/27/22.
//

import SwiftUI
import Neumorphic

#if CALCULATOR_MAC || TRANSLATE_MAC
public typealias AppleFont = NSFont
public typealias AppleColor = NSColor
public typealias AppleImage = NSImage
#else
public typealias AppleFont = UIFont
public typealias AppleColor = UIColor
public typealias AppleImage = UIImage
#endif

extension Color.Neumorphic {
    static var pendingOperation: Color {
        NeumorphicKit.color(
            light: NeumorphicKit.colorType(red: 0.0, green: 151.0 / 255.0, blue: 167.0 / 255.0), // #0097A7
            dark: NeumorphicKit.colorType(red: 115.0 / 255.0, green: 200.0 / 255.0, blue: 212.0 / 255.0) // #73C8D4
        )
    }
}

extension String {
    func textWidth(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        let notCeil = self.size(withAttributes: attributes).width
        return ceil(notCeil)
    }
}
