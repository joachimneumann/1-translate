//
//  Vietnamese.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct VietnameseDisplay: View {
    let display: Display
    let screen: Screen
    let backgroundColor: Color
    private let font: Font
    private let vietnamese: Vietnamese
    private let toShow: String
    
    init(display: Display, screen: Screen, backgroundColor: Color) {
        self.display = display
        self.screen = screen
        self.backgroundColor = backgroundColor
        vietnamese = Vietnamese(linh_instread_of_lẻ: false, ngàn_instead_of_nghìn: false, compact: true)
        let uiFont = Screen.appleFont(ofSize: screen.uiFontSize * 0.5)
        font = Font(uiFont)
        if display.right != nil {
            toShow = "can't translate"
        } else {
            toShow = vietnamese.toString(display.left) ?? "can't translate"
        }
    }
    
    
    var body: some View {
        //let _ = print(display.data.left)
        VStack(spacing: 0.0) {
            HStack(alignment: .bottom, spacing: 0.0) {
                Text(toShow)
                    .multilineTextAlignment(.leading)
                    .font(font)
                Spacer(minLength: 0.0)
            }
            Spacer(minLength: 0.0)
        }
    }
}
