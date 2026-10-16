//
//  NumberDisplay.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import SwiftGmp

struct NumberDisplay: View {
    @ObservedObject var display: Display

    var body: some View {
        ZStack {
            NumberDisplayBackground()
            GeometryReader { geometry in
                let line = Display.Line(mantissa: display.left, exponent: display.right)
                HStack(alignment: .bottom, spacing: 0) {
                    Text(display.left)
                        .foregroundColor(display.isError ? .orange : Color.Neumorphic.text)
                        .font(display.font)
                    if let exponent = display.right {
                        Text(exponent)
                            .font(display.font)
                            .foregroundColor(Color.Neumorphic.text)
                            .padding(.leading, display.exponentSpacing)
                            .accessibilityLabel("times ten to the power of \(display.exponentPower(exponent))")
                    }
                }
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .scaleEffect(display.scaleFactor(for: geometry.size.width, line: line), anchor: .trailing)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .trailing)
            }
            .padding(.horizontal, display.textPadding)
        }
        .clipped()
    }
}

/// Full precision is a separate display; expanding never changes the compact one.
struct ExpandedNumberDisplay: View {
    @ObservedObject var display: Display

    private var decimalFill: Color {
#if CALCULATOR_IOS
        CalculatorPalette.operators.fill.color
#else
        Color.green.opacity(0.18)
#endif
    }

    private var decimalInk: Color {
#if CALCULATOR_IOS
        CalculatorPalette.operators.symbol.color
#else
        Color.Neumorphic.text
#endif
    }

    private func lineView(_ line: Display.Line) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            if display.highlightsDecimal, let decimal = line.mantissa.firstIndex(of: display.separatorCharacter) {
                Text(String(line.mantissa[..<decimal]))
                Text(String(display.separatorCharacter))
                    .font(display.decimalHighlightFont)
                    .foregroundColor(decimalInk)
                    .padding(.horizontal, display.decimalHighlightPadding)
                    .padding(.vertical, 1)
                    .background(decimalFill, in: RoundedRectangle(cornerRadius: 4))
                Text(String(line.mantissa[line.mantissa.index(after: decimal)...]))
            } else {
                Text(line.mantissa)
            }
        }
        .font(display.font)
        .foregroundColor(display.isError ? .orange : Color.Neumorphic.text)
        .lineLimit(1)
        .fixedSize(horizontal: true, vertical: false)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(line.mantissa)
    }

    func digitContent(width: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(display.expandedLines(for: width).enumerated()), id: \.offset) { _, line in
                lineView(line)
                    .frame(height: display.highlightsDecimal ? display.expandedLineHeight : display.lineHeight)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, display.textPadding)
    }

    var body: some View {
        ZStack {
            NumberDisplayBackground()
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    if let exponent = display.right {
                        NumberExponent(display: display, exponent: exponent)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, display.textPadding)
                        Rectangle()
                            .fill(Color.Neumorphic.text.opacity(0.15))
                            .frame(height: 1)
                    }
                    ScrollView(.vertical) {
                        digitContent(width: geometry.size.width)
                    }
                }
            }
            .padding(.horizontal, display.textPadding)
        }
        .clipped()
    }
}

private struct NumberDisplayBackground: View {
    var body: some View {
        let shape = RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
        shape
            .foregroundColor(Color.Neumorphic.main)
            .softInnerShadow(shape, size: CGSize(width: 20, height: 20), radius: 3)
    }
}

private struct NumberExponent: View {
    let display: Display
    let exponent: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text("× 10")
                .font(display.font)
            Text(display.exponentPower(exponent))
                .font(display.exponentFont)
                .baselineOffset(display.exponentBaselineOffset)
        }
        .foregroundColor(Color.Neumorphic.text)
        .lineLimit(1)
        .fixedSize(horizontal: true, vertical: false)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("times ten to the power of \(display.exponentPower(exponent))")
    }
}

var numberDisplayPreview: some View {
    let display = Display(floatDisplayWidth: 100, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
    let _ = display.left = "3.14"
    return ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack(spacing: 0.0) {
            Spacer()
            NumberDisplay(display: display)
                .padding(.horizontal, 14)
            Spacer()
        }
    }
}

#Preview("Dark") {
    numberDisplayPreview
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    numberDisplayPreview
        .preferredColorScheme(.light)
}
