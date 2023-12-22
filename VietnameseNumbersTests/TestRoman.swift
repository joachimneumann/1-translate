//
//  Test_Roman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/17/23.
//

import XCTest

final class TestRoman: XCTestCase {
    
    let roman = Roman()

    override func setUpWithError() throws {
        roman.groupSeparator = ""
        roman.decimalSeparator = "."
    }

    
    func test_Wikipedia() {
        /// https://en.wikipedia.org/wiki/Roman_numerals
        XCTAssertEqual(roman.read(39), "XXXIX")
        XCTAssertEqual(roman.read(246), "CCXLVI")
        XCTAssertEqual(roman.read(789), "DCCLXXXIX")
        XCTAssertEqual(roman.read(2_421), "MMCDXXI")
        XCTAssertEqual(roman.read(160), "CLX")
        XCTAssertEqual(roman.read(207), "CCVII")
        XCTAssertEqual(roman.read(1_009), "MIX")
        XCTAssertEqual(roman.read(1_066), "MLXVI")
        XCTAssertEqual(roman.read(3_999), "MMMCMXCIX")
    }
    
    func test_rapidTables() {
        /// https://www.rapidtables.com/convert/number/roman-numerals-converter.html?x1=&x2=888
        XCTAssertEqual(roman.read(1), "I") // 1
        XCTAssertEqual(roman.read(2), "II") // 1+1
        XCTAssertEqual(roman.read(3), "III") // 1+1+1
        XCTAssertEqual(roman.read(4), "IV") // 5-1
        XCTAssertEqual(roman.read(5), "V") // 5
        XCTAssertEqual(roman.read(6), "VI") // 5+1
        XCTAssertEqual(roman.read(7), "VII") // 5+1+1
        XCTAssertEqual(roman.read(8), "VIII") // 5+1+1+1
        XCTAssertEqual(roman.read(9), "IX") // 10-1
        XCTAssertEqual(roman.read(10), "X") // 10
        XCTAssertEqual(roman.read(11), "XI") // 10+1
        XCTAssertEqual(roman.read(12), "XII") // 10+1+1
        XCTAssertEqual(roman.read(13), "XIII") // 10+1+1+1
        XCTAssertEqual(roman.read(14), "XIV") // 10-1+5
        XCTAssertEqual(roman.read(15), "XV") // 10+5
        XCTAssertEqual(roman.read(16), "XVI") // 10+5+1
        XCTAssertEqual(roman.read(17), "XVII") // 10+5+1+1
        XCTAssertEqual(roman.read(18), "XVIII") // 10+5+1+1+1
        XCTAssertEqual(roman.read(19), "XIX") // 10-1+10
        XCTAssertEqual(roman.read(20), "XX") // 10+10
        XCTAssertEqual(roman.read(21), "XXI") // 10+10+1
        XCTAssertEqual(roman.read(22), "XXII") // 10+10+1+1
        XCTAssertEqual(roman.read(23), "XXIII") // 10+10+1+1+1
        XCTAssertEqual(roman.read(24), "XXIV") // 10+10-1+5
        XCTAssertEqual(roman.read(25), "XXV") // 10+10+5
        XCTAssertEqual(roman.read(26), "XXVI") // 10+10+5+1
        XCTAssertEqual(roman.read(27), "XXVII") // 10+10+5+1+1
        XCTAssertEqual(roman.read(28), "XXVIII") // 10+10+5+1+1+1
        XCTAssertEqual(roman.read(29), "XXIX") // 10+10-1+10
        XCTAssertEqual(roman.read(30), "XXX") // 10+10+10
        XCTAssertEqual(roman.read(31), "XXXI") // 10+10+10+1
        XCTAssertEqual(roman.read(32), "XXXII") // 10+10+10+1+1
        XCTAssertEqual(roman.read(33), "XXXIII") // 10+10+10+1+1+1
        XCTAssertEqual(roman.read(34), "XXXIV") // 10+10+10-1+5
        XCTAssertEqual(roman.read(35), "XXXV") // 10+10+10+5
        XCTAssertEqual(roman.read(36), "XXXVI") // 10+10+10+5+1
        XCTAssertEqual(roman.read(37), "XXXVII") // 10+10+10+5+1+1
        XCTAssertEqual(roman.read(38), "XXXVIII") // 10+10+10+5+1+1+1
        XCTAssertEqual(roman.read(39), "XXXIX") // 10+10+10-1+10
        XCTAssertEqual(roman.read(40), "XL") // -10+50
        XCTAssertEqual(roman.read(41), "XLI") // -10+50+1
        XCTAssertEqual(roman.read(42), "XLII") // -10+50+1+1
        XCTAssertEqual(roman.read(43), "XLIII") // -10+50+1+1+1
        XCTAssertEqual(roman.read(44), "XLIV") // -10+50-1+5
        XCTAssertEqual(roman.read(45), "XLV") // -10+50+5
        XCTAssertEqual(roman.read(46), "XLVI") // -10+50+5+1
        XCTAssertEqual(roman.read(47), "XLVII") // -10+50+5+1+1
        XCTAssertEqual(roman.read(48), "XLVIII") // -10+50+5+1+1+1
        XCTAssertEqual(roman.read(49), "XLIX") // -10+50-1+10
        XCTAssertEqual(roman.read(50), "L") // 50
        XCTAssertEqual(roman.read(51), "LI") // 50+1
        XCTAssertEqual(roman.read(52), "LII") // 50+1+1
        XCTAssertEqual(roman.read(53), "LIII") // 50+1+1+1
        XCTAssertEqual(roman.read(54), "LIV") // 50-1+5
        XCTAssertEqual(roman.read(55), "LV") // 50+5
        XCTAssertEqual(roman.read(56), "LVI") // 50+5+1
        XCTAssertEqual(roman.read(57), "LVII") // 50+5+1+1
        XCTAssertEqual(roman.read(58), "LVIII") // 50+5+1+1+1
        XCTAssertEqual(roman.read(59), "LIX") // 50-1+10
        XCTAssertEqual(roman.read(60), "LX") // 50+10
        XCTAssertEqual(roman.read(61), "LXI") // 50+10+1
        XCTAssertEqual(roman.read(62), "LXII") // 50+10+1+1
        XCTAssertEqual(roman.read(63), "LXIII") // 50+10+1+1+1
        XCTAssertEqual(roman.read(64), "LXIV") // 50+10-1+5
        XCTAssertEqual(roman.read(65), "LXV") // 50+10+5
        XCTAssertEqual(roman.read(66), "LXVI") // 50+10+5+1
        XCTAssertEqual(roman.read(67), "LXVII") // 50+10+5+1+1
        XCTAssertEqual(roman.read(68), "LXVIII") // 50+10+5+1+1+1
        XCTAssertEqual(roman.read(69), "LXIX") // 50+10-1+10
        XCTAssertEqual(roman.read(70), "LXX") // 50+10+10
        XCTAssertEqual(roman.read(71), "LXXI") // 50+10+10+1
        XCTAssertEqual(roman.read(72), "LXXII") // 50+10+10+1+1
        XCTAssertEqual(roman.read(73), "LXXIII") // 50+10+10+1+1+1
        XCTAssertEqual(roman.read(74), "LXXIV") // 50+10+10-1+5
        XCTAssertEqual(roman.read(75), "LXXV") // 50+10+10+5
        XCTAssertEqual(roman.read(76), "LXXVI") // 50+10+10+5+1
        XCTAssertEqual(roman.read(77), "LXXVII") // 50+10+10+5+1+1
        XCTAssertEqual(roman.read(78), "LXXVIII") // 50+10+10+5+1+1+1
        XCTAssertEqual(roman.read(79), "LXXIX") // 50+10+10-1+10
        XCTAssertEqual(roman.read(80), "LXXX") // 50+10+10+10
        XCTAssertEqual(roman.read(81), "LXXXI") // 50+10+10+10+1
        XCTAssertEqual(roman.read(82), "LXXXII") // 50+10+10+10+1+1
        XCTAssertEqual(roman.read(83), "LXXXIII") // 50+10+10+10+1+1+1
        XCTAssertEqual(roman.read(84), "LXXXIV") // 50+10+10+10-1+5
        XCTAssertEqual(roman.read(85), "LXXXV") // 50+10+10+10+5
        XCTAssertEqual(roman.read(86), "LXXXVI") // 50+10+10+10+5+1
        XCTAssertEqual(roman.read(87), "LXXXVII") // 50+10+10+10+5+1+1
        XCTAssertEqual(roman.read(88), "LXXXVIII") // 50+10+10+10+5+1+1+1
        XCTAssertEqual(roman.read(89), "LXXXIX") // 50+10+10+10-1+10
        XCTAssertEqual(roman.read(90), "XC") // 100-10
        XCTAssertEqual(roman.read(91), "XCI") // 100-10+1
        XCTAssertEqual(roman.read(92), "XCII") // 100-10+1+1
        XCTAssertEqual(roman.read(93), "XCIII") // 100-10+1+1+1
        XCTAssertEqual(roman.read(94), "XCIV") // 100-10-1+5
        XCTAssertEqual(roman.read(95), "XCV") // 100-10+5
        XCTAssertEqual(roman.read(96), "XCVI") // 100-10+5+1
        XCTAssertEqual(roman.read(97), "XCVII") // 100-10+5+1+1
        XCTAssertEqual(roman.read(98), "XCVIII") // 100-10+5+1+1+1
        XCTAssertEqual(roman.read(99), "XCIX") // 100-10-1+10
        XCTAssertEqual(roman.read(100), "C") // 100
        XCTAssertEqual(roman.read(200), "CC") // 100+100
        XCTAssertEqual(roman.read(300), "CCC") // 100+100+100
        XCTAssertEqual(roman.read(400), "CD") // 500-100
        XCTAssertEqual(roman.read(500), "D") // 500
        XCTAssertEqual(roman.read(600), "DC") // 500+100
        XCTAssertEqual(roman.read(700), "DCC") // 500+100+100
        XCTAssertEqual(roman.read(800), "DCCC") // 500+100+100+100
        XCTAssertEqual(roman.read(900), "CM") // 1000-100
        XCTAssertEqual(roman.read(1000), "M") // 1000
        XCTAssertEqual(roman.read(5000), "V"+Roman.TOUSANDS) //
        XCTAssertEqual(roman.read(10000), "X"+Roman.TOUSANDS) //
        XCTAssertEqual(roman.read(50000), "L"+Roman.TOUSANDS) //
        XCTAssertEqual(roman.read(100000), "C"+Roman.TOUSANDS) //
        XCTAssertEqual(roman.read(500000), "D"+Roman.TOUSANDS) //
        XCTAssertEqual(roman.read(1000000), "M"+Roman.TOUSANDS) //
    }
    
    func test_roman() {
        XCTAssertEqual(roman.read(14), "XIV")
        XCTAssertEqual(roman.read(19), "XIX")
        XCTAssertEqual(roman.read(50), "L")
        XCTAssertEqual(roman.read(89), "LXXXIX")
        XCTAssertEqual(roman.read(101), "CI")
        XCTAssertEqual(roman.read(222), "CCXXII")
        XCTAssertEqual(roman.read(333), "CCCXXXIII")
        XCTAssertEqual(roman.read(444), "CDXLIV")
        XCTAssertEqual(roman.read(555), "DLV")
        XCTAssertEqual(roman.read(777), "DCCLXXVII")
        XCTAssertEqual(roman.read(888), "DCCCLXXXVIII")
        XCTAssertEqual(roman.read(1001), "MI")
        XCTAssertEqual(roman.read(1222), "MCCXXII")
        XCTAssertEqual(roman.read(1444), "MCDXLIV")
        XCTAssertEqual(roman.read(1666), "MDCLXVI")
        XCTAssertEqual(roman.read(2000), "MM")
        XCTAssertEqual(roman.read(2999), "MMCMXCIX")
        XCTAssertEqual(roman.read(3000), "MMM")
        XCTAssertEqual(roman.read(3500), "MMMD")
        XCTAssertEqual(roman.read(3999), "MMMCMXCIX")
        XCTAssertEqual(roman.read(19876), "XIX"+Roman.TOUSANDS+"DCCCLXXVI")
        XCTAssertEqual(roman.read(54321), "LIV"+Roman.TOUSANDS+"CCCXXI")
        
        XCTAssertEqual(roman.read(87), "LXXXVII")
        XCTAssertEqual(roman.read(654), "DCLIV")
        XCTAssertEqual(roman.read(87654), "LXXXVII"+Roman.TOUSANDS+"DCLIV")
        XCTAssertEqual(roman.read(98765), "XCVIII"+Roman.TOUSANDS+"DCCLXV")
        XCTAssertEqual(roman.read(123456), "CXXIII"+Roman.TOUSANDS+"CDLVI")
        XCTAssertEqual(roman.read(987654), "CMLXXXVII"+Roman.TOUSANDS+"DCLIV")
        XCTAssertEqual(roman.read(300000), "CCC"+Roman.TOUSANDS)
    }
}

