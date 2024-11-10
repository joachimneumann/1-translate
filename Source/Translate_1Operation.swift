//
//  ConfigOperation.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 29.10.2024.
//

import SwiftGmp

public enum Translate_1Operation: String, OpProtocol, CaseIterable {
    case settings
    case spacer
}

extension Translate_1Operation {
    public var operatorPriority: Int { 4 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}
