//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp


class SmallKeyboard: ObservableObject {
    private let keySize: CGSize
    var bottomLeftKey: FlagKey
    var clearKey: SymbolKey
    
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
        self.clearKey = SymbolKey(ClearOperation.clear)
        self.bottomLeftKey = FlagKey(flagname: "config_English")
    }
    
    func appendRow(_ keys: [Key]) {
        for k in keys {
            k.width = keySize.width
            k.height = keySize.height
        }
        keyMatrix.append(keys)
    }
    
    func setPending(pendingOperators: [any OpProtocol]) {
//        for row in keyMatrix {
//            for k in row {
//                k.isPending = pendingOperators.contains(where: { $0.isEqual(to: k.op) })
//            }
//        }
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            self.clearKey.symbol = ClearOperation.back.getRawValue()
        } else {
            self.clearKey.symbol = ClearOperation.clear.getRawValue()
        }
    }
    
    
}
