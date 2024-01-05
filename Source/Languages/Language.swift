//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import Foundation

protocol Language {
    func read(_ numberString: String) -> String
    func read(_ i: Int) -> String
    func speakingPostProcessing(_ text: String) -> String
    var name: String { get }
    var nameDescription: String? { get }
    var nameWithDescription: String { get }
    var voiceLanguageCode: String? { get }
    var flagName: String { get }
}

// Languages with parameters
protocol English: Language {
    var useAndAfterHundred: Bool { get set }
}
protocol German: Language {
    var capitalisation: Bool { get set }
}
protocol Vietnamese: Language {
    var thousand: VietnameseImpl.Thousand { get set }
    var secondLast: VietnameseImpl.SecondLast { get set }
    var compact: Bool { get set }
}
protocol Spanish: Language {
    var puntoComma: SpanishImpl.PuntoComma { get set }
}
