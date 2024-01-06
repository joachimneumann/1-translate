//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import SwiftUI

@Observable class Languages {
    
    struct LanguagePersistent {
        @AppStorage("firstNameKey") var firstName: String = "English"
        @AppStorage("secondNameKey") var secondName: String = "German"
        @AppStorage("secondLanguageAllowedKey") var secondLanguageAllowed: Bool = false

    }

    var persistent = LanguagePersistent()
    var first: Language!
    var second: Language!
    var list: [Language] = []
    let arabic              = ArabicImpl() // not working
    let arabicNumerals      = ArabicNumeralsImpl()
    let armenianNumerals    = ArmenianNumeralsImpl()
    let armenian            = ArmenianImpl()
    let babylonian          = BabylonianImpl()
    let catalan             = CatalanImpl()
    let chineseFinancial    = ChineseImpl(variant: .financial)
    let chineseSimplified   = ChineseImpl(variant: .simplified)
    let chineseTraditional  = ChineseImpl(variant: .traditional)
    let danish              = DanishImpl()
    let digits              = DigitsImpl()
    var english             = EnglishImpl()
    var esperanto           = EsperantoImpl()
    var spanish             = SpanishImpl()
    let finnish             = FinnishImpl()
    let french              = FrenchImpl()
    var german              = GermanImpl()
    var hieroglyphs         = HieroglyphsImpl()
    var hindi               = HindiImpl()
    let polish              = PolishImpl()
    let russian             = RussianImpl()
    let swahili             = SwahiliImpl()
    let roman               = RomanImpl()
    let thai                = ThaiImpl()
    let thaiNumerals        = ThaiNumeralsImpl()
    var vietnamese    = VietnameseImpl()
    var previouslySelectedLanguages = Priority()

    init() {
        list = [
        //arabic,
        arabicNumerals,
        armenianNumerals,
        armenian,
        babylonian,
        catalan,
        chineseFinancial,
        chineseSimplified,
        chineseTraditional,
        danish,
        // digits,
        english,
        esperanto,
        finnish,
        french,
        spanish,
        german,
        hieroglyphs,
        hindi,
        polish,
        roman,
        russian,
        swahili,
        thai,
        thaiNumerals,
        vietnamese]
        
        first = english
        second = german

        // random preferences
        previouslySelectedLanguages.add(new: german.name)
        previouslySelectedLanguages.add(new: spanish.name)
        previouslySelectedLanguages.add(new: english.name)
        
        for index in 0..<list.count {
            if persistent.secondName == list[index].name {
                indexOfSecondLanguage = index
                newSecondLanguage(list[index])
            }
            if persistent.firstName == list[index].name {
                indexOfFirstLanguage = index
                newFirstLanguage(list[index])
            }
        }
    }
    
    var firstFont: Font {
        switch first.name {
        case arabicNumerals.name:
            Font(UIFont(name: "Avenir", size: persistent.secondLanguageAllowed ? 40 : 50)!)
        default:
            persistent.secondLanguageAllowed ? Font.title : Font.largeTitle
        }
    }
    var secondFont: Font {
        switch second.name {
        case arabicNumerals.name:
            Font(UIFont(name: "Avenir", size: 40)!)
        default:
            Font.title
        }
    }

    
    var indexOfFirstLanguage: Int? = 0 {
        didSet {
            if let index = indexOfFirstLanguage {
                newFirstLanguage(list[index])
            }
        }
    }
    var indexOfSecondLanguage: Int? = 0 {
        didSet {
            if let index = indexOfSecondLanguage {
                newSecondLanguage(list[index])
            }
        }
    }

    
    func newFirstLanguage(_ newLanguage: Language) {
        // print("newFirstLanguage: " + newLanguage.name)
        first = newLanguage
        previouslySelectedLanguages.add(new: newLanguage.name)
        if second.name == newLanguage.name {
            /// find a different second language
            let newLanguageName = previouslySelectedLanguages.get(except: newLanguage.name)
            if newLanguageName != "" {
                for newLanguage in list {
                    if newLanguage.name == newLanguageName {
                        second = newLanguage
                    }
                }
            }
            persistent.firstName  = first.name
            persistent.secondName =  second.name
            for index in 0..<list.count {
                if persistent.firstName == list[index].name {
                    indexOfFirstLanguage = index
                }
                if persistent.secondName == list[index].name {
                    indexOfSecondLanguage = index
                }
            }
        }
    }
    
    func newSecondLanguage(_ newLanguage: Language) {
        // print("newSecondLanguage: " + newLanguage.name)
        second = newLanguage
        previouslySelectedLanguages.add(new: second.name)
        if first.name == second.name {
        /// find a different first language
            let newLanguageName = previouslySelectedLanguages.get(except: second.name)
            if newLanguageName != "" {
                for newLanguage in list {
                    if newLanguage.name == newLanguageName {
                        first = newLanguage
                    }
                }
            }
            persistent.firstName  = first.name
            persistent.secondName = second.name
            for index in 0..<list.count {
                if persistent.firstName == list[index].name {
                    indexOfFirstLanguage = index
                }
                if persistent.secondName == list[index].name {
                    indexOfSecondLanguage = index
                }
            }
        }
    }
    
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
}
