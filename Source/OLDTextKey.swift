////
////  TextKey.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 02.11.2024.
////
//
//import SwiftUI
//
//@Observable class TextKey: KeyAnimation {
//    var top: String
//    var bottom: String?
//    
//    init(top: String, bottom: String?) {
//        self.top = top
//        self.bottom = bottom
//        super.init()
//    }
//    
//    override func view() -> AnyView {
//        return AnyView(VStack(alignment: .leading, spacing: 0.0) {
//            Spacer(minLength: 0.0)
//            let text = top + ((bottom != nil) ? "\n\(bottom!)" : "")
//            Text(text)
//                .font(.title3)
//                .minimumScaleFactor(0.5)
//                .lineSpacing(1.5) // Set line spacing
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 5)
//            Spacer(minLength: 0.0)
//        })
//    }
//}
//
//
//#Preview {
//    @Previewable @State var x: TextKey = TextKey(top: "EnglishEnglishEnglish", bottom: "(truely)")
//    ZStack {
//        Rectangle()
//            .foregroundColor(.gray)
//        x.view()
//            .background(.yellow)
//    }
//    .frame(width: 400, height: 200)
//}
