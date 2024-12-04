//
//  SoftInnerShadowModifier.swift
//  Created by Costa Chung on 18/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI
//

import SwiftUI

private struct SoftInnerShadowViewModifier<S: Shape> : ViewModifier {
    var shape: S
    let size: CGSize
    var darkShadowColor : Color = .black
    var lightShadowColor : Color = .white
    var spread: CGFloat    //The value of spread is between 0 to 1. Higher value makes the shadow look more intense.
    var radius: CGFloat
    
    init(shape: S, size: CGSize, darkShadowColor: Color, lightShadowColor: Color, spread: CGFloat, radius:CGFloat) {
        self.shape = shape
        self.size = size
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.spread = spread
        self.radius = radius
    }

    fileprivate func strokeLineWidth(_ size: CGSize) -> CGFloat {
        return size.width * 0.10
    }
    
    fileprivate func strokeLineScale(_ size: CGSize) -> CGFloat {
        let lineWidth = strokeLineWidth(size)
        return size.width / CGFloat(size.width - lineWidth)
    }
    
    fileprivate func shadowOffset(_ size: CGSize) -> CGFloat {
        return (size.width <= size.height ? size.width : size.height) * 0.5 * min(max(spread, 0), 1)
    }
    

    fileprivate func addSoftInnerShadow(size: CGSize, _ content: SoftInnerShadowViewModifier.Content) -> some View {
    #if os(macOS)
        //The mask on macOS doesn't work properly with shadow. The shadow disappear after calling the mask modifier.
        //Workaround: Use blur instead of shadow.
        self.shape.fill(self.lightShadowColor)
            .inverseMask(
                self.shape
                    .offset(x: -self.shadowOffset(size), y: -self.shadowOffset(size))
            )
            .blur(radius: self.radius)
            .mask(
                self.shape
            )
            .overlay(
                self.shape
                    .fill(self.darkShadowColor)
                    .inverseMask(
                        self.shape
                            .offset(x: self.shadowOffset(size), y: self.shadowOffset(size))
                    )
                    .blur(radius: self.radius)
            )
            .mask(
                self.shape
            )
    #else
        // iOS
        //let _ = print("soft inner shadow geo.size = \(geo.size)")
        self.shape.fill(self.lightShadowColor)
            .inverseMask(
                self.shape
                    .offset(x: -self.shadowOffset(size), y: -self.shadowOffset(size))
            )
            .offset(x: self.shadowOffset(size) , y: self.shadowOffset(size))
            .blur(radius: self.radius)
            .shadow(color: self.lightShadowColor, radius: self.radius, x: -self.shadowOffset(size)/2, y: -self.shadowOffset(size)/2 )
            .mask(
                self.shape
            )
            .overlay(
                self.shape
                    .fill(self.darkShadowColor)
                    .inverseMask(
                        self.shape
                            .offset(x: self.shadowOffset(size), y: self.shadowOffset(size))
                    )
                    .offset(x: -self.shadowOffset(size) , y: -self.shadowOffset(size))
                    .blur(radius: self.radius)
                    .shadow(color: self.darkShadowColor, radius: self.radius, x: self.shadowOffset(size)/2, y: self.shadowOffset(size)/2 )
            )
            .mask(
                self.shape
            )
        #endif
    }

    func body(content: Content) -> some View {
        content.overlay(
            addSoftInnerShadow(size: size, content)
        )
    }
}


//For more readable, we extend the View and create a softInnerShadow function.
extension View {

    public func softInnerShadow<S : Shape>(_ content: S, size: CGSize, darkShadow: Color = Color.Neumorphic.darkShadow, lightShadow: Color = Color.Neumorphic.lightShadow, spread: CGFloat = 0.5, radius: CGFloat) -> some View {
        modifier(
            SoftInnerShadowViewModifier(shape: content, size: size, darkShadowColor: darkShadow, lightShadowColor: lightShadow, spread: spread, radius: radius)
        )
    }
    
}
