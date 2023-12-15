//
//  Test_Automatic_Swedish.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticSwedish: XCTestCase {

    func test_automatic_swedish() {
        let swedish = TranslateSwedish()
        swedish.groupSeparator = ""
        swedish.decimalSeparator = "."
        XCTAssertEqual(swedish.translate(0), "noll")
        XCTAssertEqual(swedish.translate(1), "ett")
        XCTAssertEqual(swedish.translate(2), "två")
        XCTAssertEqual(swedish.translate(3), "tre")
        XCTAssertEqual(swedish.translate(4), "fyra")
        XCTAssertEqual(swedish.translate(5), "fem")
        XCTAssertEqual(swedish.translate(6), "sex")
        XCTAssertEqual(swedish.translate(7), "sju")
        XCTAssertEqual(swedish.translate(8), "åtta")
        XCTAssertEqual(swedish.translate(9), "nio")
        XCTAssertEqual(swedish.translate(10), "tio")
        XCTAssertEqual(swedish.translate(11), "elva")
        XCTAssertEqual(swedish.translate(12), "tolv")
        XCTAssertEqual(swedish.translate(13), "tretton")
        XCTAssertEqual(swedish.translate(14), "fjorton")
        XCTAssertEqual(swedish.translate(15), "femton")
        XCTAssertEqual(swedish.translate(16), "sexton")
        XCTAssertEqual(swedish.translate(17), "sjutton")
        XCTAssertEqual(swedish.translate(18), "arton")
        XCTAssertEqual(swedish.translate(19), "nitton")
        XCTAssertEqual(swedish.translate(20), "tjugo")
        XCTAssertEqual(swedish.translate(21), "tjugo")
        XCTAssertEqual(swedish.translate(22), "tjugotvå")
        XCTAssertEqual(swedish.translate(23), "tjugotre")
        XCTAssertEqual(swedish.translate(24), "tjugofyra")
        XCTAssertEqual(swedish.translate(25), "tjugofem")
        XCTAssertEqual(swedish.translate(26), "tjugoseks")
        XCTAssertEqual(swedish.translate(27), "tjugosju")
        XCTAssertEqual(swedish.translate(28), "tjugoåtta")
        XCTAssertEqual(swedish.translate(29), "tjugonio")
        XCTAssertEqual(swedish.translate(20), "tjugo")
        XCTAssertEqual(swedish.translate(31), "trettiotvå")
        XCTAssertEqual(swedish.translate(32), "trettiotvå")
        XCTAssertEqual(swedish.translate(33), "trettiotre")
        XCTAssertEqual(swedish.translate(34), "trettiofyra")
        XCTAssertEqual(swedish.translate(35), "trettiofem")
        XCTAssertEqual(swedish.translate(36), "trettiosex")
        XCTAssertEqual(swedish.translate(37), "trettiosju")
        XCTAssertEqual(swedish.translate(38), "trettioåtta")
        XCTAssertEqual(swedish.translate(39), "trettio-nio")
        XCTAssertEqual(swedish.translate(40), "fyrtio")
        XCTAssertEqual(swedish.translate(41), "fyrtio")
        XCTAssertEqual(swedish.translate(42), "fyrtiotvå")
        XCTAssertEqual(swedish.translate(43), "fyrtiotre")
        XCTAssertEqual(swedish.translate(44), "fyrtiofyra")
        XCTAssertEqual(swedish.translate(45), "fyrtiofem")
        XCTAssertEqual(swedish.translate(46), "fyrtiosex")
        XCTAssertEqual(swedish.translate(47), "fyrtiosju")
        XCTAssertEqual(swedish.translate(48), "fyrtioåtta")
        XCTAssertEqual(swedish.translate(49), "fyrtio-nio")
        XCTAssertEqual(swedish.translate(50), "femtio")
        XCTAssertEqual(swedish.translate(51), "femtiotvå")
        XCTAssertEqual(swedish.translate(52), "femtiotvå")
        XCTAssertEqual(swedish.translate(53), "femtiotre")
        XCTAssertEqual(swedish.translate(54), "femtiofyra")
        XCTAssertEqual(swedish.translate(55), "femtiofem")
        XCTAssertEqual(swedish.translate(56), "femtiosex")
        XCTAssertEqual(swedish.translate(57), "femtiosju")
        XCTAssertEqual(swedish.translate(58), "femtioåtta")
        XCTAssertEqual(swedish.translate(59), "femtio-nio")
        XCTAssertEqual(swedish.translate(60), "sextio")
        XCTAssertEqual(swedish.translate(61), "sextio")
        XCTAssertEqual(swedish.translate(62), "sextiotvå")
        XCTAssertEqual(swedish.translate(63), "sextiotre")
        XCTAssertEqual(swedish.translate(64), "sextiofyra")
        XCTAssertEqual(swedish.translate(65), "sextiofem")
        XCTAssertEqual(swedish.translate(66), "sextiosex")
        XCTAssertEqual(swedish.translate(67), "sextiosju")
        XCTAssertEqual(swedish.translate(68), "sextioåtta")
        XCTAssertEqual(swedish.translate(69), "sextio-nio")
        XCTAssertEqual(swedish.translate(70), "sjuttio")
        XCTAssertEqual(swedish.translate(71), "sjuttio")
        XCTAssertEqual(swedish.translate(72), "sjuttiotvå")
        XCTAssertEqual(swedish.translate(73), "sjuttiotre")
        XCTAssertEqual(swedish.translate(74), "sjuttiofyra")
        XCTAssertEqual(swedish.translate(75), "sjuttiofem")
        XCTAssertEqual(swedish.translate(76), "sjuttiosex")
        XCTAssertEqual(swedish.translate(77), "sjuttiosju")
        XCTAssertEqual(swedish.translate(78), "sjuttioåtta")
        XCTAssertEqual(swedish.translate(79), "sjuttio-nio")
        XCTAssertEqual(swedish.translate(80), "åttio")
        XCTAssertEqual(swedish.translate(81), "åttio")
        XCTAssertEqual(swedish.translate(82), "åttiotvå")
        XCTAssertEqual(swedish.translate(83), "åttio-tre")
        XCTAssertEqual(swedish.translate(84), "åttiofyra")
        XCTAssertEqual(swedish.translate(85), "åttiofem")
        XCTAssertEqual(swedish.translate(86), "åttiosex")
        XCTAssertEqual(swedish.translate(87), "åttiosju")
        XCTAssertEqual(swedish.translate(88), "åttioåtta")
        XCTAssertEqual(swedish.translate(89), "åttio-nio")
        XCTAssertEqual(swedish.translate(90), "nittio")
        XCTAssertEqual(swedish.translate(91), "nittio")
        XCTAssertEqual(swedish.translate(92), "nittiotvå")
        XCTAssertEqual(swedish.translate(93), "nittiotre")
        XCTAssertEqual(swedish.translate(94), "nittifyra")
        XCTAssertEqual(swedish.translate(95), "nittifem")
        XCTAssertEqual(swedish.translate(96), "nittiosex")
        XCTAssertEqual(swedish.translate(97), "nittiosju")
        XCTAssertEqual(swedish.translate(98), "nittioåtta")
        XCTAssertEqual(swedish.translate(99), "nittionio")
        XCTAssertEqual(swedish.translate(100), "hundra")
        XCTAssertEqual(swedish.translate(101), "hundraen")
        XCTAssertEqual(swedish.translate(102), "hundratvå")
        XCTAssertEqual(swedish.translate(103), "hundratre")
        XCTAssertEqual(swedish.translate(104), "hundrafyra")
        XCTAssertEqual(swedish.translate(105), "hundrafem")
        XCTAssertEqual(swedish.translate(106), "hundrasex")
        XCTAssertEqual(swedish.translate(107), "hundrasju")
        XCTAssertEqual(swedish.translate(108), "hundraåtta")
        XCTAssertEqual(swedish.translate(109), "hundranio")
        XCTAssertEqual(swedish.translate(110), "hundratio")
        XCTAssertEqual(swedish.translate(111), "hundraelva")
        XCTAssertEqual(swedish.translate(112), "hundratolv")
        XCTAssertEqual(swedish.translate(113), "hundratretton")
        XCTAssertEqual(swedish.translate(119), "hundranitton")
        XCTAssertEqual(swedish.translate(120), "hundratjugo")
        XCTAssertEqual(swedish.translate(121), "hundratjugo")
        XCTAssertEqual(swedish.translate(190), "hundranittio")
        XCTAssertEqual(swedish.translate(444), "fyrahundrafyrtiofyra")
        XCTAssertEqual(swedish.translate(999), "niohundranittionio")
        XCTAssertEqual(swedish.translate(1_000), "tusen")
        XCTAssertEqual(swedish.translate(1_001), "entusen")
        XCTAssertEqual(swedish.translate(1_005), "tusenfem")
        XCTAssertEqual(swedish.translate(1_009), "etttusennio")
        XCTAssertEqual(swedish.translate(1_010), "tusentio")
        XCTAssertEqual(swedish.translate(1_011), "entusenelva")
        XCTAssertEqual(swedish.translate(1_012), "tusentolv")
        XCTAssertEqual(swedish.translate(1_015), "tusenfemton")
        XCTAssertEqual(swedish.translate(1_035), "etttusentrettiofem")
        XCTAssertEqual(swedish.translate(1_099), "etttusennittionio")
        XCTAssertEqual(swedish.translate(1_100), "etttusenhundra")
        XCTAssertEqual(swedish.translate(1_101), "etttusenhundraen")
        XCTAssertEqual(swedish.translate(1_105), "etttusenhundrafem")
        XCTAssertEqual(swedish.translate(1_110), "etttusenhundratio")
        XCTAssertEqual(swedish.translate(1_111), "etttusenhundraelva")
        XCTAssertEqual(swedish.translate(1_115), "etttusenhundrafemton")
        XCTAssertEqual(swedish.translate(1_121), "etttusenhundratjugo")
        XCTAssertEqual(swedish.translate(1_125), "etttusenhundratjugofem")
        XCTAssertEqual(swedish.translate(10_000), "tiotusen")
        XCTAssertEqual(swedish.translate(10_001), "tiotusenen")
        XCTAssertEqual(swedish.translate(20_001), "tjugotusenen")
        XCTAssertEqual(swedish.translate(20_010), "tjugotusentio")
        XCTAssertEqual(swedish.translate(20_101), "tjugotusenhundraen")
        XCTAssertEqual(swedish.translate(201_001), "tvåhundratusenen")
        XCTAssertEqual(swedish.translate(502_305), "femhundratvåtusentrehundrafem")
        XCTAssertEqual(swedish.translate(999_999), "niohundranittioniotusenniohundranittionio")
        XCTAssertEqual(swedish.translate(62_000_000), "sextiotvåmiljoner")
        XCTAssertEqual(swedish.translate(62_003_005), "sextiotvåmiljonertretusenfem")
        XCTAssertEqual(swedish.translate(62_003_105), "sextiotvåmiljonertretusenhundrafem")
        XCTAssertEqual(swedish.translate(62_003_155), "sextiotvåmiljonertretusenhundrafemtiofem")
        XCTAssertEqual(swedish.translate(99_000_000_909), "nittioniomiljarderniohundranio")
        XCTAssertEqual(swedish.translate(99_999_999_999), "nittioniomiljarderniohundranittioniomiljonerniohundranittioniotusenniohundranittionio")
        XCTAssertEqual(swedish.translate(-1), "minusen")
        XCTAssertEqual(swedish.translate(-1.5), "minusenpunktfem")
        XCTAssertEqual(swedish.translate(1.5), "enpunktfem")
        XCTAssertEqual(swedish.translate(3.1415926), "trepunktenfyraenfemniotvåsex")
        XCTAssertEqual(swedish.translate(-3.1415926), "minustrepunktenfyraenfemniotvåsex")
        XCTAssertEqual(swedish.translate(3.4E13), "trepunktfyragångertiotilltrettonkraft")
        }
}