//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 06.12.2024.
//

import SwiftUI
import SwiftGmp
#if os(iOS)
import UIKit
#endif

@Observable class ViewModel: ObservableObject {
    
    enum RadDeg {
        case rad
        case deg
    }
    var radDeg: RadDeg = .deg
    var second: Bool = false
    let keyboard: KeyboardModel = KeyboardModel()
    let settingsKey = KeyModel(op: ControlOperation.settings)
    let copyKey = KeyModel(op: ClipboardOperation.copy)
    let pasteKey = KeyModel(op: ClipboardOperation.paste)
    var clipboardMessage: String?
    private var clipboardMessageTimer: Timer?
    var displayFrame: CGSize = .zero
    var display: Display
    var expandedDisplay: Display?
    static let calculationPrecision = 1000
    let calculator = Calculator(precision: ViewModel.calculationPrecision, displayWidth: ViewModel.calculationPrecision)
    var width: CGFloat = 100
    var height: CGFloat = 100
    let isMac: Bool
    let isTranslator: Bool
    var isScientific: Bool = false
    var isDisplayExpanded: Bool = false
    var usesSystemToolbar: Bool = false
    private var displayFontSize: CGFloat = 0
    private var visuallyPendingOperator: (any OpProtocol)?

    var showsSettingsBesideDisplay: Bool {
        isScientific && !isMac && !isTranslator
    }

    var displayTopInset: CGFloat {
        max(0, height - displayFrame.height - keyboard.keyboardFrame.height)
    }

    var currentDisplayHeight: CGFloat {
        isDisplayExpanded ? height - displayTopInset : displayFrame.height
    }

    func toggleDisplayExpansion() {
        guard showsSettingsBesideDisplay else { return }
        clipboardMessageTimer?.invalidate()
        clipboardMessage = nil
        isDisplayExpanded.toggle()
        expandedDisplay = isDisplayExpanded ? makeExpandedDisplay() : nil
        if let expandedDisplay { process(expandedDisplay) }
    }
    
    init(isTranslator: Bool = false, isMac: Bool = false) {
        self.isTranslator = isTranslator
        self.isMac = isMac
        if isMac {
            isScientific = true
        }
        display = Display(floatDisplayWidth: 0, font: AppleFont.systemFont(ofSize: 0), ePadding: 0)
        display.left = "0"
        setWidth()
    }
    
    func updateDimensions(width: CGFloat, height: CGFloat) {
        // Navigation containers can briefly report zero bounds while changing displays.
        guard width.isFinite, height.isFinite, width > 0, height > 0 else { return }
        self.width = width
        self.height = height
        if isMac {
            self.isScientific = true
        } else {
            self.isScientific = !isTranslator && (width > height)
        }
        setWidth()
    }
    
    func setWidth() {
        if !showsSettingsBesideDisplay { isDisplayExpanded = false }
        if isTranslator {
            keyboard.translatorKeyboard(width: width - 10, height: height * 0.5)
            displayFrame.width = keyboard.keyboardFrame.width
            displayFrame.height = keyboard.keyboardFrame.height * 0.22
            displayFontSize = floor(displayFrame.width * 0.15)
        } else {
            if isScientific {
                keyboard.scientificKeyboard(width: width, height: height * 0.75, hasSeparateSettings: showsSettingsBesideDisplay)
                displayFrame.width = keyboard.keyboardFrame.width
                displayFrame.height = keyboard.keyboardFrame.height * 0.2
                displayFontSize = floor(displayFrame.width * 0.04)
                if showsSettingsBesideDisplay && !usesSystemToolbar, let key = keyboard.keyMatrix.first?.first {
                    settingsKey.setSize(CGSize(width: key.width, height: key.height))
                    copyKey.setSize(CGSize(width: key.width, height: key.height))
                    pasteKey.setSize(CGSize(width: key.width, height: key.height))
                    displayFrame.width -= settingsKey.width + keyboard.spacing
                }
            } else {
                keyboard.calculatorKeyboard(width: width, height: height * 0.75)
                displayFrame.width = width
                displayFrame.height = keyboard.keyboardFrame.height * 0.22
                displayFontSize = floor(keyboard.keyboardFrame.width * 0.12)
            }
        }
        refreshScientificKeys()
        setDisplay(font: AppleFont.systemFont(ofSize: displayFontSize))
        refreshEditingKeys()
        refreshPendingKeys()
        keyboard.callback = execute
        keyboard.pressBegan = keyPressBegan
        settingsKey.callback = execute
        copyKey.callback = execute
        pasteKey.callback = execute
    }

    var numberForClipboard: String? {
        let raw = calculator.raw
        guard !raw.isError else { return nil }
        let fullDisplay = Display(floatDisplayWidth: displayFrame.width, font: AppleFont.systemFont(ofSize: 1), ePadding: 0, digitLimit: Self.calculationPrecision)
        fullDisplay.update(raw: raw)
        return fullDisplay.left + (fullDisplay.right ?? "")
    }

    @discardableResult
    func pasteNumber(_ text: String?) -> Bool {
        guard var number = text else {
            showClipboardMessage("Clipboard has no number.")
            return false
        }
        number = number.filter { !$0.isWhitespace }
        number = number.replacingOccurrences(of: "−", with: "-")
        // Prefer standard decimal/scientific notation so our own copies round-trip
        // even when the display uses a different decimal separator.
        var accepted = calculator.replaceCurrentNumber(number)
        if !accepted {
            var validGrouping = true
            if let groupingCharacter = display.groupingCharacter, number.contains(groupingCharacter) {
                let group = NSRegularExpression.escapedPattern(for: String(groupingCharacter))
                let decimal = NSRegularExpression.escapedPattern(for: String(display.separatorCharacter))
                let pattern = #"\A[+-]?[0-9]{1,3}(?:"# + group + #"[0-9]{3})+(?:"# + decimal + #"[0-9]+)?(?:[eE][+-]?[0-9]+)?\z"#
                validGrouping = number.range(of: pattern, options: .regularExpression) != nil
                if validGrouping { number.removeAll { $0 == groupingCharacter } }
            }
            if validGrouping {
                number = number.replacingOccurrences(of: String(display.separatorCharacter), with: ".")
                accepted = calculator.replaceCurrentNumber(number)
            }
        }
        guard accepted else {
            showClipboardMessage("Clipboard has no valid number.")
            return false
        }
        clipboardMessageTimer?.invalidate()
        clipboardMessage = nil
        setDisplay(font: AppleFont.systemFont(ofSize: displayFontSize))
        refreshEditingKeys()
        refreshPendingKeys()
        return true
    }

    private func showClipboardMessage(_ message: String) {
        clipboardMessageTimer?.invalidate()
        withAnimation(.easeInOut(duration: 0.2)) {
            clipboardMessage = message
        }
        clipboardMessageTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            guard let self else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                self.clipboardMessage = nil
            }
            self.clipboardMessageTimer = nil
        }
    }

    private func setDisplay(font: AppleFont) {
        let previousDisplay = display
        let compactDisplay = Display(floatDisplayWidth: displayFrame.width - 2 * keyboard.padding, font: font, ePadding: 10.0)
        compactDisplay.groupingCharacter = previousDisplay.groupingCharacter
        compactDisplay.groupSize = previousDisplay.groupSize
        compactDisplay.separatorCharacter = previousDisplay.separatorCharacter
        display = compactDisplay
        expandedDisplay = isDisplayExpanded ? makeExpandedDisplay() : nil
        process()
    }

    private func makeExpandedDisplay() -> Display {
        let expanded = Display(floatDisplayWidth: displayFrame.width - 2 * keyboard.padding,
                               font: AppleFont.systemFont(ofSize: displayFontSize),
                               ePadding: 10.0, digitLimit: Self.calculationPrecision)
        expanded.groupingCharacter = display.groupingCharacter
        expanded.groupSize = display.groupSize
        expanded.separatorCharacter = display.separatorCharacter
        return expanded
    }
    
    func toggleScientific() {
        isScientific.toggle()
        setWidth()
    }
    
    func process() {
        process(display)
        if let expandedDisplay {
            expandedDisplay.groupingCharacter = display.groupingCharacter
            expandedDisplay.groupSize = display.groupSize
            expandedDisplay.separatorCharacter = display.separatorCharacter
            process(expandedDisplay)
        }
    }

    private func process(_ display: Display) {
        display.objectWillChange.send()
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
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
        }
    }

    private func keyPressBegan(_ key: KeyAnimation) {
        guard let keyModel = key as? KeyModel,
              keyModel.symbolKey?.op is DigitOperation else { return }
        visuallyPendingOperator = nil
        refreshPendingKeys()
    }

    func execute(_ key: KeyAnimation) {
        guard key.isEnabled else { return }
        if let keyModel = key as? KeyModel {
            if let op = keyModel.symbolKey?.op {
                if let clipboardOperation = op as? ClipboardOperation {
#if os(iOS)
                    switch clipboardOperation {
                    case .copy:
                        if let number = numberForClipboard {
                            UIPasteboard.general.string = number
                            showClipboardMessage("Copied")
                        } else {
                            showClipboardMessage("No number to copy.")
                        }
                    case .paste:
                        pasteNumber(UIPasteboard.general.string)
                    }
#endif
                    return
                }
                if op.isEqual(to: ClearOperation.back) && !calculator.canBack {
                    return
                }
                if op.isEqual(to: ControlOperation.calc) {
                    toggleScientific()
                } else if op.isEqual(to: ControlOperation.rad) {
                    radDeg = .deg
                    keyModel.symbolKey!.op = ControlOperation.deg
                    keyModel.symbolKey!.symbol = keyModel.symbolKey!.op.getRawValue()
                } else if op.isEqual(to: ControlOperation.deg) {
                    radDeg = .rad
                    keyModel.symbolKey!.op = ControlOperation.rad
                    keyModel.symbolKey!.symbol = keyModel.symbolKey!.op.getRawValue()
                } else if op.isEqual(to: ControlOperation.second) {
                    second.toggle()
                    refreshScientificKeys()
                } else {
                    if radDeg == .deg {
                        switch op {
                        case InplaceOperation.sin:  calculator.press(InplaceOperation.sind)
                        case InplaceOperation.cos:  calculator.press(InplaceOperation.cosd)
                        case InplaceOperation.tan:  calculator.press(InplaceOperation.tand)
                        case InplaceOperation.asin: calculator.press(InplaceOperation.asind)
                        case InplaceOperation.acos: calculator.press(InplaceOperation.acosd)
                        case InplaceOperation.atan: calculator.press(InplaceOperation.atand)
                        default:
                            calculator.press(op)
                        }
                    } else {
                        calculator.press(op)
                    }
                }
                if op is DigitOperation || op is ClearOperation {
                    visuallyPendingOperator = nil
                } else if op is TwoOperantOperation {
                    visuallyPendingOperator = op
                }
            }
            process()
            
            refreshEditingKeys()
            
            refreshPendingKeys()
        }
    }

    private func refreshScientificKeys() {
        for row in keyboard.keyMatrix {
            for k in row {
                guard let symbolKey = k.symbolKey else { continue }
                if symbolKey.op.isEqual(to: InplaceOperation.asin) || symbolKey.op.isEqual(to: InplaceOperation.sin) {
                    symbolKey.op = second ? InplaceOperation.asin : InplaceOperation.sin
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.acos) || symbolKey.op.isEqual(to: InplaceOperation.cos) {
                    symbolKey.op = second ? InplaceOperation.acos : InplaceOperation.cos
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.atan) || symbolKey.op.isEqual(to: InplaceOperation.tan) {
                    symbolKey.op = second ? InplaceOperation.atan : InplaceOperation.tan
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.asinh) || symbolKey.op.isEqual(to: InplaceOperation.sinh) {
                    symbolKey.op = second ? InplaceOperation.asinh : InplaceOperation.sinh
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.acosh) || symbolKey.op.isEqual(to: InplaceOperation.cosh) {
                    symbolKey.op = second ? InplaceOperation.acosh : InplaceOperation.cosh
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.atanh) || symbolKey.op.isEqual(to: InplaceOperation.tanh) {
                    symbolKey.op = second ? InplaceOperation.atanh : InplaceOperation.tanh
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: TwoOperantOperation.powyx) || symbolKey.op.isEqual(to: InplaceOperation.exp) {
                    symbolKey.op = second ? TwoOperantOperation.powyx : InplaceOperation.exp
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.exp2) || symbolKey.op.isEqual(to: InplaceOperation.exp10) {
                    symbolKey.op = second ? InplaceOperation.exp2 : InplaceOperation.exp10
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: TwoOperantOperation.logy) || symbolKey.op.isEqual(to: InplaceOperation.ln) {
                    symbolKey.op = second ? TwoOperantOperation.logy : InplaceOperation.ln
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
                if symbolKey.op.isEqual(to: InplaceOperation.log2) || symbolKey.op.isEqual(to: InplaceOperation.log10) {
                    symbolKey.op = second ? InplaceOperation.log2 : InplaceOperation.log10
                    symbolKey.symbol = symbolKey.op.getRawValue()
                }
            }
        }
    }

    private func refreshEditingKeys() {
        keyboard.updateEditingKeys(hasCurrentEntry: calculator.hasCurrentEntry, canBack: calculator.canBack)
    }

    private func refreshPendingKeys() {
        // The visual indication ends on digit entry; calculation precedence does not.
        if let operation = visuallyPendingOperator,
           !calculator.pendingOperators.contains(where: { $0.isEqual(to: operation) }) {
            visuallyPendingOperator = nil
        }
        for row in keyboard.keyMatrix {
            for key in row {
                guard let symbolKey = key.symbolKey else { continue }
                let isSecondSelected = symbolKey.op.isEqual(to: ControlOperation.second) && second
                key.setPending(isSecondSelected || visuallyPendingOperator?.isEqual(to: symbolKey.op) == true)
                symbolKey.textColor = symbolKey.defaultTextColor
            }
        }
    }

}
