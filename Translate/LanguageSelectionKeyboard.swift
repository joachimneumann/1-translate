////
////  LanguageSelectionKeyboard.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 01.11.2024.
////
//
//import SwiftUI
//import SwiftGmp
//import NumberTranslator
//
//
//class LanguageSelectionKeyboard: Keyboard {
//    let countryKey: FlagKey
//    let countryDescriptionKey: TextKey
//    init(translateViewModel: TranslateViewModel) {
//        countryKey = FlagKey(
//            persistent: translateViewModel.persistent,
//            toggle: translateViewModel.toggle)
////        countryKey.isToggleButton = true
//        countryDescriptionKey = TextKey(top: "", bottom: nil)
//        super.init()
//        var columnIndex = 1
//        var tempRow: [KeyAnimation] = []
//        for language in translateViewModel.translationManager.sortedlanguages {
//            let tempKey = FlagKey(
//                persistent: translateViewModel.persistent,
//                languageEnum: language,
//                toggle: nil,
//                setLanguage: translateViewModel.setLanguage)
//            tempRow.append(tempKey)
//            columnIndex += 1
//            if columnIndex == 5 {
//                keyMatrix.append(tempRow)
//                tempRow.removeAll()
//                columnIndex = 1
//            }
//        }
//        if tempRow.count > 0 {
//            keyMatrix.append(tempRow)
//        }
//        tempRow = []
//        tempRow.append(countryKey)
//#if TRANSLATE_IOS
//        tempRow.append(countryDescriptionKey)
//        tempRow.append(SymbolKey(TranslateOperation.settings))
//#else
//        tempRow.append(countryDescriptionKey)
//#endif
//        keyMatrix.append(tempRow)
//    }
//    
//}
