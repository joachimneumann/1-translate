////
////  Key.swift
////  bg
////
////  Created by Joachim Neumann on 11/27/22.
////
//
//import SwiftUI
//import SwiftGmp
//
//struct Key: View {
//    let screen: Screen
//    let symbol: String
//    let xOffset: CGFloat
//    let backgroundColor: Color
//    let textColor: Color
//    let touchDown: (Key) -> ()
//    let touchUp: (Key) -> ()
//    let op: any OpProtocol
//    
//    init(_ screen: Screen,
//         _ viewModel: ViewModel,
//         _ op: any OpProtocol) {
//        self.screen = screen
//        self.symbol = op.getRawValue()
//        xOffset = 0.0
//        self.backgroundColor = .green
//        self.textColor = .purple
//        self.touchDown = { _ in }
//        self.touchUp   = { _ in }
//        self.op = op
//    }
//    
//    var body: some View {
//        // let _ = print("KeyID_"+symbol.replacing("^", with: ""))
//        // let _ = print("Key "+symbol)
//        Label(symbol: symbol, size: screen.keySize.height, color: textColor)
//            .offset(x: xOffset)
//            .foregroundColor(textColor)
//            .frame(width: screen.keySize.width, height: screen.keySize.height)
//            .background(backgroundColor)
//#if os(macOS)
//            .clipShape(Rectangle())
//#else
//            .clipShape(Capsule())
//#endif
//            .simultaneousGesture(DragGesture(minimumDistance: 0)
//                .onChanged { _ in
//                    touchDown(self)
//                }
//                .onEnded { _ in
//                    touchUp(self)
//                })
//    }
//}
//
//struct Key_Previews: PreviewProvider {
//    static var previews: some View {
//        let screen = Screen(CGSize(width: 500, height: 600))
//        let viewModel = ViewModel()
//        VStack {
//            HStack {
//                Key(screen, viewModel, InplaceOperation.sqrt)
//                Key(screen, viewModel, ConstantOperation.pi)
//            }
//            Key(screen, viewModel, ConstantOperation.pi)
//        }
//        .background(.gray)
//    }
//}
