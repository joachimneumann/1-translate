//
//  GenericKeyboard.swift
//  Calculator
//
//  Created by Joachim Neumann on 11.11.2024.
//

import SwiftUI


class Keyboard: ObservableObject {
    private let keySize: CGSize
    private(set) var keyMatrix: [[Key]] = []
    
    var callback: (Key) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for k in row {
                    k.callback = callback
                }
            }
        }
    }
    
    init(keySize: CGSize) {
        self.keySize = keySize
    }
    
    func appendRow(_ keys: [Key]) {
        for k in keys {
            k.width = keySize.width
            k.height = keySize.height
        }
        keyMatrix.append(keys)
    }
}
