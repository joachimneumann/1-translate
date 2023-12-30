//
//  Priority.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import Foundation

struct Priority {
    var previously: [String] = []
    mutating func add(new: String) {
        previously = previously.filter { $0 != new }
        previously.insert(new, at: 0)
        //        print("add: ") for p in previously { print(" "+p) }
    }
    
    func get(except notThis: String) -> String {
        for i in 0..<previously.count {
            if previously[i] != notThis {
                return previously[i]
            }
        }
        return ""
    }
}
