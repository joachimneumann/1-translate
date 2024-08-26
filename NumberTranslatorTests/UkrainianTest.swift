// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest
import NumberTranslator

final class Test_Ukrainian: XCTestCase {
    let language = UkrainianImplementation()
    func testUkrainian() {
        // https: www.omniglot.com/language/numbers/ukrainian.htm
        XCTAssertEqual(language.translate(0).x, "нуль")
        XCTAssertEqual(language.translate(1).x, "один")
        XCTAssertEqual(language.translate(2).x, "два")
        XCTAssertEqual(language.translate(3).x, "три")
        XCTAssertEqual(language.translate(4).x, "чотири")
        XCTAssertEqual(language.translate(5).x, "п'ять")
        XCTAssertEqual(language.translate(6).x, "шість")
        XCTAssertEqual(language.translate(7).x, "сім")
        XCTAssertEqual(language.translate(8).x, "вісім")
        XCTAssertEqual(language.translate(9).x, "дев'ять")
        XCTAssertEqual(language.translate(10).x, "десять")
        XCTAssertEqual(language.translate(11).x, "одинадцять")
        XCTAssertEqual(language.translate(12).x, "дванадцять")
        XCTAssertEqual(language.translate(13).x, "тринадцять")
        XCTAssertEqual(language.translate(14).x, "чотирнадцять")
        XCTAssertEqual(language.translate(15).x, "п'ятнадцять")
        XCTAssertEqual(language.translate(16).x, "шістнадцять")
        XCTAssertEqual(language.translate(17).x, "сімнадцять")
        XCTAssertEqual(language.translate(18).x, "вісімнадцять")
        XCTAssertEqual(language.translate(19).x, "дев'ятнадцять")
        XCTAssertEqual(language.translate(20).x, "двадцять")
        XCTAssertEqual(language.translate(30).x, "тридцять")
        XCTAssertEqual(language.translate(40).x, "сорок")
        XCTAssertEqual(language.translate(50).x, "п'ятдесят") // or? п'ятдеся
        XCTAssertEqual(language.translate(60).x, "шістдесят")
        XCTAssertEqual(language.translate(70).x, "сімдесят")
        XCTAssertEqual(language.translate(80).x, "вісімдесят")
        XCTAssertEqual(language.translate(90).x, "дев'яносто")
        XCTAssertEqual(language.translate(100).x, "сто")
        XCTAssertEqual(language.translate(1000).x, "тисяча")
        // translated from russian
        XCTAssertEqual(language.translate(0).x, "нуль")
        XCTAssertEqual(language.translate(1).x, "один")
        XCTAssertEqual(language.translate(2).x, "два")
        XCTAssertEqual(language.translate(3).x, "три")
        XCTAssertEqual(language.translate(4).x, "чотири")
        XCTAssertEqual(language.translate(5).x, "п'ять")
        XCTAssertEqual(language.translate(6).x, "шість")
        XCTAssertEqual(language.translate(7).x, "сім")
        XCTAssertEqual(language.translate(8).x, "вісім")
        XCTAssertEqual(language.translate(9).x, "дев'ять")
        XCTAssertEqual(language.translate(10).x, "десять")
        XCTAssertEqual(language.translate(11).x, "одинадцять")
        XCTAssertEqual(language.translate(12).x, "дванадцять")
        XCTAssertEqual(language.translate(13).x, "тринадцять")
        XCTAssertEqual(language.translate(14).x, "чотирнадцять")
        XCTAssertEqual(language.translate(15).x, "п'ятнадцять")
        XCTAssertEqual(language.translate(16).x, "шістнадцять")
        XCTAssertEqual(language.translate(17).x, "сімнадцять")
        XCTAssertEqual(language.translate(18).x, "вісімнадцять")
        XCTAssertEqual(language.translate(19).x, "дев'ятнадцять")
        XCTAssertEqual(language.translate(20).x, "двадцять")
        XCTAssertEqual(language.translate(23).x, "двадцять три")
        XCTAssertEqual(language.translate(30).x, "тридцять")
        XCTAssertEqual(language.translate(33).x, "тридцять три")
        XCTAssertEqual(language.translate(40).x, "сорок")
        XCTAssertEqual(language.translate(50).x, "п'ятдесят")
        XCTAssertEqual(language.translate(60).x, "шістдесят")
        XCTAssertEqual(language.translate(70).x, "сімдесят")
        XCTAssertEqual(language.translate(80).x, "вісімдесят")
        XCTAssertEqual(language.translate(90).x, "дев'яносто")
        XCTAssertEqual(language.translate(100).x, "сто")
        XCTAssertEqual(language.translate(101).x, "сто один")
        XCTAssertEqual(language.translate(111).x, "сто одинадцять")
        XCTAssertEqual(language.translate(131).x, "сто тридцять один")
        XCTAssertEqual(language.translate(200).x, "двісті")
        XCTAssertEqual(language.translate(245).x, "двісті сорок п'ять")
        XCTAssertEqual(language.translate(300).x, "триста")
        XCTAssertEqual(language.translate(375).x, "триста сімдесят п'ять")
        XCTAssertEqual(language.translate(400).x, "чотириста")
        XCTAssertEqual(language.translate(500).x, "п'ятсот")
        XCTAssertEqual(language.translate(600).x, "шістсот")
        XCTAssertEqual(language.translate(700).x, "сімсот")
        XCTAssertEqual(language.translate(800).x, "вісімсот")
        XCTAssertEqual(language.translate(900).x, "дев'ятсот")
        XCTAssertEqual(language.translate(999).x, "дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.translate(1_000).x, "тисяча")
        XCTAssertEqual(language.translate(1_348).x, "тисяча триста сорок вісім")
        XCTAssertEqual(language.translate(1_534).x, "тисяча п'ятсот тридцять чотири")
        XCTAssertEqual(language.translate(2_000).x, "дві тисячі")
        XCTAssertEqual(language.translate(2_345).x, "дві тисячі триста сорок п'ять")
        XCTAssertEqual(language.translate(3_000).x, "три тисячі")
        XCTAssertEqual(language.translate(4_000).x, "чотири тисячі")
        XCTAssertEqual(language.translate(5_000).x, "п'ять тисяч")
        XCTAssertEqual(language.translate(6_000).x, "шість тисяч")
        XCTAssertEqual(language.translate(7_000).x, "сім тисяч")
        XCTAssertEqual(language.translate(8_000).x, "вісім тисяч")
        XCTAssertEqual(language.translate(8_343).x, "вісім тисяч триста сорок три")
        XCTAssertEqual(language.translate(9_000).x, "дев'ять тисяч")
        XCTAssertEqual(language.translate(9_203).x, "дев'ять тисяч двісті три")
        XCTAssertEqual(language.translate(9_999).x, "дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.translate(10_000).x, "десять тисяч")
        XCTAssertEqual(language.translate(11_000).x, "одинадцять тисяч")
        XCTAssertEqual(language.translate(11_111).x, "одинадцять тисяч сто одинадцять")
        XCTAssertEqual(language.translate(12_000).x, "дванадцять тисяч")
        XCTAssertEqual(language.translate(19_000).x, "дев'ятнадцять тисяч")
        XCTAssertEqual(language.translate(20_000).x, "двадцять тисяч")
        XCTAssertEqual(language.translate(21_000).x, "двадцять одна тисяча")
        XCTAssertEqual(language.translate(22_000).x, "двадцять дві тисячі")
        XCTAssertEqual(language.translate(23_000).x, "двадцять три тисячі")
        XCTAssertEqual(language.translate(24_000).x, "двадцять чотири тисячі")
        XCTAssertEqual(language.translate(25_000).x, "двадцять п'ять тисяч")
        XCTAssertEqual(language.translate(23_456).x, "двадцять три тисячі чотириста п'ятдесят шість")
        XCTAssertEqual(language.translate(41_000).x, "сорок одна тисяча")
        XCTAssertEqual(language.translate(99_999).x, "дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.translate(100_000).x, "сто тисяч")
        XCTAssertEqual(language.translate(101_000).x, "сто одна тисяча")
        XCTAssertEqual(language.translate(101_111).x, "сто одна тисяча сто одинадцять") // ? сто тисяча сто одинадцять
        XCTAssertEqual(language.translate(234_567).x, "двісті тридцять чотири тисячі п'ятсот шістдесят сім")
        XCTAssertEqual(language.translate(243_382).x, "двісті сорок три тисячі триста вісімдесят два")
        XCTAssertEqual(language.translate(999_999).x, "дев'ятсот дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.translate(1_000_000).x, "один мільйон")
        XCTAssertEqual(language.translate(2_000_000).x, "два мільйони")
        XCTAssertEqual(language.translate(3_000_000).x, "три мільйони")
        XCTAssertEqual(language.translate(4_000_000).x, "чотири мільйони")
        XCTAssertEqual(language.translate(5_000_000).x, "п'ять мільйонів")
        XCTAssertEqual(language.translate(6_000_000).x, "шість мільйонів")
        XCTAssertEqual(language.translate(7_000_000).x, "сім мільйонів")
        XCTAssertEqual(language.translate(8_000_000).x, "вісім мільйонів")
        XCTAssertEqual(language.translate(101_000_000).x, "сто один мільйон")
        XCTAssertEqual(language.translate(101_101_111).x, "сто один мільйон сто одна тисяча сто одинадцять")
        XCTAssertEqual(language.translate(234_567_890).x, "двісті тридцять чотири мільйони п'ятсот шістдесят сім тисяч вісімсот дев'яносто")
        XCTAssertEqual(language.translate(999_999_999).x, "дев'ятсот дев'яносто дев'ять мільйонів дев'ятсот дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.translate(1_000_000_000).x, "один мільярд")
        XCTAssertEqual(language.translate(2_000_000_000).x, "два мільярди")
        XCTAssertEqual(language.translate(10_000_000_000).x, "десять мільярдів")
        XCTAssertEqual(language.translate(1_000_000_000_000).x, "один трильйон")
        XCTAssertEqual(language.translate(2_000_000_000_000).x, "два трильйони")
        XCTAssertEqual(language.translate(10_000_000_000_000).x, "десять трильйонів")
    }
}
