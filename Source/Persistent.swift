//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI
import SwiftGmp

class Persistent {
    /// I initialize the decimalSeparator with the locale preference, but
//    @AppStorage("decimalSeparatorKey", store: .standard)
//    var decimalSeparator: Sepa = Locale.current.decimalSeparator == "," ? .comma : .dot
    
    @AppStorage("separateGroupsKey", store: .standard)
    var separateGroups: Bool = false
    
    @AppStorage("offerReadingAloudKey", store: .standard)
    var offerReadingAloud: Bool = true
}
