//
//  Persistent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

class Persistent {
    var translationManager = TranslationManager()
//    // Store Separator as a String
//    @AppStorage("separatorString", store: .standard)
//    private var separatorString: String = Separator(
//        separatorType: (Locale.current.decimalSeparator == "," ? .comma : .dot),
//        groups: false
//    ).encoded
//
//    // Computed property to get/set the `Separator` object
//    var separator: Separator {
//        get {
//            Separator.decode(from: separatorString) ?? Separator(
//                separatorType: (Locale.current.decimalSeparator == "," ? .comma : .dot),
//                groups: false
//            )
//        }
//        set {
//            separatorString = newValue.encoded
//        }
//    }

    @AppStorage("currentFlagname", store: .standard)
    var currentFlagname: String = "English"
    
    var currentLanguage: NumberTranslator.Language {
        get {
            translationManager.language(forFlagname: currentFlagname) ?? .english
        }
        set {
            currentFlagname = translationManager.flagname(newValue)
        }
        
    }


    @AppStorage("showGrouping", store: .standard)
    var showGrouping: Bool = true

    @AppStorage("offerReadingAloudKey", store: .standard)
    var offerReadingAloud: Bool = true

    @AppStorage("englishUseAndAfterHundred", store: .standard)
    var englishUseAndAfterHundred: Bool = true
}
