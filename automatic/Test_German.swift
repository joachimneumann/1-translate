//
//  Test_German.swift
//
//  Created by automatic.py
//

import XCTest

final class TestGerman: XCTestCase {

    func test_german() {
        let german = TranslateGerman()
        german.useSoftHyphen = false
        german.capitalisation = false
        german.groupSeparator = ""
        german.decimalSeparator = "."
        XCTAssertEqual(german.translate(0), "null")
        XCTAssertEqual(german.translate(1), "eins")
        XCTAssertEqual(german.translate(2), "zwei")
        XCTAssertEqual(german.translate(3), "drei")
        XCTAssertEqual(german.translate(4), "vier")
        XCTAssertEqual(german.translate(5), "fünf")
        XCTAssertEqual(german.translate(6), "sechs")
        XCTAssertEqual(german.translate(7), "sieben")
        XCTAssertEqual(german.translate(8), "acht")
        XCTAssertEqual(german.translate(9), "neun")
        XCTAssertEqual(german.translate(10), "zehn")
        XCTAssertEqual(german.translate(11), "elf")
        XCTAssertEqual(german.translate(12), "zwölf")
        XCTAssertEqual(german.translate(13), "dreizehn")
        XCTAssertEqual(german.translate(14), "vierzehn")
        XCTAssertEqual(german.translate(15), "fünfzehn")
        XCTAssertEqual(german.translate(16), "sechzehn")
        XCTAssertEqual(german.translate(17), "siebzehn")
        XCTAssertEqual(german.translate(18), "achtzehn")
        XCTAssertEqual(german.translate(19), "neunzehn")
        XCTAssertEqual(german.translate(20), "zwanzig")
        XCTAssertEqual(german.translate(21), "einundzwanzig")
        XCTAssertEqual(german.translate(24), "vierundzwanzig")
        XCTAssertEqual(german.translate(25), "fünfundzwanzig")
        XCTAssertEqual(german.translate(27), "siebenundzwanzig")
        XCTAssertEqual(german.translate(28), "achtundzwanzig")
        XCTAssertEqual(german.translate(29), "neunundzwanzig")
        XCTAssertEqual(german.translate(20), "zwanzig")
        XCTAssertEqual(german.translate(31), "einunddreißig")
        XCTAssertEqual(german.translate(32), "zweiunddreißig")
        XCTAssertEqual(german.translate(33), "dreiunddreißig")
        XCTAssertEqual(german.translate(34), "vierunddreißig")
        XCTAssertEqual(german.translate(35), "fünfunddreißig")
        XCTAssertEqual(german.translate(36), "sechsunddreißig")
        XCTAssertEqual(german.translate(37), "siebenunddreißig")
        XCTAssertEqual(german.translate(38), "achtunddreißig")
        XCTAssertEqual(german.translate(39), "neununddreißig")
        XCTAssertEqual(german.translate(40), "vierzig")
        XCTAssertEqual(german.translate(41), "einundvierzig")
        XCTAssertEqual(german.translate(42), "zweiundvierzig")
        XCTAssertEqual(german.translate(43), "dreiundvierzig")
        XCTAssertEqual(german.translate(44), "vierundvierzig")
        XCTAssertEqual(german.translate(45), "fünfundvierzig")
        XCTAssertEqual(german.translate(46), "sechsundvierzig")
        XCTAssertEqual(german.translate(47), "siebenundvierzig")
        XCTAssertEqual(german.translate(48), "achtundvierzig")
        XCTAssertEqual(german.translate(49), "neunundvierzig")
        XCTAssertEqual(german.translate(50), "fünfzig")
        XCTAssertEqual(german.translate(51), "einundfünfzig")
        XCTAssertEqual(german.translate(52), "zweiundfünfzig")
        XCTAssertEqual(german.translate(53), "dreiundfünfzig")
        XCTAssertEqual(german.translate(54), "vierundfünfzig")
        XCTAssertEqual(german.translate(55), "fünfundfünfzig")
        XCTAssertEqual(german.translate(56), "sechsundfünfzig")
        XCTAssertEqual(german.translate(57), "siebenundfünfzig")
        XCTAssertEqual(german.translate(58), "achtundfünfzig")
        XCTAssertEqual(german.translate(59), "neunundfünfzig")
        XCTAssertEqual(german.translate(60), "sechzig")
        XCTAssertEqual(german.translate(61), "einundsechzig")
        XCTAssertEqual(german.translate(62), "zweiundsechzig")
        XCTAssertEqual(german.translate(63), "dreiundsechzig")
        XCTAssertEqual(german.translate(64), "vierundsechzig")
        XCTAssertEqual(german.translate(65), "fünfundsechzig")
        XCTAssertEqual(german.translate(66), "sechsundsechzig")
        XCTAssertEqual(german.translate(67), "siebenundsechzig")
        XCTAssertEqual(german.translate(68), "achtundsechzig")
        XCTAssertEqual(german.translate(69), "neunundsechzig")
        XCTAssertEqual(german.translate(70), "siebzig")
        XCTAssertEqual(german.translate(71), "einundsiebzig")
        XCTAssertEqual(german.translate(72), "zweiundsiebzig")
        XCTAssertEqual(german.translate(73), "dreiundsiebzig")
        XCTAssertEqual(german.translate(74), "vierundsiebzig")
        XCTAssertEqual(german.translate(75), "fünfundsiebzig")
        XCTAssertEqual(german.translate(76), "sechsundsiebzig")
        XCTAssertEqual(german.translate(77), "siebenundsiebzig")
        XCTAssertEqual(german.translate(78), "achtundsiebzig")
        XCTAssertEqual(german.translate(79), "neunundsiebzig")
        XCTAssertEqual(german.translate(80), "achtzig")
        XCTAssertEqual(german.translate(81), "einundachtzig")
        XCTAssertEqual(german.translate(82), "zweiundachtzig")
        XCTAssertEqual(german.translate(83), "dreiundachtzig")
        XCTAssertEqual(german.translate(84), "vierundachtzig")
        XCTAssertEqual(german.translate(85), "fünfundachtzig")
        XCTAssertEqual(german.translate(86), "sechsundachtzig")
        XCTAssertEqual(german.translate(87), "siebenundachtzig")
        XCTAssertEqual(german.translate(88), "achtundachtzig")
        XCTAssertEqual(german.translate(89), "neunundachtzig")
        XCTAssertEqual(german.translate(90), "neunzig")
        XCTAssertEqual(german.translate(91), "einundneunzig")
        XCTAssertEqual(german.translate(92), "zweiundneunzig")
        XCTAssertEqual(german.translate(93), "dreiundneunzig")
        XCTAssertEqual(german.translate(94), "vierundneunzig")
        XCTAssertEqual(german.translate(95), "fünfundneunzig")
        XCTAssertEqual(german.translate(96), "sechsundneunzig")
        XCTAssertEqual(german.translate(97), "siebenundneunzig")
        XCTAssertEqual(german.translate(98), "achtundneunzig")
        XCTAssertEqual(german.translate(99), "neunundneunzig")
        XCTAssertEqual(german.translate(100), "einhundert")
        XCTAssertEqual(german.translate(101), "einhunderteins")
        XCTAssertEqual(german.translate(102), "einhundertzwei")
        XCTAssertEqual(german.translate(103), "einhundertdrei")
        XCTAssertEqual(german.translate(104), "einhundertvier")
        XCTAssertEqual(german.translate(105), "einhundertfünf")
        XCTAssertEqual(german.translate(106), "einhundertsechs")
        XCTAssertEqual(german.translate(107), "einhundertsieben")
        XCTAssertEqual(german.translate(108), "einhundertacht")
        XCTAssertEqual(german.translate(109), "einhundertneun")
        XCTAssertEqual(german.translate(110), "einhundertzehn")
        XCTAssertEqual(german.translate(111), "einhundertelf")
        XCTAssertEqual(german.translate(112), "einhundertzwölf")
        XCTAssertEqual(german.translate(113), "einhundertdreizehn")
        XCTAssertEqual(german.translate(119), "einhundertneunzehn")
        XCTAssertEqual(german.translate(120), "einhundertzwanzig")
        XCTAssertEqual(german.translate(121), "einhunderteinundzwanzig")
        XCTAssertEqual(german.translate(144), "einhundertvierundvierzig")
        XCTAssertEqual(german.translate(157), "einhundertsiebenundfünfzig")
        XCTAssertEqual(german.translate(190), "einhundertneunzig")
        XCTAssertEqual(german.translate(198), "einhundertachtundneunzig")
        XCTAssertEqual(german.translate(200), "zweihundert")
        XCTAssertEqual(german.translate(212), "zweihundertzwölf")
        XCTAssertEqual(german.translate(222), "zweihundertzweiundzwanzig")
        XCTAssertEqual(german.translate(300), "dreihundert")
        XCTAssertEqual(german.translate(331), "dreihunderteinunddreißig")
        XCTAssertEqual(german.translate(367), "dreihundertsiebenundsechzig")
        XCTAssertEqual(german.translate(400), "vierhundert")
        XCTAssertEqual(german.translate(444), "vierhundertvierundvierzig")
        XCTAssertEqual(german.translate(448), "vierhundertachtundvierzig")
        XCTAssertEqual(german.translate(500), "fünfhundert")
        XCTAssertEqual(german.translate(555), "fünfhundertfünfundfünfzig")
        XCTAssertEqual(german.translate(599), "fünfhundertneunundneunzig")
        XCTAssertEqual(german.translate(600), "sechshundert")
        XCTAssertEqual(german.translate(648), "sechshundertachtundvierzig")
        XCTAssertEqual(german.translate(650), "sechshundertfünfzig")
        XCTAssertEqual(german.translate(700), "siebenhundert")
        XCTAssertEqual(german.translate(717), "siebenhundertsiebzehn")
        XCTAssertEqual(german.translate(789), "siebenhundertneunundachtzig")
        XCTAssertEqual(german.translate(800), "achthundert")
        XCTAssertEqual(german.translate(811), "achthundertelf")
        XCTAssertEqual(german.translate(838), "achthundertachtunddreißig")
        XCTAssertEqual(german.translate(900), "neunhundert")
        XCTAssertEqual(german.translate(919), "neunhundertneunzehn")
        XCTAssertEqual(german.translate(955), "neunhundertfünfundfünfzig")
        XCTAssertEqual(german.translate(999), "neunhundertneunundneunzig")
        XCTAssertEqual(german.translate(1_000), "eintausend")
        XCTAssertEqual(german.translate(1_001), "eintausendeins")
        XCTAssertEqual(german.translate(1_005), "eintausendfünf")
        XCTAssertEqual(german.translate(1_009), "eintausendneun")
        XCTAssertEqual(german.translate(1_010), "eintausendzehn")
        XCTAssertEqual(german.translate(1_011), "eintausendelf")
        XCTAssertEqual(german.translate(1_012), "eintausendzwölf")
        XCTAssertEqual(german.translate(1_015), "eintausendfünfzehn")
        XCTAssertEqual(german.translate(1_035), "eintausendfünfunddreißig")
        XCTAssertEqual(german.translate(1_099), "eintausendneunundneunzig")
        XCTAssertEqual(german.translate(1_100), "eintausendeinhundert")
        XCTAssertEqual(german.translate(1_101), "eintausendeinhunderteins")
        XCTAssertEqual(german.translate(1_105), "eintausendeinhundertfünf")
        XCTAssertEqual(german.translate(1_110), "eintausendeinhundertzehn")
        XCTAssertEqual(german.translate(1_111), "eintausendeinhundertelf")
        XCTAssertEqual(german.translate(1_115), "eintausendeinhundertfünfzehn")
        XCTAssertEqual(german.translate(1_121), "eintausendeinhunderteinundzwanzig")
        XCTAssertEqual(german.translate(1_125), "eintausendeinhundertfünfundzwanzig")
        XCTAssertEqual(german.translate(2_000), "zweitausend")
        XCTAssertEqual(german.translate(3_000), "dreitausend")
        XCTAssertEqual(german.translate(3_001), "dreitausendeins")
        XCTAssertEqual(german.translate(5_555), "fünftausendfünfhundertfünfundfünfzig")
        XCTAssertEqual(german.translate(6_000), "sechstausend")
        XCTAssertEqual(german.translate(6_001), "sechstausendeins")
        XCTAssertEqual(german.translate(10_000), "zehntausend")
        XCTAssertEqual(german.translate(10_001), "zehntausendeins")
        XCTAssertEqual(german.translate(11_001), "elftausendeins")
        XCTAssertEqual(german.translate(12_895), "zwölftausendachthundertfünfundneunzig")
        XCTAssertEqual(german.translate(12_786), "zwölftausendsiebenhundertsechsundachtzig")
        XCTAssertEqual(german.translate(20_001), "zwanzigtausendeins")
        XCTAssertEqual(german.translate(20_010), "zwanzigtausendzehn")
        XCTAssertEqual(german.translate(20_101), "zwanzigtausendeinhunderteins")
        XCTAssertEqual(german.translate(70_000), "siebzigtausend")
        XCTAssertEqual(german.translate(100_000), "einhunderttausend")
        XCTAssertEqual(german.translate(187_372), "einhundertsiebenundachtzigtausenddreihundertzweiundsiebzig")
        XCTAssertEqual(german.translate(200_000), "zweihunderttausend")
        XCTAssertEqual(german.translate(201_001), "zweihunderteintausendeins")
        XCTAssertEqual(german.translate(280_065), "zweihundertachtzigtausendfünfundsechzig")
        XCTAssertEqual(german.translate(502_305), "fünfhundertzweitausenddreihundertfünf")
        XCTAssertEqual(german.translate(706_210), "siebenhundertsechstausendzweihundertzehn")
        XCTAssertEqual(german.translate(999_999), "neunhundertneunundneunzigtausendneunhundertneunundneunzig")
        XCTAssertEqual(german.translate(1_000_000), "eine Million")
        XCTAssertEqual(german.translate(3_000_100), "drei Millionen einhundert")
        XCTAssertEqual(german.translate(1_000_050), "eine Million fünfzig")
        XCTAssertEqual(german.translate(10_000_000), "zehn Millionen")
        XCTAssertEqual(german.translate(40_000_000), "vierzig Millionen")
        XCTAssertEqual(german.translate(62_000_000), "zweiundsechzig Millionen")
        XCTAssertEqual(german.translate(62_003_005), "zweiundsechzig Millionen dreitausendfünf")
        XCTAssertEqual(german.translate(62_003_105), "zweiundsechzig Millionen dreitausendeinhundertfünf")
        XCTAssertEqual(german.translate(62_003_155), "zweiundsechzig Millionen dreitausendeinhundertfünfundfünfzig")
        XCTAssertEqual(german.translate(99_999_999), "neunundneunzig Millionen neunhundertneunundneunzigtausendneunhundertneunundneunzig")
        XCTAssertEqual(german.translate(100_000_000), "einhundert Millionen")
        XCTAssertEqual(german.translate(500_000_000), "fünfhundert Millionen")
        XCTAssertEqual(german.translate(1_000_000_000), "eine Milliarde")
        XCTAssertEqual(german.translate(1_000_000_200), "eine Milliarde zweihundert")
        XCTAssertEqual(german.translate(10_000_000_000), "zehn Milliarden")
        XCTAssertEqual(german.translate(20_000_000_700), "zwanzig Milliarden siebenhundert")
        XCTAssertEqual(german.translate(99_000_000_909), "neunundneunzig Milliarden neunhundertneun")
        XCTAssertEqual(german.translate(100_000_000_000), "einhundert Milliarden")
        XCTAssertEqual(german.translate(400_000_000_000), "vierhundert Milliarden")
        XCTAssertEqual(german.translate(-1), "minus eins")
        XCTAssertEqual(german.translate(-1.5), "minus eins Komma fünf")
        XCTAssertEqual(german.translate(-1.51), "minus eins Komma fünf eins")
        XCTAssertEqual(german.translate(-0.7), "minus null Komma sieben")
        XCTAssertEqual(german.translate(1.5), "eins Komma fünf")
        XCTAssertEqual(german.translate(3.1415926), "drei Komma eins vier eins fünf neun zwei sechs")
        XCTAssertEqual(german.translate(-3.1415926), "minus drei Komma eins vier eins fünf neun zwei sechs")
        XCTAssertEqual(german.translate(-74), "minus vierundsiebzig")
        XCTAssertEqual(german.translate(-1_000_000), "minus eine Million")
        XCTAssertEqual(german.translate(3.4e22), "drei Komma vier mal zehn hoch zweiundzwanzig")
    }
}
