//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp


@Observable class SmallKeyboard {
    private let keySize: CGSize
    var bottomLeftKey: Key = Key(ConfigOperation.bottomLeftKey)
    let clearKey: Key
    
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
        self.clearKey = Key(ClearOperation.clear)
        bottomLeftKey.imageName = "config"
        bottomLeftKey.borderColor = nil

    }
    
    func appendRow(_ keys: [Key]) {
        for k in keys {
            k.keySize = keySize
        }
        keyMatrix.append(keys)
    }
    
    func setPending(pendingOperators: [any OpProtocol]) {
        for row in keyMatrix {
            for k in row {
                k.isPending = pendingOperators.contains(where: { $0.isEqual(to: k.op) })
            }
        }
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            self.clearKey.op = ClearOperation.back
        } else {
            self.clearKey.op = ClearOperation.clear
        }
    }
    
    
}
