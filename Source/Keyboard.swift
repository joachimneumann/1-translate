//
//  GenericKeyboard.swift
//  Calculator
//
//  Created by Joachim Neumann on 11.11.2024.
//

import SwiftUI


@Observable class Keyboard {
    var keyMatrix: [[KeyModel]] = []
    
    var callback: (KeyModel) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for k in row {
                    k.callback = callback
                }
            }
        }
    }    
}
