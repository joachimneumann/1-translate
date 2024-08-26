//
//  NumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

public class Translator {
    public var name: String { implementation.name }
    public func translate(_ s: String) -> String { implementation.translate(s) }
    public func translate(_ i: Int)    -> String { implementation.translate(i) }
    public func translate(_ f: Float)  -> String { implementation.translate(f) }
    public func translate(_ d: Double) -> String { implementation.translate(d) }
    
    var implementation: GeneralLanguage
    init(_ implementation: GeneralLanguage) {
        self.implementation = implementation
    }
}

public class GermanTranslator: Translator {
    public var capitalisation: Bool = false {
        didSet {
            if let german = self.implementation as? GermanImplementation {
                german.capitalisation = capitalisation
            }
        }
    }
}

public class EnglishTranslator: Translator {
    public var useAndAfterHundred: Bool = false {
        didSet {
            if let english = self.implementation as? EnglishImplementation {
                english.useAndAfterHundred = useAndAfterHundred
            }
        }
    }
}

public class BabylonianTranslator: Translator {
    public var allowEmptyColumn: Bool = false {
        didSet {
            if let babylonian = self.implementation as? BabylonianImplementation {
                babylonian.allowEmptyColumn = allowEmptyColumn
            }
        }
    }
}
   
public let arabicNumeralsTranslator     : Translator           = Translator          (ArabicNumeralsImplementation())
public let armenianTranslator           : Translator           = Translator          (ArmenianImplementation())
public let armenianNumeralsTranslator   : Translator           = Translator          (ArmenianNumeralsImplementation())
public let babylonianTranslator         : BabylonianTranslator = BabylonianTranslator(BabylonianImplementation())
public let catalanTranslator            : Translator           = Translator          (CatalanImplementation())
public let chineseFinancialTranslator   : Translator           = Translator          (ChineseImplementation(variant: ChineseImplementation.Variant.financial))
public let chineseSimplifiedTranslator  : Translator           = Translator          (ChineseImplementation(variant: ChineseImplementation.Variant.simplified))
public let chineseTraditionalTranslator : Translator           = Translator          (ChineseImplementation(variant: ChineseImplementation.Variant.traditional))
public let danishTranslator             : Translator           = Translator          (DanishImplementation())
public let englishTranslator            : EnglishTranslator    = EnglishTranslator   (EnglishImplementation())
public let esperantoTranslator          : Translator           = Translator          (EsperantoImplementation())
public let germanTranslator             : GermanTranslator     = GermanTranslator    (GermanImplementation())
public let hindiTranslator              : Translator           = Translator          (HindiImplementation())
public let romanTranslator              : Translator           = Translator          (RomanImplementation())
public let spanishTranslator            : Translator           = Translator          (SpanishImplementation())
public let thaiNumeralsTranslator       : Translator           = Translator          (ThaiNumeralsImplementation())
public let vietnameseTranslator         : Translator           = Translator          (VietnameseImplementation())

