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
    
    func setPending(pendingOperators: [any OpProtocol]) {
//        for row in keyMatrix {
//            for k in row {
//                k.isPending = pendingOperators.contains(where: { $0.isEqual(to: k.op) })
//            }
//        }
    }    
}
