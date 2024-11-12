//
//  CalculatoriOSViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

class CalculatoriOSViewModel: ViewModel {
    @Published var keyboard: CalculatoriOSKeyboard
    override init(screen: Screen) {
        keyboard = CalculatoriOSKeyboard(keySize: screen.keySize)
        super.init(screen: screen)
        keyboard.callback = execute
        smallKeyboard = keyboard
    }
}
