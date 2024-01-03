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
    let arabic: Language              = ArabicImpl() // not working
    let arabicNumerals: Language      = ArabicNumeralsImpl()
    let armenianNumerals: Language    = ArmenianNumeralsImpl()
    let armenian: Language            = ArmenianImpl()
    let babylonian: Language          = BabylonianImpl()
    let catalan: Language             = CatalanImpl()
    let chineseFinancial: Language    = ChineseImpl(variant: .financial)
    let chineseSimplified: Language   = ChineseImpl(variant: .simplified)
    let chineseTraditional: Language  = ChineseImpl(variant: .traditional)
    let danish: Language              = DanishImpl()
    let digits: Language              = DigitsImpl()
    var english: English              = EnglishImpl()
    var esperanto: Language           = EsperantoImpl()
    var spanish: Spanish              = SpanishImpl()
    let french: Language              = FrenchImpl()
    var german: German                = GermanImpl()
    var hieroglyphs: Language         = HieroglyphsImpl()
    let polish: Language              = PolishImpl()
    let russian: Language             = RussianImpl()
    let swahili: Language             = SwahiliImpl()
    let roman: Language               = RomanImpl()
    let thai: Language                = ThaiImpl()
    let thaiNumerals: Language        = ThaiNumeralsImpl()
    var vietnamese: Vietnamese        = VietnameseImpl()
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
        spanish,
        swahili,
        french,
        german,
        hieroglyphs,
        polish,
        roman,
        russian,
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
