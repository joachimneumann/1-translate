import SwiftUI

public extension Color {

    struct Neumorphic {
        //Color
        private static let defaultMainColor               = NeumorphicKit.colorType(red: 0.925, green: 0.941, blue: 0.953)
        private static let defaultSecondaryColor          = NeumorphicKit.colorType(red: 0.482, green: 0.502, blue: 0.549)
        private static let defaultTextColor               = NeumorphicKit.colorType(red: 0.182, green: 0.202, blue: 0.249)
        private static let defaultLightShadowSolidColor   = NeumorphicKit.colorType(red: 1.000, green: 1.000, blue: 1.000)
        private static let defaultDarkShadowSolidColor    = NeumorphicKit.colorType(red: 0.820, green: 0.851, blue: 0.902)
        private static let defaultPressedSurfaceColor     = NeumorphicKit.colorType(red: 0.880, green: 0.900, blue: 0.915)
        private static let defaultPressedDarkShadowColor  = NeumorphicKit.colorType(red: 0.760, green: 0.7955, blue: 0.851)

        private static let darkThemeMainColor             = NeumorphicKit.colorType(red: 0.188, green: 0.192, blue: 0.208)
        private static let darkThemeSecondaryColor        = NeumorphicKit.colorType(red: 0.910, green: 0.910, blue: 0.910)
        private static let darkThemeTextColor             = NeumorphicKit.colorType(red: 1.0,   green: 1.0,   blue: 1.0  )
        private static let darkThemeLightShadowSolidColor = NeumorphicKit.colorType(red: 0.243, green: 0.247, blue: 0.275)
        private static let darkThemeDarkShadowSolidColor  = NeumorphicKit.colorType(red: 0.137, green: 0.137, blue: 0.137)
        private static let darkThemePressedSurfaceColor   = NeumorphicKit.colorType(red: 0.223, green: 0.227, blue: 0.243)
        private static let darkThemePressedDarkShadowColor = NeumorphicKit.colorType(red: 0.111, green: 0.111, blue: 0.111)
                
        public static var colorSchemeType : NeumorphicKit.ColorSchemeType {
            get {
                return NeumorphicKit.colorSchemeType
            }
            set {
                NeumorphicKit.colorSchemeType = newValue
            }
        }
        
        public static var main: Color {
            NeumorphicKit.color(light: defaultMainColor, dark: darkThemeMainColor)
        }
        
        public static var secondary: Color {
            NeumorphicKit.color(light: defaultSecondaryColor, dark: darkThemeSecondaryColor)
        }

        public static var text: Color {
            NeumorphicKit.color(light: defaultTextColor, dark: darkThemeTextColor)
        }

        public static var lightShadow: Color {
            NeumorphicKit.color(light: defaultLightShadowSolidColor, dark: darkThemeLightShadowSolidColor)
        }

        public static var darkShadow: Color {
            NeumorphicKit.color(light: defaultDarkShadowSolidColor, dark: darkThemeDarkShadowSolidColor)
        }

        public static var pressedSurface: Color {
            NeumorphicKit.color(light: defaultPressedSurfaceColor, dark: darkThemePressedSurfaceColor)
        }

        public static var pressedDarkShadow: Color {
            NeumorphicKit.color(light: defaultPressedDarkShadowColor, dark: darkThemePressedDarkShadowColor)
        }
    }
    

    
    
}
