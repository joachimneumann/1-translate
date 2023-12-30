//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI

struct Persistent {
    @AppStorage(AppStorageKeys.forceScientificKey, store: .standard)
    var forceScientific: Bool = false
    
    @AppStorage(AppStorageKeys.offerReadingAloudKey, store: .standard)
    var offerReadingAloud: Bool = false
    
    @AppStorage(AppStorageKeys.secondLanguageAllowedKey, store: .standard)
    var secondLanguageAllowed: Bool = false
    
}
