// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest

final class Test_ukrainian: XCTestCase {

    let language = Languages().ukrainian

    func test_ukrainian() {
        // https: www.omniglot.com/language/numbers/ukrainian.htm
        XCTAssertEqual(language.read(0).x, "нуль")
        XCTAssertEqual(language.read(1).x, "один")
        XCTAssertEqual(language.read(2).x, "два")
        XCTAssertEqual(language.read(3).x, "три")
        XCTAssertEqual(language.read(4).x, "чотири")
        XCTAssertEqual(language.read(5).x, "п'ять")
        XCTAssertEqual(language.read(6).x, "шість")
        XCTAssertEqual(language.read(7).x, "сім")
        XCTAssertEqual(language.read(8).x, "вісім")
        XCTAssertEqual(language.read(9).x, "дев'ять")
        XCTAssertEqual(language.read(10).x, "десять")
        XCTAssertEqual(language.read(11).x, "одинадцять")
        XCTAssertEqual(language.read(12).x, "дванадцять")
        XCTAssertEqual(language.read(13).x, "тринадцять")
        XCTAssertEqual(language.read(14).x, "чотирнадцять")
        XCTAssertEqual(language.read(15).x, "п'ятнадцять")
        XCTAssertEqual(language.read(16).x, "шістнадцять")
        XCTAssertEqual(language.read(17).x, "сімнадцять")
        XCTAssertEqual(language.read(18).x, "вісімнадцять")
        XCTAssertEqual(language.read(19).x, "дев'ятнадцять")
        XCTAssertEqual(language.read(20).x, "двадцять")
        XCTAssertEqual(language.read(30).x, "тридцять")
        XCTAssertEqual(language.read(40).x, "сорок")
        XCTAssertEqual(language.read(50).x, "п'ятдесят") // or? п'ятдеся
        XCTAssertEqual(language.read(60).x, "шістдесят")
        XCTAssertEqual(language.read(70).x, "сімдесят")
        XCTAssertEqual(language.read(80).x, "вісімдесят")
        XCTAssertEqual(language.read(90).x, "дев'яносто")
        XCTAssertEqual(language.read(100).x, "сто")
        XCTAssertEqual(language.read(1000).x, "тисяча")
        // translated from russian
        XCTAssertEqual(language.read(0).x, "нуль")
        XCTAssertEqual(language.read(1).x, "один")
        XCTAssertEqual(language.read(2).x, "два")
        XCTAssertEqual(language.read(3).x, "три")
        XCTAssertEqual(language.read(4).x, "чотири")
        XCTAssertEqual(language.read(5).x, "п'ять")
        XCTAssertEqual(language.read(6).x, "шість")
        XCTAssertEqual(language.read(7).x, "сім")
        XCTAssertEqual(language.read(8).x, "вісім")
        XCTAssertEqual(language.read(9).x, "дев'ять")
        XCTAssertEqual(language.read(10).x, "десять")
        XCTAssertEqual(language.read(11).x, "одинадцять")
        XCTAssertEqual(language.read(12).x, "дванадцять")
        XCTAssertEqual(language.read(13).x, "тринадцять")
        XCTAssertEqual(language.read(14).x, "чотирнадцять")
        XCTAssertEqual(language.read(15).x, "п'ятнадцять")
        XCTAssertEqual(language.read(16).x, "шістнадцять")
        XCTAssertEqual(language.read(17).x, "сімнадцять")
        XCTAssertEqual(language.read(18).x, "вісімнадцять")
        XCTAssertEqual(language.read(19).x, "дев'ятнадцять")
        XCTAssertEqual(language.read(20).x, "двадцять")
        XCTAssertEqual(language.read(23).x, "двадцять три")
        XCTAssertEqual(language.read(30).x, "тридцять")
        XCTAssertEqual(language.read(33).x, "тридцять три")
        XCTAssertEqual(language.read(40).x, "сорок")
        XCTAssertEqual(language.read(50).x, "п'ятдесят")
        XCTAssertEqual(language.read(60).x, "шістдесят")
        XCTAssertEqual(language.read(70).x, "сімдесят")
        XCTAssertEqual(language.read(80).x, "вісімдесят")
        XCTAssertEqual(language.read(90).x, "дев'яносто")
        XCTAssertEqual(language.read(100).x, "сто")
        XCTAssertEqual(language.read(101).x, "сто один")
        XCTAssertEqual(language.read(111).x, "сто одинадцять")
        XCTAssertEqual(language.read(131).x, "сто тридцять один")
        XCTAssertEqual(language.read(200).x, "двісті")
        XCTAssertEqual(language.read(245).x, "двісті сорок п'ять")
        XCTAssertEqual(language.read(300).x, "триста")
        XCTAssertEqual(language.read(375).x, "триста сімдесят п'ять")
        XCTAssertEqual(language.read(400).x, "чотириста")
        XCTAssertEqual(language.read(500).x, "п'ятсот")
        XCTAssertEqual(language.read(600).x, "шістсот")
        XCTAssertEqual(language.read(700).x, "сімсот")
        XCTAssertEqual(language.read(800).x, "вісімсот")
        XCTAssertEqual(language.read(900).x, "дев'ятсот")
        XCTAssertEqual(language.read(999).x, "дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.read(1_000).x, "тисяча")
        XCTAssertEqual(language.read(1_348).x, "тисяча триста сорок вісім")
        XCTAssertEqual(language.read(1_534).x, "тисяча п'ятсот тридцять чотири")
        XCTAssertEqual(language.read(2_000).x, "дві тисячі")
        XCTAssertEqual(language.read(2_345).x, "дві тисячі триста сорок п'ять")
        XCTAssertEqual(language.read(3_000).x, "три тисячі")
        XCTAssertEqual(language.read(4_000).x, "чотири тисячі")
        XCTAssertEqual(language.read(5_000).x, "п'ять тисяч")
        XCTAssertEqual(language.read(6_000).x, "шість тисяч")
        XCTAssertEqual(language.read(7_000).x, "сім тисяч")
        XCTAssertEqual(language.read(8_000).x, "вісім тисяч")
        XCTAssertEqual(language.read(8_343).x, "вісім тисяч триста сорок три")
        XCTAssertEqual(language.read(9_000).x, "дев'ять тисяч")
        XCTAssertEqual(language.read(9_203).x, "дев'ять тисяч двісті три")
        XCTAssertEqual(language.read(9_999).x, "дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.read(10_000).x, "десять тисяч")
        XCTAssertEqual(language.read(11_000).x, "одинадцять тисяч")
        XCTAssertEqual(language.read(11_111).x, "одинадцять тисяч сто одинадцять")
        XCTAssertEqual(language.read(12_000).x, "дванадцять тисяч")
        XCTAssertEqual(language.read(19_000).x, "дев'ятнадцять тисяч")
        XCTAssertEqual(language.read(20_000).x, "двадцять тисяч")
        XCTAssertEqual(language.read(21_000).x, "двадцять одна тисяча")
        XCTAssertEqual(language.read(22_000).x, "двадцять дві тисячі")
        XCTAssertEqual(language.read(23_000).x, "двадцять три тисячі")
        XCTAssertEqual(language.read(24_000).x, "двадцять чотири тисячі")
        XCTAssertEqual(language.read(25_000).x, "двадцять п'ять тисяч")
        XCTAssertEqual(language.read(23_456).x, "двадцять три тисячі чотириста п'ятдесят шість")
        XCTAssertEqual(language.read(41_000).x, "сорок одна тисяча")
        XCTAssertEqual(language.read(99_999).x, "дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.read(100_000).x, "сто тисяч")
        XCTAssertEqual(language.read(101_000).x, "сто одна тисяча")
        XCTAssertEqual(language.read(101_111).x, "сто одна тисяча сто одинадцять") // ? сто тисяча сто одинадцять
        XCTAssertEqual(language.read(234_567).x, "двісті тридцять чотири тисячі п'ятсот шістдесят сім")
        XCTAssertEqual(language.read(243_382).x, "двісті сорок три тисячі триста вісімдесят два")
        XCTAssertEqual(language.read(999_999).x, "дев'ятсот дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.read(1_000_000).x, "один мільйон")
        XCTAssertEqual(language.read(2_000_000).x, "два мільйони")
        XCTAssertEqual(language.read(3_000_000).x, "три мільйони")
        XCTAssertEqual(language.read(4_000_000).x, "чотири мільйони")
        XCTAssertEqual(language.read(5_000_000).x, "п'ять мільйонів")
        XCTAssertEqual(language.read(6_000_000).x, "шість мільйонів")
        XCTAssertEqual(language.read(7_000_000).x, "сім мільйонів")
        XCTAssertEqual(language.read(8_000_000).x, "вісім мільйонів")
        XCTAssertEqual(language.read(101_000_000).x, "сто один мільйон")
        XCTAssertEqual(language.read(101_101_111).x, "сто один мільйон сто одна тисяча сто одинадцять")
        XCTAssertEqual(language.read(234_567_890).x, "двісті тридцять чотири мільйони п'ятсот шістдесят сім тисяч вісімсот дев'яносто")
        XCTAssertEqual(language.read(999_999_999).x, "дев'ятсот дев'яносто дев'ять мільйонів дев'ятсот дев'яносто дев'ять тисяч дев'ятсот дев'яносто дев'ять")
        XCTAssertEqual(language.read(1_000_000_000).x, "один мільярд")
        XCTAssertEqual(language.read(2_000_000_000).x, "два мільярди")
        XCTAssertEqual(language.read(10_000_000_000).x, "десять мільярдів")
        XCTAssertEqual(language.read(1_000_000_000_000).x, "один трильйон")
        XCTAssertEqual(language.read(2_000_000_000_000).x, "два трильйони")
        XCTAssertEqual(language.read(10_000_000_000_000).x, "десять трильйонів")
    }
}
