//
//  xx.swift
//  Calculator
//
//  Created by Joachim Neumann on 16.11.2024.
//

//
//  ScrollViewConditionalAnimation.swift
//  Calculator
//
//  Created by Joachim Neumann on 12/20/22.
//

import SwiftUI

struct ScrollViewConditionalAnimation: View {
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
                        let toShow = "dfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhdfjgd lfjgsdl kfjglsdkj fglskdj gsdkfjhg sldkfh gskdjfhg;ksdjhf gk;sdjhf gksdjhf g;ksdjhf gksdjh fgsdkjfhgdsfgkjh"
                        Spacer(minLength: 0.0)
                        Text(toShow)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                            .background(backgroundColor)
                            .lineLimit(nil)
                    }
                }
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

#Preview {
    ZStack {
        Rectangle()
            .foregroundColor(.yellow)
        ScrollViewConditionalAnimation(foregroundColor: .yellow, backgroundColor: .green, offsetY: 0, disabledScrolling: false, scrollViewHasScolled: .constant(false), scrollViewID: UUID())
            .frame(width: 300, height: 300)
    }
}
