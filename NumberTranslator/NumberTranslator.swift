//
//  NumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

public class Translator {
    public static let wordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@"
    public var name: String { implementation.name }
    public var englishName: String? { implementation.englishName }
    public var code: String? { implementation.code }
    public var groupSize: Int { implementation.groupSize }
    public func translate(_ s: String) -> String { implementation.translate(s) }
    public func translate(_ i: Int)    -> String { implementation.translate(i) }
    public func translate(_ f: Float)  -> String { implementation.translate(f) }
    public func translate(_ d: Double) -> String { implementation.translate(d) }
    
    var implementation: GeneralLanguage
    init(_ implementation: GeneralLanguage) {
        self.implementation = implementation
    }
}

public class Translators {
    public var list: [Translator] = []
    private func add(_ language: GeneralLanguage) {
        list.append(Translator(language))
    }
    public init() {
        add(ArabicNumeralsImplementation())
        add(ArmenianImplementation())
        add(ArmenianNumeralsImplementation())
        add(BabylonianImplementation())
        add(CatalanImplementation())
        add(ChineseImplementation(variant: ChineseImplementation.Variant.financial))
        add(ChineseImplementation(variant: ChineseImplementation.Variant.simplified))
        add(ChineseImplementation(variant: ChineseImplementation.Variant.traditional))
        add(DanishImplementation())
        add(EnglishImplementation())
        add(EsperantoImplementation())
        add(FinnishImplementation())
        add(FrenchImplementation())
        add(GermanImplementation())
        add(HindiImplementation())
        add(HieroglyphsImplementation())
        add(ItalianImplementation())
        add(PolishImplementation())
        add(PortugueseImplementation(variant: PortugueseImplementation.Variant.european))
        add(PortugueseImplementation(variant: PortugueseImplementation.Variant.brazilian))
        add(RomanNumeralsImplementation())
        add(RussianImplementation())
        add(SpanishImplementation())
        add(SwahiliImplementation())
        add(ThaiImplementation())
        add(ThaiNumeralsImplementation())
        add(UkrainianImplementation())
        add(VietnameseImplementation())
    }
}

public protocol GermanParameterProtocol {
    var capitalisation: Bool { get set }
}

public protocol EnglishParameterProtocol {
    var useAndAfterHundred: Bool { get set }
}

public protocol BabylonianParameterProtocol {
    var allowEmptyColumn: Bool { get set }
}
