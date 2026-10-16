import SwiftUI
import Neumorphic
import SwiftGmp

/// Edit the hex values here to recolor an entire button group.
/// Each entry contains separate light and dark appearance values.
enum CalculatorPalette {
    static let defaultOuterShadowOffsetRatio: CGFloat = 0.075
    static let defaultOuterShadowRadiusRatio: CGFloat = 0.0375

    struct HexColor {
        let light: String
        let dark: String

        var color: Color {
            NeumorphicKit.color(light: colorType(light), dark: colorType(dark))
        }

        private func colorType(_ hex: String) -> NeumorphicKit.ColorType {
            let value = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            let digits = value.hasPrefix("#") ? String(value.dropFirst()) : value
            guard digits.count == 6, digits.allSatisfy({ $0.isHexDigit }),
                  let rgb = UInt32(digits, radix: 16) else {
                preconditionFailure("Palette colors must use six hex digits: \(hex)")
            }
            return NeumorphicKit.colorType(
                red: CGFloat((rgb >> 16) & 0xFF) / 255,
                green: CGFloat((rgb >> 8) & 0xFF) / 255,
                blue: CGFloat(rgb & 0xFF) / 255
            )
        }
    }

    struct KeyColors {
        let fill: HexColor
        let symbol: HexColor
        let lightShadow: HexColor
        let darkShadow: HexColor
        let pressedFill: HexColor
        let pressedDarkShadow: HexColor
        let pressedLightShadow: HexColor
        /// Raised-shadow dimensions relative to the button's smaller dimension.
        var outerShadowOffsetRatio: CGFloat = CalculatorPalette.defaultOuterShadowOffsetRatio
        var outerShadowRadiusRatio: CGFloat = CalculatorPalette.defaultOuterShadowRadiusRatio
    }

    // Porcelain digits, mist-blue functions, and sage-green operators.

    /// Numbers 0–9, the decimal separator, and sign change (±).
    static let digits = KeyColors(
        fill: HexColor(light: "#EEF2F5", dark: "#35373C"),
        symbol: HexColor(light: "#2F3744", dark: "#E3E9EF"),
        lightShadow: HexColor(light: "#FFFFFF", dark: "#41444B"),
        darkShadow: HexColor(light: "#D0D9E3", dark: "#212329"),
        pressedFill: HexColor(light: "#DEE5EB", dark: "#24262B"),
        pressedDarkShadow: HexColor(light: "#BECAD6", dark: "#1B1D22"),
        pressedLightShadow: HexColor(light: "#FFFFFF", dark: "#41444B")
    )

    /// Backspace, AC, %, and all scientific functions.
    static let functions = KeyColors(
        fill: HexColor(light: "#E1E8F1", dark: "#37424E"),
        symbol: HexColor(light: "#405775", dark: "#CBD8E7"),
        lightShadow: HexColor(light: "#FAFDFF", dark: "#465361"),
        darkShadow: HexColor(light: "#C7D2E1", dark: "#25303C"),
        pressedFill: HexColor(light: "#CFD9E6", dark: "#25313E"),
        pressedDarkShadow: HexColor(light: "#B4C2D4", dark: "#1E2833"),
        pressedLightShadow: HexColor(light: "#FAFDFF", dark: "#465361")
    )

    /// Arithmetic operators: ÷, ×, −, and +.
    static let operators = KeyColors(
        fill: HexColor(light: "#D3DECC", dark: "#404B3D"),
        symbol: HexColor(light: "#45563E", dark: "#D3DECC"),
        // A faint sage tint keeps both raised shadows close to neutral.
        lightShadow: HexColor(light: "#F8FAF6", dark: "#52564F"),
        darkShadow: HexColor(light: "#C2C9C3", dark: "#222620"),
        pressedFill: HexColor(light: "#C2CFB9", dark: "#2B3528"),
        // The pressed upper-left inset shadow remains sage.
        pressedDarkShadow: HexColor(light: "#B0BDA7", dark: "#232C20"),
        // A pale sage highlight defines the pressed lower-right inset edge.
        pressedLightShadow: HexColor(light: "#DCE7D4", dark: "#576550"),
        outerShadowOffsetRatio: 0.06,
        outerShadowRadiusRatio: 0.025
    )

    /// Equals shares operator fill, symbols, and pressed relief, with neutral raised shadows.
    static let equals = KeyColors(
        fill: operators.fill,
        symbol: operators.symbol,
        lightShadow: HexColor(light: "#FFFFFF", dark: "#51545A"),
        darkShadow: HexColor(light: "#C1C9D0", dark: "#212329"),
        pressedFill: operators.pressedFill,
        pressedDarkShadow: operators.pressedDarkShadow,
        pressedLightShadow: operators.pressedLightShadow,
        outerShadowOffsetRatio: operators.outerShadowOffsetRatio,
        outerShadowRadiusRatio: operators.outerShadowRadiusRatio
    )

    static func colors(for operation: any OpProtocol) -> KeyColors? {
        // The toolbar and separate settings/copy/paste controls keep their own styling.
        if operation is ClipboardOperation || operation.isEqual(to: ControlOperation.settings) {
            return nil
        }
        if operation is DigitOperation || operation.isEqual(to: InplaceOperation.changeSign) {
            return digits
        }
        if operation.isEqual(to: EqualOperation.equal) {
            return equals
        }
        if operation.isEqual(to: TwoOperantOperation.add)
            || operation.isEqual(to: TwoOperantOperation.sub)
            || operation.isEqual(to: TwoOperantOperation.mul)
            || operation.isEqual(to: TwoOperantOperation.div) {
            return operators
        }
        // Binary scientific operations such as xʸ, ʸ√x, logʸ, and EE belong here too.
        return functions
    }
}
