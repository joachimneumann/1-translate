////
////  KeyView.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 03.11.2024.
////
//
//import SwiftUI
//
//struct KeyView: View {
//    var key: KeyModel
//    
//    var body: some View {
//        GeometryReader { geometry in
//            if geometry.notZero {
//                if let flagKey = key as? FlagKey {
//                    flagKey.view()
//                } else {
//                    key.view()
//                        .simultaneousGesture(
//                            DragGesture(minimumDistance: 0)
//                                .onChanged { value in
//                                    key.down(value.location, in: geometry.size)
//                                }
//                                .onEnded { value in
//                                    key.up()
//                                })
//                        .simultaneousGesture(
//                            LongPressGesture(minimumDuration: 0.5)
//                                .onEnded { value in
//                                    key.longPress()
//                                }
//                        )
//                }
//            }
//        }
//    }
//}
//
//import SwiftGmp
//#Preview {
//    let key1 = SymbolKey(InplaceOperation.sqr)
//    let key2 = FlagKey(persistent: TranslatePersistent(), languageEnum: .english)
//    let key3 = SymbolKey(DigitOperation.one)
//    ZStack {
//        Rectangle()
//            .foregroundColor(.gray)
//        HStack(spacing: 10) {
//            KeyView(key: key1)
//            KeyView(key: key2)
//            KeyView(key: key3)
//        }
//        .frame(width: 320, height: 100)
//    }
//}
