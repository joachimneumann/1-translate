//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp


class SmallKeyboard: ObservableObject {
    let clearKey: SymbolKey
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
        clearKey = SymbolKey(ClearOperation.clear)
    }
    
    func appendRow(_ keys: [Key]) {
        for k in keys {
            k.width = keySize.width
            k.height = keySize.height
        }
        keyMatrix.append(keys)
    }
    
    func back(_ displayBufferHasDigits: Bool) {
        if displayBufferHasDigits {
            clearKey.op = ClearOperation.back
            clearKey.symbol = ClearOperation.back.getRawValue()
        } else {
            clearKey.op = ClearOperation.clear
            clearKey.symbol = ClearOperation.clear.getRawValue()
        }
    }

}
