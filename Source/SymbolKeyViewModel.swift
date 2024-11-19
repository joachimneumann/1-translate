//
//  SymbolKeyViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class SymbolKeyViewModel: ObservableObject, VisualUpDownDelegate {
    
    private var size: CGFloat
    private let op: any OpProtocol
    private let symbol: String
    private let color: Color

    init(op: any OpProtocol, size: CGFloat, color: Color) {
        self.op = op
        self.symbol = op.getRawValue()
        self.color = color
#if os(macOS)
        let sizeFactorDigits          = 1.5
        let sizeFactorAC              = 1.4
        let sizeFactorBack            = 1.5
        let sizeFactorSpecialOperator = 1.12
        let sizeFactorOperator        = 1.04
        let sizeFactorOperatorX       = sizeFactorOperator * 0.86
        let sizeFactorComma           = 1.8
        let sizeFactorScientific      = 1.2
#else
        let sizeFactorDigits          = 1.4
        let sizeFactorAC              = sizeFactorDigits
        let sizeFactorBack            = 1.5
        let sizeFactorSpecialOperator = 1.1
        let sizeFactorOperator        = 1.1
        let sizeFactorOperatorX       = 0.95
        let sizeFactorComma           = 1.5
        let sizeFactorScientific      = 1.0
#endif
        
        var sizeFactor: CGFloat
        switch symbol {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            sizeFactor = sizeFactorDigits
        case "AC":
            sizeFactor = sizeFactorAC
        case "back":
            sizeFactor = sizeFactorBack
        case "±", "%":
            sizeFactor = sizeFactorSpecialOperator
        case "*":
            sizeFactor = sizeFactorOperatorX
        case "settings":
            sizeFactor = 2.0
        case _ where sfImageForKey.keys.contains(symbol):
            sizeFactor = sizeFactorOperator
        case ",", ".":
            sizeFactor = sizeFactorComma
        case "One_x":
            sizeFactor = 0.9
        default:
            sizeFactor = sizeFactorScientific
        }
        self.size = size * sizeFactor
    }
    
    func visualUp() {
    }
    
    func visualDown() {
    }
    
    private let sfImageForKey: [String: String] = [
        "+": "plus",
        "-": "minus",
        "*": "multiply",
        "/": "divide",
        "±": "plus.slash.minus",
        "=": "equal",
        "%": "percent",
        "back": "delete.backward",
        "settings": "gear"
    ]
    
    var label: some View {
        switch symbol {
        case "sqrt" : AnyView(rootShapeView(rootDigit: "2"))
        case "sqrt3": AnyView(rootShapeView(rootDigit: "3"))
        case "y√":    AnyView(rootShapeView(rootDigit: "y"))
        case "log10": AnyView(logx(base: "10"))
        case "log2":  AnyView(logx(base: "2"))
        case "logy":  AnyView(logx(base: "y"))
        case "One_x": AnyView(one_x)
        case "sqr":   AnyView(pow(base:  "x",   exponent: "2"))
        case "x^3":   AnyView(pow(base:  "x",   exponent: "3"))
        case "x^y":   AnyView(pow(base:  "x",   exponent: "y"))
        case "e^x":   AnyView(pow(base:  "e",   exponent: "x"))
        case "y^x":   AnyView(pow(base:  "y",   exponent: "x"))
        case "2^x":   AnyView(pow(base:  "2",   exponent: "x"))
        case "10^x":  AnyView(pow(base: "10",   exponent: "x"))
        case "2nd":   AnyView(pow(base: "2",    exponent: "nd"))
        case "asin":  AnyView(pow(base: "sin",  exponent: "-1"))
        case "acos":  AnyView(pow(base: "cos",  exponent: "-1"))
        case "atan":  AnyView(pow(base: "tan",  exponent: "-1"))
        case "asinh": AnyView(pow(base: "sinh", exponent: "-1"))
        case "acosh": AnyView(pow(base: "cosh", exponent: "-1"))
        case "atanh": AnyView(pow(base: "tanh", exponent: "-1"))
        default:
            AnyView(textLabel)
        }
    }
    
    private var textLabel: some View {
        if let sfImage = sfImageForKey[symbol] {
            return AnyView(Image(systemName: sfImage)
                .resizable()
                .foregroundColor(color)
                //.font(Font.title.weight(.regular))
                .aspectRatio(contentMode: .fit)
                .frame(width: size * 0.3, height: size * 0.3))
                //.background(.green)
        } else {
            return AnyView(Text(symbol)
                .font(.system(size: size * 0.3))
                .foregroundColor(color))
        }
    }
    
    
    private func slashShape(slashSize: CGFloat) -> some View {
        let lineWidth = slashSize * 0.17
        return Path { path in
            ///print("SlashShape \(height)")
            let steepness: CGFloat = 1.3
            let startX: CGFloat = 0.5 * slashSize - 0.5 * slashSize
            let startY: CGFloat = 0.5 * slashSize + 0.5 * slashSize * steepness
            let upX: CGFloat = startX + slashSize
            let upY: CGFloat = startY - slashSize * steepness
            
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: upX,   y: upY))
        }
        .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: CGLineCap.round))
        .aspectRatio(contentMode: .fit)
    }
    
    private var one_x: some View {
        let slashSize = size * 0.16
        let fontSize = slashSize * 1.5
        return slashShape(slashSize: slashSize)
            .frame(width: slashSize, height: slashSize)
            .overlay() {
                Text("1")
                    .font(.system(size: fontSize))
                    .offset(x: -0.7 * slashSize, y: -0.4 * slashSize)
            }
            .overlay() {
                Text("x")
                    .font(.system(size: fontSize))
                    .offset(x: 0.6 * slashSize, y: 0.3 * slashSize)
            }
    }

    
    private func pow(base: String, exponent: String) -> some View {
        ZStack {
            VStack(spacing:0.0) {
                Spacer(minLength: 0.0)
                HStack(spacing: 0.0) {
                    Spacer(minLength: 0.0)
                    Text(base)
                        .font(.system(size: size * 0.3))
                    Text(exponent)
                        .font(.system(size: size * 0.18))
                        .offset(x: 0.0, y: -0.08 * size)
                    Spacer(minLength: 0.0)
                }
                Spacer(minLength: 0.0)
            }
        }
    }
    
    
    private func logx(base: String) -> some View {
        ZStack {
            VStack(spacing:0.0) {
                Spacer(minLength: 0.0)
                HStack(spacing:0.0) {
                    Spacer(minLength: 0.0)
                    Text("log")
                        .font(.system(size: size * 0.3))
                    Text(base)
                        .font(.system(size: size * 0.18))
                        .offset(x: 0.0, y: 0.13 * size)
                    Spacer(minLength: 0.0)
                }
                Spacer(minLength: 0.0)
            }
        }
    }
    
    private func root(rootSize: CGFloat) -> some View {
        let lineWidth = rootSize * 0.03
        return Path { path in
            // print("Root")
            let steepness: CGFloat = 2.8
            let f: CGFloat = 0.6
            let startX: CGFloat = 0.5 * rootSize - 0.17 * rootSize
            let startY: CGFloat = 0.5 * rootSize + 0.07 * rootSize
            let downX: CGFloat = startX + f * 0.08 * rootSize
            let downY: CGFloat = startY + f * 0.08 * rootSize * steepness
            let upX: CGFloat = downX + f * 0.2 * rootSize
            let upY: CGFloat = downY - f * 0.2 * rootSize * steepness
            let endX: CGFloat = upX + f * 0.35 * rootSize
            let endY: CGFloat = upY
            
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: downX, y: downY))
            path.addLine(to: CGPoint(x: upX,   y: upY))
            path.addLine(to: CGPoint(x: endX,  y: endY))
        }
        .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round))
        .aspectRatio(contentMode: .fit)
    }
    
    private func rootShapeView(rootDigit: String, underTheRoot: String = "x") -> some View {
        let rootSize = size * 0.8
        let fontSize = rootSize * 0.2
        let xFontSize = rootSize * 0.3
        return root(rootSize: rootSize)
            .frame(width: rootSize, height: rootSize)
        .overlay() {
            Text(rootDigit)
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundColor(color)
                .padding(.leading, rootSize * -0.23)
                .padding(.top, rootSize * -0.14)
        }
        .overlay() {
            Text(underTheRoot)
                .font(.system(size: xFontSize, weight: .semibold))
                .foregroundColor(color)
                .padding(.leading, rootSize * 0.2)
                .padding(.top, rootSize * 0.1)
        }
    }
}
 
