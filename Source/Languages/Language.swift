//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/30/23.
//

import Foundation
import AVFoundation

protocol Language {
    func read(_ numberString: String) -> String
    func read(_ i: Int) -> String
    func readAloud(_ text: String)
    var name: String { get }
    var nameDescription: String? { get }
    var voiceLanguageCode: String? { get }
    var flagName: String { get }
    var voice: AVSpeechSynthesisVoice? { get set }
    var synthesizer: AVSpeechSynthesizer? { get }
}

// Languages with parameters
protocol English: Language {
    var useAndAfterHundred: Bool { get set }
}
protocol German: Language {
    var capitalisation: Bool { get set }
    var useWordSplitter: Bool { get set }
}
protocol Vietnamese: Language {
    var thousand: VietnameseImpl.Thousand { get set }
    var secondLast: VietnameseImpl.SecondLast { get set }
    var compact: Bool { get set }
}
protocol Spanish: Language {
    var puntoComma: SpanishImpl.PuntoComma { get set }
}
