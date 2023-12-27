//
//  Separators.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/6/23.
//

import Foundation

enum DecimalSeparator: String, Codable, CaseIterable {
    case comma
    case dot
    var character: Character {
        get {
            switch self {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    var string: String {
        get {
            String(character)
        }
    }
}
enum GroupSeparator: String, Codable, CaseIterable {
    case comma
    case dot
    case none
    var character: Character? {
        get {
            switch self {
            case .none: return nil
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    var string: String {
        get {
            guard let character = character else { return "" }
            return String(character)
        }
    }
}
enum GroupSize: Int, Codable, CaseIterable {
    case _3
    case _4
    var int: Int {
        get {
            switch self {
            case ._4: return 4
            default: return 3
            }
        }
    }
    var string: String {
        get {
            switch self {
            case ._4: return "4"
            default: return "3"
            }
        }
    }
}

protocol Separators {
    var decimalSeparator: DecimalSeparator   { get }
    var groupSeparator: GroupSeparator { get }
    var groupSize: GroupSize { get }
}
