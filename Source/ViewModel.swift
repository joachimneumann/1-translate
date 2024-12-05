//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI
import SwiftGmp

#if CALCULATOR_MAC || TRANSLATE_MAC
public typealias AppleFont = NSFont
public typealias AppleColor = NSColor
public typealias AppleImage = NSImage
#else
public typealias AppleFont = UIFont
public typealias AppleColor = UIColor
public typealias AppleImage = UIImage
#endif

// Define an environment key
struct SchemeKey: EnvironmentKey {
    static var defaultValue: String = "Default" // Set a default value
}

extension EnvironmentValues {
    var scheme: String {
        get { self[SchemeKey.self] }
        set { self[SchemeKey.self] = newValue }
    }
}


class ViewModel: ObservableObject {
    var calculator: Calculator
    var smallKeyboard: SmallKeyboard? = nil
    @Published var display: Display
    
    init() {
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: 200, font: AppleFont.systemFont(ofSize: 20, weight: .regular), ePadding: 10)
    }
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            var withGrouping: String = calculator.displayBuffer
            inject(into: &withGrouping, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
            if display.fits(withGrouping) {
                display.left = withGrouping
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
                if var right = display.right {
                    inject(into: &right, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            if let right = display.right {
                display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
            }

            inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
        }
    }
    
    func execute(_ key: KeyModel) {
        if let symbolKey = key as? SymbolKey {
            calculator.press(symbolKey.model.op)
            if let smallKeyboard = smallKeyboard {
                smallKeyboard.back(calculator.privateDisplayBufferHasDigits)
                for row in smallKeyboard.keyMatrix {
                    for k in row {
                        if let symbolKey = k as? SymbolKey {
                            if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.model.op) }) {
                                symbolKey.setColors(
                                    textColor: KeyColor.sixColors(op: symbolKey.model.op).pendingTextColor,
                                    upColor: KeyColor.sixColors(op: symbolKey.model.op).pendingUpColor,
                                    downColor: KeyColor.sixColors(op: symbolKey.model.op).pendingDownColor)
                            } else {
                                symbolKey.setColors(
                                    textColor: KeyColor.sixColors(op: symbolKey.model.op).textColor,
                                    upColor: KeyColor.sixColors(op: symbolKey.model.op).upColor,
                                    downColor: KeyColor.sixColors(op: symbolKey.model.op).downColor)
                            }
                        }
                    }
                }
            }
            process()
        }
    }
}
