//
//  ConfigOperation.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 29.10.2024.
//

import SwiftGmp

public enum ConfigOperation: String, OpProtocol, CaseIterable {
    case settings = "settings"
    case spacer = "Spacer"
}

extension ConfigOperation {
    public var operatorPriority: Int { 4 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}
