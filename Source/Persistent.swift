//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI

class Persistent: Separators {
    /// I initialize the decimalSeparator with the locale preference, but
    /// I ignore the value of Locale.current.groupSeparator
    @AppStorage("decimalSeparatorKey", store: .standard)
    var decimalSeparator: DecimalSeparator = Locale.current.decimalSeparator == "," ? .comma : .dot {
        didSet {
            if decimalSeparator == .dot && groupSeparator == .dot {
                groupSeparator = .comma
            }
            if decimalSeparator == .comma && groupSeparator == .comma {
                groupSeparator = .dot
            }
        }
    }
    
    @AppStorage("groupSeparatorKey", store: .standard)
    var groupSeparator: GroupSeparator = .none {
        didSet {
            if decimalSeparator == .dot && groupSeparator == .dot {
                decimalSeparator = .comma
            }
            if decimalSeparator == .comma && groupSeparator == .comma {
                decimalSeparator = .dot
            }
        }
    }
    
    @AppStorage("groupSizeKey", store: .standard)
    var groupSize: GroupSize = .three
    
    @AppStorage("offerReadingAloudKey", store: .standard)
    var offerReadingAloud: Bool = true
}
