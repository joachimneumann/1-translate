//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI

struct Persistent: Separators {
    /// I initialize the decimalSeparator with the locale preference, but
    /// I ignore the value of Locale.current.groupSeparator
    @AppStorage("decimalSeparatorKey", store: .standard)
    var decimalSeparator: DecimalSeparator = Locale.current.decimalSeparator == "," ? .comma : .dot
    
    @AppStorage("groupSeparatorKey", store: .standard)
    var groupSeparator: GroupSeparator = .none
    
    @AppStorage("groupSizeKey", store: .standard)
    var groupSize: GroupSize = .three

    @AppStorage("forceScientificKey", store: .standard)
    var forceScientific: Bool = false
    
    @AppStorage("offerReadingAloudKey", store: .standard)
    var offerReadingAloud: Bool = false
    
    @AppStorage("secondLanguageAllowedKey", store: .standard)
    var secondLanguageAllowed: Bool = false
    
    @AppStorage("firstLanguageKey", store: .standard)
    var firstLanguageName: String = "English"
    
    @AppStorage("secondLanguageKey", store: .standard)
    var secondLanguageName: String = "German"
    

}
