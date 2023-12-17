//
//  Test_Roman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/17/23.
//

import XCTest

final class TestRoman: XCTestCase {
    
    func test_Wikipedia() {
        /// https://en.wikipedia.org/wiki/Roman_numerals
        let roman = TranslateRoman()
        roman.groupSeparator = ""
        roman.decimalSeparator = "."
        XCTAssertEqual(roman.translate(39), "XXXIX")
        XCTAssertEqual(roman.translate(246), "CCXLVI")
        XCTAssertEqual(roman.translate(789), "DCCLXXXIX")
        XCTAssertEqual(roman.translate(2_421), "MMCDXXI")
        XCTAssertEqual(roman.translate(160), "CLX")
        XCTAssertEqual(roman.translate(207), "CCVII")
        XCTAssertEqual(roman.translate(1_009), "MIX")
        XCTAssertEqual(roman.translate(1_066), "MLXVI")
        XCTAssertEqual(roman.translate(3_999), "MMMCMXCIX")
    }
    
    func test_rapidTables() {
        /// https://www.rapidtables.com/convert/number/roman-numerals-converter.html?x1=&x2=888
        let roman = TranslateRoman()
        roman.groupSeparator = ""
        roman.decimalSeparator = "."
        XCTAssertEqual(roman.translate(1), "I") // 1
        XCTAssertEqual(roman.translate(2), "II") // 1+1
        XCTAssertEqual(roman.translate(3), "III") // 1+1+1
        XCTAssertEqual(roman.translate(4), "IV") // 5-1
        XCTAssertEqual(roman.translate(5), "V") // 5
        XCTAssertEqual(roman.translate(6), "VI") // 5+1
        XCTAssertEqual(roman.translate(7), "VII") // 5+1+1
        XCTAssertEqual(roman.translate(8), "VIII") // 5+1+1+1
        XCTAssertEqual(roman.translate(9), "IX") // 10-1
        XCTAssertEqual(roman.translate(10), "X") // 10
        XCTAssertEqual(roman.translate(11), "XI") // 10+1
        XCTAssertEqual(roman.translate(12), "XII") // 10+1+1
        XCTAssertEqual(roman.translate(13), "XIII") // 10+1+1+1
        XCTAssertEqual(roman.translate(14), "XIV") // 10-1+5
        XCTAssertEqual(roman.translate(15), "XV") // 10+5
        XCTAssertEqual(roman.translate(16), "XVI") // 10+5+1
        XCTAssertEqual(roman.translate(17), "XVII") // 10+5+1+1
        XCTAssertEqual(roman.translate(18), "XVIII") // 10+5+1+1+1
        XCTAssertEqual(roman.translate(19), "XIX") // 10-1+10
        XCTAssertEqual(roman.translate(20), "XX") // 10+10
        XCTAssertEqual(roman.translate(21), "XXI") // 10+10+1
        XCTAssertEqual(roman.translate(22), "XXII") // 10+10+1+1
        XCTAssertEqual(roman.translate(23), "XXIII") // 10+10+1+1+1
        XCTAssertEqual(roman.translate(24), "XXIV") // 10+10-1+5
        XCTAssertEqual(roman.translate(25), "XXV") // 10+10+5
        XCTAssertEqual(roman.translate(26), "XXVI") // 10+10+5+1
        XCTAssertEqual(roman.translate(27), "XXVII") // 10+10+5+1+1
        XCTAssertEqual(roman.translate(28), "XXVIII") // 10+10+5+1+1+1
        XCTAssertEqual(roman.translate(29), "XXIX") // 10+10-1+10
        XCTAssertEqual(roman.translate(30), "XXX") // 10+10+10
        XCTAssertEqual(roman.translate(31), "XXXI") // 10+10+10+1
        XCTAssertEqual(roman.translate(32), "XXXII") // 10+10+10+1+1
        XCTAssertEqual(roman.translate(33), "XXXIII") // 10+10+10+1+1+1
        XCTAssertEqual(roman.translate(34), "XXXIV") // 10+10+10-1+5
        XCTAssertEqual(roman.translate(35), "XXXV") // 10+10+10+5
        XCTAssertEqual(roman.translate(36), "XXXVI") // 10+10+10+5+1
        XCTAssertEqual(roman.translate(37), "XXXVII") // 10+10+10+5+1+1
        XCTAssertEqual(roman.translate(38), "XXXVIII") // 10+10+10+5+1+1+1
        XCTAssertEqual(roman.translate(39), "XXXIX") // 10+10+10-1+10
        XCTAssertEqual(roman.translate(40), "XL") // -10+50
        XCTAssertEqual(roman.translate(41), "XLI") // -10+50+1
        XCTAssertEqual(roman.translate(42), "XLII") // -10+50+1+1
        XCTAssertEqual(roman.translate(43), "XLIII") // -10+50+1+1+1
        XCTAssertEqual(roman.translate(44), "XLIV") // -10+50-1+5
        XCTAssertEqual(roman.translate(45), "XLV") // -10+50+5
        XCTAssertEqual(roman.translate(46), "XLVI") // -10+50+5+1
        XCTAssertEqual(roman.translate(47), "XLVII") // -10+50+5+1+1
        XCTAssertEqual(roman.translate(48), "XLVIII") // -10+50+5+1+1+1
        XCTAssertEqual(roman.translate(49), "XLIX") // -10+50-1+10
        XCTAssertEqual(roman.translate(50), "L") // 50
        XCTAssertEqual(roman.translate(51), "LI") // 50+1
        XCTAssertEqual(roman.translate(52), "LII") // 50+1+1
        XCTAssertEqual(roman.translate(53), "LIII") // 50+1+1+1
        XCTAssertEqual(roman.translate(54), "LIV") // 50-1+5
        XCTAssertEqual(roman.translate(55), "LV") // 50+5
        XCTAssertEqual(roman.translate(56), "LVI") // 50+5+1
        XCTAssertEqual(roman.translate(57), "LVII") // 50+5+1+1
        XCTAssertEqual(roman.translate(58), "LVIII") // 50+5+1+1+1
        XCTAssertEqual(roman.translate(59), "LIX") // 50-1+10
        XCTAssertEqual(roman.translate(60), "LX") // 50+10
        XCTAssertEqual(roman.translate(61), "LXI") // 50+10+1
        XCTAssertEqual(roman.translate(62), "LXII") // 50+10+1+1
        XCTAssertEqual(roman.translate(63), "LXIII") // 50+10+1+1+1
        XCTAssertEqual(roman.translate(64), "LXIV") // 50+10-1+5
        XCTAssertEqual(roman.translate(65), "LXV") // 50+10+5
        XCTAssertEqual(roman.translate(66), "LXVI") // 50+10+5+1
        XCTAssertEqual(roman.translate(67), "LXVII") // 50+10+5+1+1
        XCTAssertEqual(roman.translate(68), "LXVIII") // 50+10+5+1+1+1
        XCTAssertEqual(roman.translate(69), "LXIX") // 50+10-1+10
        XCTAssertEqual(roman.translate(70), "LXX") // 50+10+10
        XCTAssertEqual(roman.translate(71), "LXXI") // 50+10+10+1
        XCTAssertEqual(roman.translate(72), "LXXII") // 50+10+10+1+1
        XCTAssertEqual(roman.translate(73), "LXXIII") // 50+10+10+1+1+1
        XCTAssertEqual(roman.translate(74), "LXXIV") // 50+10+10-1+5
        XCTAssertEqual(roman.translate(75), "LXXV") // 50+10+10+5
        XCTAssertEqual(roman.translate(76), "LXXVI") // 50+10+10+5+1
        XCTAssertEqual(roman.translate(77), "LXXVII") // 50+10+10+5+1+1
        XCTAssertEqual(roman.translate(78), "LXXVIII") // 50+10+10+5+1+1+1
        XCTAssertEqual(roman.translate(79), "LXXIX") // 50+10+10-1+10
        XCTAssertEqual(roman.translate(80), "LXXX") // 50+10+10+10
        XCTAssertEqual(roman.translate(81), "LXXXI") // 50+10+10+10+1
        XCTAssertEqual(roman.translate(82), "LXXXII") // 50+10+10+10+1+1
        XCTAssertEqual(roman.translate(83), "LXXXIII") // 50+10+10+10+1+1+1
        XCTAssertEqual(roman.translate(84), "LXXXIV") // 50+10+10+10-1+5
        XCTAssertEqual(roman.translate(85), "LXXXV") // 50+10+10+10+5
        XCTAssertEqual(roman.translate(86), "LXXXVI") // 50+10+10+10+5+1
        XCTAssertEqual(roman.translate(87), "LXXXVII") // 50+10+10+10+5+1+1
        XCTAssertEqual(roman.translate(88), "LXXXVIII") // 50+10+10+10+5+1+1+1
        XCTAssertEqual(roman.translate(89), "LXXXIX") // 50+10+10+10-1+10
        XCTAssertEqual(roman.translate(90), "XC") // 100-10
        XCTAssertEqual(roman.translate(91), "XCI") // 100-10+1
        XCTAssertEqual(roman.translate(92), "XCII") // 100-10+1+1
        XCTAssertEqual(roman.translate(93), "XCIII") // 100-10+1+1+1
        XCTAssertEqual(roman.translate(94), "XCIV") // 100-10-1+5
        XCTAssertEqual(roman.translate(95), "XCV") // 100-10+5
        XCTAssertEqual(roman.translate(96), "XCVI") // 100-10+5+1
        XCTAssertEqual(roman.translate(97), "XCVII") // 100-10+5+1+1
        XCTAssertEqual(roman.translate(98), "XCVIII") // 100-10+5+1+1+1
        XCTAssertEqual(roman.translate(99), "XCIX") // 100-10-1+10
        XCTAssertEqual(roman.translate(100), "C") // 100
        XCTAssertEqual(roman.translate(200), "CC") // 100+100
        XCTAssertEqual(roman.translate(300), "CCC") // 100+100+100
        XCTAssertEqual(roman.translate(400), "CD") // 500-100
        XCTAssertEqual(roman.translate(500), "D") // 500
        XCTAssertEqual(roman.translate(600), "DC") // 500+100
        XCTAssertEqual(roman.translate(700), "DCC") // 500+100+100
        XCTAssertEqual(roman.translate(800), "DCCC") // 500+100+100+100
        XCTAssertEqual(roman.translate(900), "CM") // 1000-100
        XCTAssertEqual(roman.translate(1000), "M") // 1000
        XCTAssertEqual(roman.translate(5000), "V") //
        XCTAssertEqual(roman.translate(10000), "X") //
        XCTAssertEqual(roman.translate(50000), "L") //
        XCTAssertEqual(roman.translate(100000), "C") //
        XCTAssertEqual(roman.translate(500000), "D") //
        XCTAssertEqual(roman.translate(1000000), "M") //
    }
    
    func test_roman() {
        let roman = TranslateRoman()
        roman.groupSeparator = ""
        roman.decimalSeparator = "."
        XCTAssertEqual(roman.translate(14), "XIV")
        XCTAssertEqual(roman.translate(19), "XIX")
        XCTAssertEqual(roman.translate(50), "L")
        XCTAssertEqual(roman.translate(89), "LXXXIX")
        XCTAssertEqual(roman.translate(101), "CI")
        XCTAssertEqual(roman.translate(222), "CCXXII")
        XCTAssertEqual(roman.translate(333), "CCCXXXIII")
        XCTAssertEqual(roman.translate(444), "CDXLIV")
        XCTAssertEqual(roman.translate(555), "DLV")
        XCTAssertEqual(roman.translate(777), "DCCLXXVII")
        XCTAssertEqual(roman.translate(888), "DCCCLXXXVIII")
        XCTAssertEqual(roman.translate(1001), "MI")
        XCTAssertEqual(roman.translate(1222), "MCCXXII")
        XCTAssertEqual(roman.translate(1444), "MCDXLIV")
        XCTAssertEqual(roman.translate(1666), "MDCLXVI")
        XCTAssertEqual(roman.translate(2000), "MM")
        XCTAssertEqual(roman.translate(2999), "MMCMXCIX")
        XCTAssertEqual(roman.translate(3000), "MMM")
        XCTAssertEqual(roman.translate(3500), "MMMD")
        XCTAssertEqual(roman.translate(3999), "MMMCMXCIX")
        XCTAssertEqual(roman.translate(19876), "XIXDCCCLXXVI")
        XCTAssertEqual(roman.translate(54321), "LIVCCCXXI")
        XCTAssertEqual(roman.translate(87654), "DCCCLXXVCDLIV")
        XCTAssertEqual(roman.translate(98765), "CMLXXXVMMDCCLXV")
        XCTAssertEqual(roman.translate(123456), "CXXIIIMCDLVI")
        XCTAssertEqual(roman.translate(987654), "CMLXXXVMMDCCLIV")
        XCTAssertEqual(roman.translate(300000), "CCC")
    }
}

