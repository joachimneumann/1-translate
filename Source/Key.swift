//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class Key: Identifiable, Hashable {
    var keySize: CGSize = CGSize(width: 10, height: 10)
    let sixColors: KeyColor.SixColors
    var downTime: Double = 0.15
    var upTime: Double = 0.4
    var isPending: Bool = false
    var borderColor: Color? = nil
    var imageName: String? = nil
    var op: any OpProtocol
    var callback: (Key) -> () = { _ in }
    init(_ op: any OpProtocol) {
        self.op = op
        sixColors = KeyColor.sixColors(op: op)
    }
    
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Key, rhs: Key) -> Bool {
        lhs.id == rhs.id
    }
}
