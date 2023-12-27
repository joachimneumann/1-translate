//
//  ScrollViewConditionalAnimation.swift
//  Calculator
//
//  Created by Joachim Neumann on 12/20/22.
//

import SwiftUI

struct ScrollViewConditionalAnimation: View {
    let display: Display
    let screen: Screen
    let foregroundColor: Color
    let backgroundColor: Color
    let offsetY: CGFloat
    let disabledScrolling: Bool
    @Binding var scrollViewHasScolled: Bool
    var scrollViewID: UUID
    
    private struct OffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    private var scrollView: some View {
        GeometryReader { g in
            HStack(alignment: .top, spacing: 0.0) {
                ScrollView(.vertical) {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        let toShow = display.left
                        Spacer(minLength: 0.0)
                        Text(toShow)
                            .kerning(screen.kerning)
                            .font(Font(screen.appleFont))
                            .foregroundColor(foregroundColor)
                            .multilineTextAlignment(.trailing)
                            .background(backgroundColor)
                            .lineLimit(nil)
                            .offset(y: offsetY)
                            .anchorPreference(key: OffsetKey.self, value: .top) {
                                g[$0].y
                            }
                            .accessibilityIdentifier("landscapeDisplayText")
                        //.animation(Animation.easeInOut(duration: 0.2), value: foregroundColor)
                    }
                }
                .id(scrollViewID)
                .disabled(disabledScrolling)
            }
        }
    }
    
    var body: some View {
        scrollView
            .onPreferenceChange(OffsetKey.self) { verticalScrollPosition in
                //print("verticalScrollPosition \(verticalScrollPosition)")
                if abs(verticalScrollPosition) > 0.01 {
                    scrollViewHasScolled = true
                } else {
                    scrollViewHasScolled = false
                }
            }
    }
}
