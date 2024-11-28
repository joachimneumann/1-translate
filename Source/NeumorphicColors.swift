//
//  NeumorphicColors.swift
//  Calculator
//
//  Created by Joachim Neumann on 28.11.2024.
//

import SwiftUI

public extension Color {

    enum ColorSchemeType {
        case auto, light, dark
    }

    static var colorSchemeType : ColorSchemeType = .auto

    struct NeumorphicColors {
        private static let lightSchemeMain = AppleColor(red: 0.925, green: 0.941, blue: 0.953, alpha: 1.0)
        private static let lightSchemeSecondary = AppleColor(red: 0.482, green: 0.502, blue: 0.549, alpha: 1.0)
        private static let lightSchemeLightShadow = AppleColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.0)
        private static let lightSchemeDarkShadow = AppleColor(red: 0.820, green: 0.851, blue: 0.902, alpha: 1.0)

        private static let darkSchemeMain = AppleColor(red: 0.188, green: 0.192, blue: 0.208, alpha: 1.0)
        private static let darkSchemeSecondary = AppleColor(red: 0.910, green: 0.910, blue: 0.910, alpha: 1.0)
        private static let darkSchemeLightShadow = AppleColor(red: 0.243, green: 0.247, blue: 0.275, alpha: 1.0)
        private static let darkSchemeDarkShadow = AppleColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)//0.137)

        public static var main: Color {
            color(light: lightSchemeMain, dark: darkSchemeMain)
        }

        public static var secondary: Color {
            color(light: lightSchemeSecondary, dark: darkSchemeSecondary)
        }

        public static var lightShadow: Color {
            color(light: lightSchemeLightShadow, dark: darkSchemeLightShadow)
        }

        public static var darkShadow: Color {
            color(light: lightSchemeDarkShadow, dark: darkSchemeDarkShadow)
        }
    }
    
    static func color(light: AppleColor, dark: AppleColor) -> Color {
            #if os(iOS)
            switch colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init { $0.userInterfaceStyle == .light ? light : dark })
            }
            #else
            switch colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init(name: nil, dynamicProvider: { (appearance) -> NSColor in
                    return appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light
                }))
            }
            #endif
        }




}
