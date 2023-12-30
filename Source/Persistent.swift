//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI

struct Persistent {
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
