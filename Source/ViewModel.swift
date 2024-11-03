//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

@Observable class ViewModel {
    let screen: Screen
    var calculator: Calculator
    var display: Display
    var translationManager: TranslationManager
    var currentLanguage: NumberTranslator.Language = .english // TODO: Persistent
    var translatorKeyboard: TranslatorKeyboard
    var languageSelectorKeyboard: LanguageSelectorKeyboard
    var selectedLanguageKeyboard: SelectedLanguagekeyboard
    var separator: Separator
    let monoFontDisplay: MonoFontDisplay
    var showLanguageSelector: Bool = false
    
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            if display.fits(calculator.displayBuffer) {
                display.left = calculator.displayBuffer
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                if let right = display.right {
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
        }

        translatorKeyboard.back(calculator.privateDisplayBufferHasDigits)
        translationManager.translateThis(display.string, to: currentLanguage)
    }

    func toggleLanguageSelector(key: Key) {
        showLanguageSelector.toggle()
    }
    
    func execute(_ key: Key) {
        if let flagKey = key as? FlagKey {
            if let newLanguage = translationManager.language(forFlagname: flagKey.flagname) {
                currentLanguage = newLanguage
                translatorKeyboard.countryKey.flagname = flagKey.flagname
                selectedLanguageKeyboard.countryKey.flagname = flagKey.flagname
                translationManager.translateThis(display.string, to: currentLanguage)
                return
            }
        }
        if let symbolKey = key as? SymbolKey {
            calculator.press(symbolKey.op)
            for row in translatorKeyboard.keyMatrix {
                for k in row {
                    if let symbolKey = k as? SymbolKey {
                        if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.op) }) {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).pendingUpColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).pendingDownColor)
                        } else {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).upColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).downColor)
                        }
                    }
                }
            }
            process()
        }
    }
    
//    private(set) var _voices: Voices!
//    var persistent = Persistent()
//
//
//    var voices: Voices {
//        return _voices
//    }

    init(screen: Screen) {
        self.screen = screen
        let tempSeparator = Separator(separatorType: Separator.SeparatorType.comma, groups: true)
        let tempTranslationManager = TranslationManager()

        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        translatorKeyboard = TranslatorKeyboard(keySize: screen.keySize)
        monoFontDisplay = MonoFontDisplay(displayWidth: 10, separator: tempSeparator)
        selectedLanguageKeyboard = SelectedLanguagekeyboard(keySize: screen.keySize)
        languageSelectorKeyboard = LanguageSelectorKeyboard(keySize: screen.keySize, translationManager: tempTranslationManager)

        separator = tempSeparator
        translationManager = tempTranslationManager

        translatorKeyboard.callback = execute
        languageSelectorKeyboard.callback = execute
        selectedLanguageKeyboard.callback = execute

        translatorKeyboard.countryKey.callback = toggleLanguageSelector
        translatorKeyboard.countryKey.flagname = translationManager.flagname(currentLanguage)
        selectedLanguageKeyboard.countryKey.callback = toggleLanguageSelector
        selectedLanguageKeyboard.countryKey.flagname = translationManager.flagname(currentLanguage)
        process()
    }

}
