//
//  CalculatorKeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct CalculatorKeyView: View {
    @State private var bgColorNonPending: Color
    @State private var bgColorPending: Color
    @State private var isPressed: Bool = false
    @State private var imageBrightness: Double = 0.0
    @State private var downTimer: Timer? = nil
    
    private let key: Key
    private let toleranceRect: CGRect
    
    init(key: Key) {
        self.key = key
        bgColorNonPending = key.sixColors.upColor
        bgColorPending = key.sixColors.pendingUpColor
        
        let tolerance: CGFloat = 0.3 * key.height
        toleranceRect = CGRect(
            x: -tolerance,
            y: -tolerance,
            width: key.width + 2.0 * tolerance,
            height: key.height + 2.0 * tolerance)
    }
    
    var body: some View {
        let _ = print("CalculatorKeyView op = \(key.op.getRawValue()) \(key.imageName ?? "?")")
//        if let imagename = key.imageName, let borderColor = key.borderColor {
//            CalculatorKeyContent(width: key.width, height: key.height, imageName: imagename, borderColor: borderColor)
//        } else if let imagename = key.imageName, let borderColor = key.borderColor {
//        SymbolKeyView(symbolKey: SymbolKey(width: key.width, height: key.height, symbol: key.op.getRawValue(), txtColor: key.sixColors.textColor, upColor: key.sixColors.upColor, downColor: .red))
//            .onLongPressGesture(minimumDuration: 0.5) {
//                if key.op.isEqual(to: ClearOperation.back) {
//                    key.callback(Key(ClearOperation.clear))
//                } else {
//                    /// do nothing additionally on long press
//                }
//            }
//        onPressingChanged: { inProgress in
//            if inProgress {
//                self.down()
//            } else {
//                if isPressed {
//                    key.callback(key)
//                }
//                self.up()
//            }
//        }
//        .simultaneousGesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    if isPressed {
//                        /// If the finger moves too far away from the key
//                        /// handle that like a finger up event
//                        if !toleranceRect.contains(value.location) {
//                            up()
//                        }
//                    }
//                }
//        )
    }
    
    private func down() {
        isPressed = true
        withAnimation(.linear(duration: key.downTime)) {
            imageBrightness = 0.3
            bgColorNonPending = key.sixColors.downColor
            bgColorPending = key.sixColors.pendingDownColor
        }
        if let existingTimer = downTimer, existingTimer.isValid {
            existingTimer.invalidate()
        }
        downTimer = Timer.scheduledTimer(withTimeInterval: key.downTime, repeats: false) { _ in
            downTimerFired()
        }
    }
    
    private func up() {
        if !isPressed {
            /// This can happen when up() is triggered by the finger moving
            /// away from the key and then the finger us released.
            return
        }
        isPressed = false
        if downTimer != nil { return }
        withAnimation(.linear(duration: key.upTime)) {
            imageBrightness = 0.0
            bgColorNonPending = key.sixColors.upColor
            bgColorPending = key.sixColors.pendingUpColor
        }
    }
    
    private func downTimerFired() {
        downTimer = nil
        if !isPressed {
            withAnimation(.linear(duration: key.upTime)) {
                imageBrightness = 0.0
                bgColorNonPending = key.sixColors.upColor
                bgColorPending = key.sixColors.pendingUpColor
            }
        }
    }
}

import SwiftGmp

#Preview {
    @Previewable @State var x: Bool = false
    let key = Key(TwoOperantOperation.mul)
//    let key = Key(ConfigOperation.bottomLeft)
//    let _ = key.imageName = "English"
//    let _ = key.borderColor = .yellow
    ZStack {
        Rectangle()
            .foregroundColor(.black)
        CalculatorKeyView(key: key)
    }
}
