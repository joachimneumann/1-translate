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
    var isExpanded: Bool = false
    var compactHeight: CGFloat? = nil
    @Namespace private var exponentAnimation

    @ViewBuilder
    func TextView(_ text: String) -> some View {
        Text(text)
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
    }

    private func lineView(_ line: Display.Line) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            TextView(line.mantissa)
                .foregroundColor(display.isError ? .orange : Color.Neumorphic.text)
                .font(display.font)
            if let exponent = line.exponent {
                exponentView(exponent)
                    .matchedGeometryEffect(id: "exponent", in: exponentAnimation)
                    .padding(.leading, display.ePadding)
            }
        }
    }

    private func exponentView(_ exponent: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            TextView("× 10")
                .font(display.font)
            TextView(display.exponentPower(exponent))
                .font(display.exponentFont)
                .baselineOffset(display.exponentBaselineOffset)
        }
        .foregroundColor(Color.Neumorphic.text)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("times ten to the power of \(display.exponentPower(exponent))")
    }

    @ViewBuilder
    func digitContent(width: CGFloat, firstRowHeight: CGFloat) -> some View {
        let lines = isExpanded ? display.wrappedLines(for: width) : [Display.Line(mantissa: display.left, exponent: display.right)]
        if isExpanded && !display.preservesFirstLine {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                    lineView(line)
                        .frame(height: display.lineHeight)
                }
            }
            .padding(.vertical, display.textPadding)
            .frame(width: width, alignment: .leading)
        } else {
            let scale = display.scaleFactor(for: width, line: lines[0])
            lineView(lines[0])
                .fixedSize(horizontal: true, vertical: false)
                .scaleEffect(scale, anchor: .trailing)
                .overlay(alignment: .topLeading) {
                    GeometryReader { firstLineGeometry in
                        ForEach(Array(lines.dropFirst().enumerated()), id: \.offset) { index, line in
                            lineView(line)
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(height: firstLineGeometry.size.height)
                                .offset(x: firstLineGeometry.size.width * (1 - scale) + display.glyphAlignmentOffset(for: line, scale: scale),
                                        y: CGFloat(index + 1) * display.lineHeight)
                        }
                    }
                }
                .frame(width: width, height: firstRowHeight, alignment: .trailing)
                .frame(width: width, height: firstRowHeight + CGFloat(lines.count - 1) * display.lineHeight, alignment: .topLeading)
        }
    }

    var body: some View {
        ZStack {
            let size2 = CGSize(width: 20, height: 20)
            let size = CGSize(width: 10, height: 10)
            RoundedRectangle(cornerSize: size)
                .foregroundColor(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerSize: size), size: size2, radius: 3)
            GeometryReader { geometry in
                let firstRowHeight = compactHeight ?? geometry.size.height
                if isExpanded, let exponent = display.right {
                    let scrollHeight = max(0, geometry.size.height - firstRowHeight - 1)
                    VStack(spacing: 0) {
                        exponentView(exponent)
                            .matchedGeometryEffect(id: "exponent", in: exponentAnimation)
                            .frame(width: geometry.size.width, height: firstRowHeight, alignment: .trailing)
                        Rectangle()
                            .fill(Color.Neumorphic.text.opacity(0.15))
                            .frame(height: 1)
                        ScrollView(.vertical) {
                            digitContent(width: geometry.size.width, firstRowHeight: firstRowHeight)
                                .frame(minHeight: scrollHeight, alignment: .topLeading)
                        }
                        .frame(height: scrollHeight)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                } else if isExpanded {
                    ScrollView(.vertical) {
                        digitContent(width: geometry.size.width, firstRowHeight: firstRowHeight)
                            .frame(minHeight: geometry.size.height, alignment: .topLeading)
                    }
                } else {
                    digitContent(width: geometry.size.width, firstRowHeight: firstRowHeight)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                }
            }
            .padding(.horizontal, display.textPadding)
        }
        .clipped()
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
