//
//  TextKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

@Observable class TextKey: Key {
    var top: String
    var bottom: String?
    
    init(top: String, bottom: String?) {
        self.top = top
        self.bottom = bottom
        super.init()
    }
    
    override func view() -> AnyView {
        return AnyView(
            VStack(alignment: .leading, spacing: 0.0) {
                Text(top)
                if let bottom = bottom {
                    Text(bottom)
                }
            }
            .frame(width: width, alignment: .leading)
            //.background(.orange)
        )
    }
}


#Preview {
    @Previewable @State var x: TextKey = TextKey(top: "EnglishEnglishEnglish", bottom: "(truely)")
    let _ = x.width = 300
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
            .background(.yellow)
    }
}
