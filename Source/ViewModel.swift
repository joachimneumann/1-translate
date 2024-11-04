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
    var currentLanguageName: String
    var currentLanguageEnglishName: String?
    var translationManager: TranslationManager
    var translatorKeyboard: TranslatorKeyboard
    var languageSelectorKeyboard: LanguageSelectorKeyboard
    var selectedLanguageKeyboard: SelectedLanguagekeyboard
    let monoFontDisplay: MonoFontDisplay
    var showLanguageSelector: Bool = false
    var navigateToSettings: Bool = false
    
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
        translationManager.translateThis(display.string, to: persistent.currentLanguage)
    }

    func toggleLanguageSelector(key: Key) {
        showLanguageSelector.toggle()
    }
    
    func execute(_ key: Key) {
        if let flagKey = key as? FlagKey {
            if let newLanguage = translationManager.language(forFlagname: flagKey.flagname) {
                persistent.currentLanguage = newLanguage
                currentLanguageName = translationManager.name(persistent.currentLanguage)
                currentLanguageEnglishName = translationManager.englishName(persistent.currentLanguage)
                translatorKeyboard.countryKey.flagname = flagKey.flagname
                selectedLanguageKeyboard.countryKey.flagname = flagKey.flagname
                translationManager.translateThis(display.string, to: persistent.currentLanguage)
                return
            }
        }
            
        if let symbolKey = key as? SymbolKey {
            if symbolKey.op.isEqual(to: ConfigOperation.settings) {
                navigateToSettings = true  // Trigger navigation
                return
            }
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
    var persistent = Persistent()
//
//
//    var voices: Voices {
//        return _voices
//    }

    init(screen: Screen = Screen()) {
        currentLanguageName = ""
        currentLanguageEnglishName = nil
        self.screen = screen
        let tempTranslationManager = TranslationManager()

        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        translatorKeyboard = TranslatorKeyboard(keySize: screen.keySize)
        monoFontDisplay = MonoFontDisplay(displayWidth: 10)
        selectedLanguageKeyboard = SelectedLanguagekeyboard(keySize: screen.keySize)
        languageSelectorKeyboard = LanguageSelectorKeyboard(keySize: screen.keySize, translationManager: tempTranslationManager)

        translationManager = tempTranslationManager
        monoFontDisplay.separator = persistent.separator
        translatorKeyboard.callback = execute
        languageSelectorKeyboard.callback = execute
        selectedLanguageKeyboard.callback = execute

        translatorKeyboard.countryKey.callback = toggleLanguageSelector
        translatorKeyboard.countryKey.flagname = translationManager.flagname(persistent.currentLanguage)
        selectedLanguageKeyboard.countryKey.callback = toggleLanguageSelector
        selectedLanguageKeyboard.countryKey.flagname = translationManager.flagname(persistent.currentLanguage)
        process()
    }

}
