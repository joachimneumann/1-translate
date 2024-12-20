//
//  CalculatoriOSViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 12.12.2024.
//

import SwiftUI

@Observable class CalculatoriOSViewModel: ViewModel {
    private var isPortrait: Bool = true
    
    func newOrientation(_ new: UIDeviceOrientation) {
        if new == .landscapeLeft || new == .landscapeRight {
            if isPortrait {
                isPortrait = false
                isScientific = true
                populateKeyboard()
                print("\(new) --> landscape")
            }
        } else if new == .portrait || new == .portraitUpsideDown {
            if !isPortrait {
                isPortrait = true
                isScientific = false
                populateKeyboard()
                print("\(new) --> portrait")
            }
        }
    }
}
