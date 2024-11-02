//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class ViewModel: ObservableObject {
    let screen: Screen
    var calculator: Calculator
    var display: Display
    var translationManager: TranslationManager
    var translatorKeyboard: SmallKeyboard
    var languageSelectorKeyboard: SmallKeyboard
    var selectedLanguageKeyboard: SmallKeyboard
    var separator: Separator
    let intDisplay: IntDisplay
    @Published var showLanguageSelector: Bool = false
    
    
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
        translatorKeyboard.setPending(pendingOperators: calculator.pendingOperators)
        translatorKeyboard.bottomLeftKey.imageName = translationManager.flagname(.english)
        translatorKeyboard.bottomLeftKey.borderColor = translationManager.borderColor

        let allInOneLine = display.string
        translationManager.translate(allInOneLine)
    }

    func execute(_ key: Key) {
        if key.op.isEqual(to: ConfigOperation.bottomLeftKey) {
            print("BOTTOM LEFT \(key.op.getRawValue())")
            showLanguageSelector.toggle()
        } else if key.op.isEqual(to: ConfigOperation.flagname) {
            if let newFlagname = key.imageName {
                print("FLAG \(key.imageName!)")
                translationManager.setCurrentLanguage(newFlagname: newFlagname)
                objectWillChange.send()
            }
        } else {
            print("executing \(key.op.getRawValue())")
            calculator.press(key.op)
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
        separator = Separator(separatorType: Separator.SeparatorType.comma, groups: true)
        intDisplay = IntDisplay(displayWidth: 10, separator: separator)
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        translatorKeyboard = TranslatorKeyboard(keySize: screen.keySize)
        translationManager = TranslationManager()
        languageSelectorKeyboard = LanguageSelectorKeyboard(keySize: screen.keySize, translationManager: translationManager)
        selectedLanguageKeyboard = SelectedLanguagekeyboard(keySize: screen.keySize, translationManager: translationManager)
        translatorKeyboard.callback = execute
        languageSelectorKeyboard.callback = execute
        selectedLanguageKeyboard.callback = execute
        process()
    }

}
