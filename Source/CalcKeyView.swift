////
////  CalcKeyView.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 02.11.2024.
////
//
//import SwiftUI
//import SwiftGmp
//
//class CalcKey: BaseKey {
//    var op: any OpProtocol
//    
//    var isPressed: Bool = false
//    override var height: CGFloat {
//        didSet {
//            let tolerance: CGFloat = 0.3 * height
//            toleranceRect = CGRect(
//                x: -tolerance,
//                y: -tolerance,
//                width: width + 2.0 * tolerance,
//                height: height + 2.0 * tolerance)
//        }
//    }
//    var toleranceRect: CGRect = CGRectZero
//
//    var view: AnyView { AnyView(EmptyView()) }
//    var callback: (CalcKey) -> () = { _ in }
//
//    private var downTimer: Timer? = nil
//    private var downTime: Double = 0.15
//    private var upTime: Double = 0.4
//
//    init(op: any OpProtocol) {
//        self.op = op
//        super.init(symbol: "x^2", txtColor: .white, upColor: .red, downColor: .yellow)
//    }
//    
//    func down() {
//        isPressed = true
//        withAnimation(.linear(duration: downTime)) {
//            visualDown()
//        }
//        if let existingTimer = downTimer, existingTimer.isValid {
//            existingTimer.invalidate()
//        }
//        downTimer = Timer.scheduledTimer(withTimeInterval: downTime, repeats: false) { _ in
//            self.downTimerFired()
//        }
//    }
//    
//    func up() {
//        if !isPressed {
//            /// This can happen when up() is triggered by the finger moving
//            /// away from the key and then the finger us released.
//            return
//        }
//        isPressed = false
//        if downTimer != nil { return }
//        withAnimation(.linear(duration: upTime)) {
//            visualUp()
//        }
//    }
//    
//    private func downTimerFired() {
//        downTimer = nil
//        if !isPressed {
//            withAnimation(.linear(duration: upTime)) {
//                visualUp()
//            }
//        }
//    }
//}
//
//struct CalcKeyView: View {
//    var calcKey: CalcKey
//    var body: some View {
//        calcKey.view
//            .onLongPressGesture(minimumDuration: 0.5) {
//                //                            if key.op.isEqual(to: ClearOperation.back) {
//                //                                key.callback(Key(ClearOperation.clear))
//                //                            } else {
//                //                                /// do nothing additionally on long press
//                //                            }
//            }
//        onPressingChanged: { inProgress in
//            if inProgress {
//                calcKey.down()
//            } else {
//                if calcKey.isPressed {
//                    calcKey.callback(calcKey)
//                }
//                calcKey.up()
//            }
//        }
//        .simultaneousGesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    if calcKey.isPressed {
//                        /// If the finger moves too far away from the key
//                        /// handle that like a finger up event
//                        if !calcKey.toleranceRect.contains(value.location) {
//                            calcKey.up()
//                        }
//                    }
//                }
//        )
//    }
//}
//
//#Preview {
//    let x1 = CalcKey(op: InplaceOperation.sqr)
//    //SymbolKey = SymbolKey(symbol: "x^3", txtColor: .white, upColor: .red, downColor: .yellow)
////    let x2: ImageKey = ImageKey(imageName: "English", borderColor: .gray, borderwidth: 5.0)
//    ZStack {
//        Rectangle()
//            .foregroundColor(.gray)
//        VStack {
//            CalcKeyView(calcKey: x1)
////            CalcKeyView(calcKey: x2)
//        }
//    }
//}
