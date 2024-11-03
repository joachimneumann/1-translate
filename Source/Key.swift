//
//  Key.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp



@Observable class Key: Identifiable, Hashable {
    var width: CGFloat = 100.0
    var height: CGFloat = 100.0
    var upColor: Color = .red
    var downColor: Color = .blue
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
