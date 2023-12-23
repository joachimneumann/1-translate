//
// Test_Chinese.swift
// TranslateNumbers
//
// Created by), "Joachim Neumann on 12/18/23.
//

import XCTest

final class TestChinese: XCTestCase {
    let simplified = Chinese(variant: .simplified)
    let traditional = Chinese(variant: .traditional)
    let financial = Chinese(variant: .financial)
    override func setUpWithError() throws {
        simplified.groupSeparator = ""
        simplified.decimalSeparator = "."
        traditional.groupSeparator = ""
        traditional.decimalSeparator = "."
        financial.groupSeparator = ""
        financial.decimalSeparator = "."
    }
    
    func test_traditional() {
        XCTAssertEqual(traditional.read(0), "零")
        XCTAssertEqual(traditional.read(10_000), "一萬")
    }

    func test_financial() {
        XCTAssertEqual(financial.read(0), "零")
        XCTAssertEqual(financial.read(1), "壹")
        XCTAssertEqual(financial.read(2), "壹")
        XCTAssertEqual(financial.read(3), "叁")
        XCTAssertEqual(financial.read(4), "肆")
        XCTAssertEqual(financial.read(5), "伍")
        XCTAssertEqual(financial.read(6), "陆")
        XCTAssertEqual(financial.read(7), "柒")
        XCTAssertEqual(financial.read(8), "捌")
        XCTAssertEqual(financial.read(9), "玖")
        XCTAssertEqual(financial.read(10), "拾")
        XCTAssertEqual(financial.read(11), "拾壹")
        XCTAssertEqual(financial.read(10_000), "壹萬")
    }

    func test_simplified() {
        /// https://www.mezzoguild.com/learn/chinese/numbers/
        XCTAssertEqual(simplified.read(0), "〇")
        XCTAssertEqual(simplified.read(1), "一")
        XCTAssertEqual(simplified.read(2), "二")
        XCTAssertEqual(simplified.read(3), "三")
        XCTAssertEqual(simplified.read(4), "四")
        XCTAssertEqual(simplified.read(5), "五")
        XCTAssertEqual(simplified.read(6), "六")
        XCTAssertEqual(simplified.read(7), "七")
        XCTAssertEqual(simplified.read(8), "八")
        XCTAssertEqual(simplified.read(9), "九")
        XCTAssertEqual(simplified.read(10), "十")
        XCTAssertEqual(simplified.read(11), "十一")
        XCTAssertEqual(simplified.read(12), "十二")
        XCTAssertEqual(simplified.read(13), "十三")
        XCTAssertEqual(simplified.read(14), "十四")
        XCTAssertEqual(simplified.read(15), "十五")
        XCTAssertEqual(simplified.read(16), "十六")
        XCTAssertEqual(simplified.read(17), "十七")
        XCTAssertEqual(simplified.read(18), "十八")
        XCTAssertEqual(simplified.read(19), "十九")
        XCTAssertEqual(simplified.read(20), "二十")
        XCTAssertEqual(simplified.read(30), "三十")
        XCTAssertEqual(simplified.read(32), "三十二")
        XCTAssertEqual(simplified.read(50), "五十")
        XCTAssertEqual(simplified.read(54), "五十四")
        XCTAssertEqual(simplified.read(78), "七十八")
        XCTAssertEqual(simplified.read(98), "九十八")
        XCTAssertEqual(simplified.read(99), "九十九")
        XCTAssertEqual(simplified.read(100), "一百")
        XCTAssertEqual(simplified.read(101), "一百 零一")
        XCTAssertEqual(simplified.read(102), "一百 零二")
        XCTAssertEqual(simplified.read(103), "一百 零三")
        XCTAssertEqual(simplified.read(104), "一百 零四")
        XCTAssertEqual(simplified.read(110), "一百 一十")
        XCTAssertEqual(simplified.read(111), "一百 一十一")
        XCTAssertEqual(simplified.read(112), "一百 一十二")
        XCTAssertEqual(simplified.read(113), "一百 一十三")
        XCTAssertEqual(simplified.read(120), "一百 二十")
        XCTAssertEqual(simplified.read(130), "一百 三十")
        XCTAssertEqual(simplified.read(140), "一百 四十")
        XCTAssertEqual(simplified.read(125), "一百 二十五")
        XCTAssertEqual(simplified.read(132), "一百 三十二")
        XCTAssertEqual(simplified.read(147), "一百 四十七")
        XCTAssertEqual(simplified.read(152), "一百 五十二")
        XCTAssertEqual(simplified.read(166), "一百 六十六")
        XCTAssertEqual(simplified.read(178), "一百 七十八")
        XCTAssertEqual(simplified.read(183), "一百 八十三")
        XCTAssertEqual(simplified.read(197), "一百 九十七")
        XCTAssertEqual(simplified.read(200), "二百")
        XCTAssertEqual(simplified.read(300), "三百")
        XCTAssertEqual(simplified.read(400), "四百")
        XCTAssertEqual(simplified.read(432), "四百 三十二")
        XCTAssertEqual(simplified.read(500), "五百")
        XCTAssertEqual(simplified.read(600), "六百")
        XCTAssertEqual(simplified.read(700), "七百")
        XCTAssertEqual(simplified.read(800), "八百")
        XCTAssertEqual(simplified.read(900), "九百")
        XCTAssertEqual(simplified.read(301), "三百 零一")
        XCTAssertEqual(simplified.read(565), "五百 六十五")
        XCTAssertEqual(simplified.read(732), "七百 三十二")
        XCTAssertEqual(simplified.read(890), "八百 九十")
        XCTAssertEqual(simplified.read(945), "九百 四十五")
        XCTAssertEqual(simplified.read(1_000), "一千")
        XCTAssertEqual(simplified.read(1_001), "一千 零一")
        XCTAssertEqual(simplified.read(1_003), "一千 零三")
        XCTAssertEqual(simplified.read(1_010), "一千 零十")
        XCTAssertEqual(simplified.read(1_100), "一千 一百")
        XCTAssertEqual(simplified.read(2_000), "二千")
        XCTAssertEqual(simplified.read(3_000), "三千")
        XCTAssertEqual(simplified.read(3_454), "三千 四百 五十四")
        XCTAssertEqual(simplified.read(4_000), "四千")
        XCTAssertEqual(simplified.read(5_000), "五千")
        XCTAssertEqual(simplified.read(6_000), "六千")
        XCTAssertEqual(simplified.read(7_000), "七千")
        XCTAssertEqual(simplified.read(8_000), "八千")
        XCTAssertEqual(simplified.read(9_000), "九千")
        XCTAssertEqual(simplified.read(10_000), "一万")
        
        XCTAssertEqual(simplified.read(10_001), "一万 零一")
        XCTAssertEqual(simplified.read(101), "一百 零一")
        XCTAssertEqual(simplified.read(208), "二百 零八")
        XCTAssertEqual(simplified.read(1_005), "一千 零五")
        XCTAssertEqual(simplified.read(10_003), "一万 零三")
        XCTAssertEqual(simplified.read(10_207), "一万 二百 零七")
        XCTAssertEqual(simplified.read(10_509), "一万 五百 零九")
        XCTAssertEqual(simplified.read(100_070), "十万 零七十")
        
        XCTAssertEqual(simplified.read(10_207), "一万 二百 零七") // email conformation: correct
        XCTAssertNotEqual(simplified.read(10_207), "一万 零 两百 零 七") // email conformation: not correct
        XCTAssertEqual(simplified.read(12_000), "一万 二千")
        XCTAssertEqual(simplified.read(12_345), "一万 二千 三百 四十五")
        XCTAssertEqual(simplified.read(13_200), "一万 三千 二百")
        XCTAssertEqual(simplified.read(52_152), "五万 二千 一百 五十二")
        XCTAssertEqual(simplified.read(56_700), "五万 六千 七百")
        XCTAssertEqual(simplified.read(100_000), "十万")
        XCTAssertEqual(simplified.read(200_000), "二十万")
        XCTAssertEqual(simplified.read(300_000), "三十万")
        XCTAssertEqual(simplified.read(765_432), "七十六万 五千 四百 三十二")
        XCTAssertEqual(simplified.read(1_000_000), "一百万")
        XCTAssertEqual(simplified.read(2_914_680), "二百 九十一万 四千 六百 八十")
        XCTAssertEqual(simplified.read(7_000_000), "七百万")
        XCTAssertEqual(simplified.read(7_890_000), "七百 八十九万")
        
        XCTAssertEqual(simplified.read(7_890_298), "七百 八十九万 二百 九十八")
        XCTAssertEqual(simplified.read(7_890_298), "七百 八十九万 〇 二百 九十八")
        XCTAssertEqual(traditional.read(7_890_298), "七百 八十九万 零 二百 九十八")
        
        XCTAssertEqual(simplified.read(10_000_000), "一千万")
        XCTAssertEqual(simplified.read(27_000_000), "二千 七百万")
        XCTAssertEqual(simplified.read(27_214_000), "二千 七百 二十一万")
        XCTAssertEqual(simplified.read(27_214_896), "二千 七百 二十一 万 四千 八百 九十六")
        XCTAssertEqual(simplified.read(34_567_890), "三千 四百 五十六万七千 八百九十")
        XCTAssertEqual(simplified.read(53_798_250), "五 千三 百 七 十 九 万 八 千 两 百 五 十")
        
        XCTAssertEqual(simplified.read(56_789_123), "")
        XCTAssertEqual(simplified.read(56_789_120), "")
        XCTAssertEqual(simplified.read(56_789_103), "")
        XCTAssertEqual(simplified.read(56_780_023), "")
        XCTAssertEqual(simplified.read(56_709_123), "")
        XCTAssertEqual(simplified.read(56_089_123), "")
        XCTAssertEqual(simplified.read(50_789_123), "")
        
        XCTAssertEqual(simplified.read(78_901_123), "")
        XCTAssertEqual(simplified.read(98_000_000), "九千 八百万")
        XCTAssertEqual(simplified.read(98_765_000), "九千 八百 七十六万 五千")
        XCTAssertEqual(simplified.read(98_765_432), "九千 八百 七十六万 五千 四百 三十二")
        XCTAssertEqual(simplified.read(100_000_000), "一亿")
        XCTAssertEqual(simplified.read(123_456_789), "一亿二千三百四十五万六千七百八十九")
        XCTAssertEqual(simplified.read(414_294_182), "四亿 一千 四百 二十九 万 四千 一百 八十二")
        XCTAssertEqual(simplified.read(1_326_800_000), "十三 亿 两千 六百 八十 万")
        XCTAssertEqual(simplified.read(9_876_543_210), "九十八亿七千六百五十四万三千二百一十")
        XCTAssertEqual(simplified.read(25_158_367_200), "两百 五十一 亿 五千 八百 三十六 万 七千 二百")
        XCTAssertEqual(simplified.read(123_456_789_012), "一千二百三十四亿五千六百七十八万九千零一十二")
        XCTAssertEqual(simplified.read(1_000_000_000_000), "一万亿")
    }
    
    func test_flexiclasses() {
        /// https://flexiclasses.com/chinese-grammar-bank/big-chinese-numbers/
        XCTAssertEqual(simplified.read(10_000), "一万")
        XCTAssertEqual(simplified.read(18_000), "一万 八千")
        XCTAssertEqual(simplified.read(40_000), "四万")
        XCTAssertEqual(simplified.read(40_005), "四万 零五")
        XCTAssertEqual(simplified.read(40_050), "四万 零五十")
        XCTAssertEqual(simplified.read(40_500), "四万 零五百")
        XCTAssertEqual(simplified.read(45_000), "四万 五千")
        XCTAssertEqual(simplified.read(31_240), "三万 一千两百四十")
        XCTAssertEqual(simplified.read(300_000_000), "三亿")
        XCTAssertEqual(simplified.read(240_500_000), "两亿四千五十万")
        XCTAssertEqual(simplified.read(1_200_080_000), "十二亿零八万")
        XCTAssertEqual(simplified.read(7_300_500_040), "七十三亿五十万零四十")
        XCTAssertEqual(simplified.read(34_054), "三万四千三百五十四")
        XCTAssertEqual(simplified.read(5_670_890), "五百六十七万一千八百九十")
        XCTAssertEqual(simplified.read(9_560_435), "九百五十六万四千四百三十五")
        XCTAssertEqual(simplified.read(30_456_720), "三千零四十五万六千二十")
        XCTAssertEqual(simplified.read(200_800_000), "两亿零八十万")
        XCTAssertEqual(simplified.read(2_400_360_899), "二十四亿三十六万零八百九十九")
    }
}
