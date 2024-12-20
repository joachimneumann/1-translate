//
//  KeyModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import SwiftGmp


@Observable class KeyModel: KeyAnimation {
    private var flagImage: Image? = nil
    var symbolKey: SymbolKeyModel? = nil
    var width: CGFloat = 0
    var height: CGFloat = 0

    init(flagName: String) {
        flagImage = Image(flagName)
        super.init()
    }
    
    init(op: any OpProtocol) {
        self.symbolKey = SymbolKeyModel(op: op)
        super.init()
        if op.isEqual(to: ControlOperation.second) {
            //isSecond = true
        }
    }
    
    func setSize(_ size: CGSize) {
        self.width = size.width
        self.height = size.height
        if let m = symbolKey {
            m.newSize(CGSize(width: width, height: height))
        }
    }
        
    var flagScale: CGFloat {
        switch visualState {
        case .up: 1.0
        case .center: 0.997
        case .down: 0.989
        }
    }
    
    var symbolScale: CGFloat {
        switch visualState {
        case .up: 1.0
        case .center: 0.995
        case .down: 0.98
        }
    }

    var flagBrightness: CGFloat {
        switch visualState {
        case .up: 0.0
        case .center: -0.02
        case .down: -0.06
        }
    }
    
    var symbolBrightness: CGFloat {
        switch visualState {
        case .up: 0.0
        case .center: -0.04
        case .down: -0.2
        }
    }

    var view: some View {
        if let flag = flag {
            return flag
        } else if let symbol = symbol {
            return symbol
        } else {
            return AnyView(EmptyView())
        }
    }
    
    var symbol: AnyView? {
        if let symbolKeyViewModel = symbolKey {
            return AnyView(
                symbolKeyViewModel.label
                    .scaleEffect(symbolScale)
                    .brightness(symbolBrightness)
            )
        }
        return nil
    }
    
    var flag: AnyView? {
        if let flag = flagImage {
            let borderWidth: CGFloat = min(width, height) * 0.1//25
            return AnyView(
                flag
                    .resizable()
                    .scaledToFill()
                    .brightness(flagBrightness)
                    .clipShape(Circle())
                    .frame(width: width - 2 * borderWidth, height: height - 2 * borderWidth)
                    .scaleEffect(flagScale)
            )
        }
        return nil
    }
}

struct Demo: View {
//    let flagName: String
    let m1: KeyModel
    let m2: KeyModel
    init() {
//        let translationManager = TranslationManager()
//        if AppleImage(named: translationManager.flagName(.english) + "Sqr") != nil {
//            flagName = translationManager.flagName(.english) + "Sqr"
//        } else {
//            flagName = translationManager.flagName(.english)
//        }
//        m1 = KeyModel(flagName: flagName)
        m2 = KeyModel(op: InplaceOperation.sqr)
        m1 = KeyModel(op: InplaceOperation.sqrt)
        m2.setSize(CGSize(width: 150, height: 80))
        m1.setSize(CGSize(width: 150, height: 80))
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
            VStack {
                HStack {
                    Spacer()
                    KeyView(key: m1)
                    Spacer()
                    KeyView(key: m2)
                    Spacer()
                }
                //.background(Color.yellow)
            }
            .background(Color.Neumorphic.main)
        }
//        .frame(width: 300)
    }
}

#Preview("Dark") {
    Demo()
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo()
        .preferredColorScheme(.light)
}
