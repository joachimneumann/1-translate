//
//  CalculatoriOSOperation.swift
//  Calculator
//
//  Created by Joachim Neumann on 11.11.2024.
//

import SwiftGmp

public enum CalculatoriOSOperation: String, OpProtocol, CaseIterable {
    case settings
}

extension CalculatoriOSOperation {
    public var operatorPriority: Int { 4 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}
