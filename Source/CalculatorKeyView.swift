//
//  CalculatorKeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct CalculatorKeyView: View {
    @EnvironmentObject var languageSelectorNavigation: LanguageSelectorNavigation
    
    @State private var bgColorNonPending: Color
    @State private var bgColorPending: Color
    @State private var isPressed: Bool = false
    @State private var imageBrightness: Double = 0.0
    @State private var downTimer: Timer? = nil
    
    let key: Key
    let borderwidth: CGFloat = 5
    
    init(key: Key) {
        self.key = key
        bgColorNonPending = key.sixColors.upColor
        bgColorPending = key.sixColors.pendingUpColor
        
        // print("CalculatorKeyView init \(key.op.getRawValue())")
        //
        // Use this print statement to check if any
        // other key than the pressed key is redrawn.
        // That is not what we want that, of course.
    }
    
    struct ImageKey: View {
        let imageName: String
        let width: CGFloat
        let height: CGFloat
        let brightness: Double
        var body: some View {
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .brightness(brightness)
                .clipShape(Capsule())
        }
    }
    struct ImageOrLabel: View {
        let key: Key
        let borderwidth: CGFloat
        let imageBrightness: Double
        let bgColor: Color
        
        var body: some View {
            if let imageName = key.imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: key.keySize.width-2*borderwidth, height: key.keySize.height-2*borderwidth)
                    .clipShape(Capsule())
                    .padding(0.5*borderwidth)
                    .overlay(
                        key.borderColor.map { Capsule().stroke($0, lineWidth: borderwidth) }
                    )
                    .brightness(imageBrightness)
                    .padding(0.5*borderwidth)
            } else {
                Label(symbol: key.op.getRawValue(), size: key.keySize.height, color: key.isPending ? key.sixColors.pendingTextColor : key.sixColors.textColor)
                    .padding()
                    .frame(width: key.keySize.width, height: key.keySize.height)
                    .background(bgColor)
                    .clipShape(Capsule())
            }
        }
    }
    
    var body: some View {
        ImageOrLabel(key: key, borderwidth: borderwidth, imageBrightness: imageBrightness, bgColor: key.isPending ? bgColorPending : bgColorNonPending)
            .onLongPressGesture(minimumDuration: 0.5) {
                if key.op.isEqual(to: ClearOperation.back) {
                    key.callback(Key(ClearOperation.clear))
                } else {
                    // do nothing additionally on long press
                }
            }
        onPressingChanged: { inProgress in
            if inProgress {
                self.down()
            } else {
                if isPressed {
                    if key.op.isEqual(to: ConfigOperation.config) {
                        languageSelectorNavigation.showLanguageSelector.toggle()
                    }
                    key.callback(key)
                }
                self.up()
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if isPressed {
                        let tolerance: CGFloat = 0.3 * key.keySize.height
                        let rect = CGRect(
                            x: -tolerance,
                            y: -tolerance,
                            width: key.keySize.width + 2.0 * tolerance,
                            height: key.keySize.height + 2.0 * tolerance)
                        if !rect.contains(value.location) {
                            up()
                        }
                    }
                }
        )
    }
    
    private func distanceBetween(_ point1: CGPoint, and point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx * dx + dy * dy)
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
            //print("Existing downTimer invalidated")
        }
        downTimer = Timer.scheduledTimer(withTimeInterval: key.downTime, repeats: false) { _ in
            downTimerFired()
        }
    }
    
    private func up() {
        if !isPressed {
            // this can happen when up() is triggered by the finger moving
            // away from the key and then the finger us released.
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
    //    let key = Key(InplaceOperation.sqrt3)
    let key = Key(ConfigOperation.config)
    let _ = key.imageName = "English"
    let _ = key.keySize = CGSize(width: 100, height: 100)
    ZStack {
        Rectangle()
            .foregroundColor(.black)
        CalculatorKeyView(key: key)
    }
}
