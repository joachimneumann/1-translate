// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest

final class Test_Roman: XCTestCase {

    let language = Roman()

    func test_Roman() {
        XCTAssertEqual(language.translate(1).x, "I") // 1
        XCTAssertEqual(language.translate(2).x, "II") // 1+1
        XCTAssertEqual(language.translate(3).x, "III") // 1+1+1
        XCTAssertEqual(language.translate(4).x, "IV") // 5-1
        XCTAssertEqual(language.translate(5).x, "V") // 5
        XCTAssertEqual(language.translate(6).x, "VI") // 5+1
        XCTAssertEqual(language.translate(7).x, "VII") // 5+1+1
        XCTAssertEqual(language.translate(8).x, "VIII") // 5+1+1+1
        XCTAssertEqual(language.translate(9).x, "IX") // 10-1
        XCTAssertEqual(language.translate(10).x, "X") // 10
        XCTAssertEqual(language.translate(11).x, "XI") // 10+1
        XCTAssertEqual(language.translate(12).x, "XII") // 10+1+1
        XCTAssertEqual(language.translate(13).x, "XIII") // 10+1+1+1
        XCTAssertEqual(language.translate(14).x, "XIV") // 10-1+5
        XCTAssertEqual(language.translate(15).x, "XV") // 10+5
        XCTAssertEqual(language.translate(16).x, "XVI") // 10+5+1
        XCTAssertEqual(language.translate(17).x, "XVII") // 10+5+1+1
        XCTAssertEqual(language.translate(18).x, "XVIII") // 10+5+1+1+1
        XCTAssertEqual(language.translate(19).x, "XIX") // 10-1+10
        XCTAssertEqual(language.translate(20).x, "XX") // 10+10
        XCTAssertEqual(language.translate(21).x, "XXI") // 10+10+1
        XCTAssertEqual(language.translate(22).x, "XXII") // 10+10+1+1
        XCTAssertEqual(language.translate(23).x, "XXIII") // 10+10+1+1+1
        XCTAssertEqual(language.translate(24).x, "XXIV") // 10+10-1+5
        XCTAssertEqual(language.translate(25).x, "XXV") // 10+10+5
        XCTAssertEqual(language.translate(26).x, "XXVI") // 10+10+5+1
        XCTAssertEqual(language.translate(27).x, "XXVII") // 10+10+5+1+1
        XCTAssertEqual(language.translate(28).x, "XXVIII") // 10+10+5+1+1+1
        XCTAssertEqual(language.translate(29).x, "XXIX") // 10+10-1+10
        XCTAssertEqual(language.translate(30).x, "XXX") // 10+10+10
        XCTAssertEqual(language.translate(31).x, "XXXI") // 10+10+10+1
        XCTAssertEqual(language.translate(32).x, "XXXII") // 10+10+10+1+1
        XCTAssertEqual(language.translate(33).x, "XXXIII") // 10+10+10+1+1+1
        XCTAssertEqual(language.translate(34).x, "XXXIV") // 10+10+10-1+5
        XCTAssertEqual(language.translate(35).x, "XXXV") // 10+10+10+5
        XCTAssertEqual(language.translate(36).x, "XXXVI") // 10+10+10+5+1
        XCTAssertEqual(language.translate(37).x, "XXXVII") // 10+10+10+5+1+1
        XCTAssertEqual(language.translate(38).x, "XXXVIII") // 10+10+10+5+1+1+1
        XCTAssertEqual(language.translate(39).x, "XXXIX") // 10+10+10-1+10
        XCTAssertEqual(language.translate(40).x, "XL") // -10+50
        XCTAssertEqual(language.translate(41).x, "XLI") // -10+50+1
        XCTAssertEqual(language.translate(42).x, "XLII") // -10+50+1+1
        XCTAssertEqual(language.translate(43).x, "XLIII") // -10+50+1+1+1
        XCTAssertEqual(language.translate(44).x, "XLIV") // -10+50-1+5
        XCTAssertEqual(language.translate(45).x, "XLV") // -10+50+5
        XCTAssertEqual(language.translate(46).x, "XLVI") // -10+50+5+1
        XCTAssertEqual(language.translate(47).x, "XLVII") // -10+50+5+1+1
        XCTAssertEqual(language.translate(48).x, "XLVIII") // -10+50+5+1+1+1
        XCTAssertEqual(language.translate(49).x, "XLIX") // -10+50-1+10
        XCTAssertEqual(language.translate(50).x, "L") // 50
        XCTAssertEqual(language.translate(51).x, "LI") // 50+1
        XCTAssertEqual(language.translate(52).x, "LII") // 50+1+1
        XCTAssertEqual(language.translate(53).x, "LIII") // 50+1+1+1
        XCTAssertEqual(language.translate(54).x, "LIV") // 50-1+5
        XCTAssertEqual(language.translate(55).x, "LV") // 50+5
        XCTAssertEqual(language.translate(56).x, "LVI") // 50+5+1
        XCTAssertEqual(language.translate(57).x, "LVII") // 50+5+1+1
        XCTAssertEqual(language.translate(58).x, "LVIII") // 50+5+1+1+1
        XCTAssertEqual(language.translate(59).x, "LIX") // 50-1+10
        XCTAssertEqual(language.translate(60).x, "LX") // 50+10
        XCTAssertEqual(language.translate(61).x, "LXI") // 50+10+1
        XCTAssertEqual(language.translate(62).x, "LXII") // 50+10+1+1
        XCTAssertEqual(language.translate(63).x, "LXIII") // 50+10+1+1+1
        XCTAssertEqual(language.translate(64).x, "LXIV") // 50+10-1+5
        XCTAssertEqual(language.translate(65).x, "LXV") // 50+10+5
        XCTAssertEqual(language.translate(66).x, "LXVI") // 50+10+5+1
        XCTAssertEqual(language.translate(67).x, "LXVII") // 50+10+5+1+1
        XCTAssertEqual(language.translate(68).x, "LXVIII") // 50+10+5+1+1+1
        XCTAssertEqual(language.translate(69).x, "LXIX") // 50+10-1+10
        XCTAssertEqual(language.translate(70).x, "LXX") // 50+10+10
        XCTAssertEqual(language.translate(71).x, "LXXI") // 50+10+10+1
        XCTAssertEqual(language.translate(72).x, "LXXII") // 50+10+10+1+1
        XCTAssertEqual(language.translate(73).x, "LXXIII") // 50+10+10+1+1+1
        XCTAssertEqual(language.translate(74).x, "LXXIV") // 50+10+10-1+5
        XCTAssertEqual(language.translate(75).x, "LXXV") // 50+10+10+5
        XCTAssertEqual(language.translate(76).x, "LXXVI") // 50+10+10+5+1
        XCTAssertEqual(language.translate(77).x, "LXXVII") // 50+10+10+5+1+1
        XCTAssertEqual(language.translate(78).x, "LXXVIII") // 50+10+10+5+1+1+1
        XCTAssertEqual(language.translate(79).x, "LXXIX") // 50+10+10-1+10
        XCTAssertEqual(language.translate(80).x, "LXXX") // 50+10+10+10
        XCTAssertEqual(language.translate(81).x, "LXXXI") // 50+10+10+10+1
        XCTAssertEqual(language.translate(82).x, "LXXXII") // 50+10+10+10+1+1
        XCTAssertEqual(language.translate(83).x, "LXXXIII") // 50+10+10+10+1+1+1
        XCTAssertEqual(language.translate(84).x, "LXXXIV") // 50+10+10+10-1+5
        XCTAssertEqual(language.translate(85).x, "LXXXV") // 50+10+10+10+5
        XCTAssertEqual(language.translate(86).x, "LXXXVI") // 50+10+10+10+5+1
        XCTAssertEqual(language.translate(87).x, "LXXXVII") // 50+10+10+10+5+1+1
        XCTAssertEqual(language.translate(88).x, "LXXXVIII") // 50+10+10+10+5+1+1+1
        XCTAssertEqual(language.translate(89).x, "LXXXIX") // 50+10+10+10-1+10
        XCTAssertEqual(language.translate(90).x, "XC") // 100-10
        XCTAssertEqual(language.translate(91).x, "XCI") // 100-10+1
        XCTAssertEqual(language.translate(92).x, "XCII") // 100-10+1+1
        XCTAssertEqual(language.translate(93).x, "XCIII") // 100-10+1+1+1
        XCTAssertEqual(language.translate(94).x, "XCIV") // 100-10-1+5
        XCTAssertEqual(language.translate(95).x, "XCV") // 100-10+5
        XCTAssertEqual(language.translate(96).x, "XCVI") // 100-10+5+1
        XCTAssertEqual(language.translate(97).x, "XCVII") // 100-10+5+1+1
        XCTAssertEqual(language.translate(98).x, "XCVIII") // 100-10+5+1+1+1
        XCTAssertEqual(language.translate(99).x, "XCIX") // 100-10-1+10
        XCTAssertEqual(language.translate(100).x, "C") // 100
        XCTAssertEqual(language.translate(101).x, "CI")
        XCTAssertEqual(language.translate(160).x, "CLX")
        XCTAssertEqual(language.translate(200).x, "CC") // 100+100
        XCTAssertEqual(language.translate(207).x, "CCVII")
        XCTAssertEqual(language.translate(222).x, "CCXXII")
        XCTAssertEqual(language.translate(246).x, "CCXLVI")
        XCTAssertEqual(language.translate(300).x, "CCC") // 100+100+100
        XCTAssertEqual(language.translate(333).x, "CCCXXXIII")
        XCTAssertEqual(language.translate(400).x, "CD") // 500-100
        XCTAssertEqual(language.translate(444).x, "CDXLIV")
        XCTAssertEqual(language.translate(500).x, "D") // 500
        XCTAssertEqual(language.translate(555).x, "DLV")
        XCTAssertEqual(language.translate(600).x, "DC") // 500+100
        XCTAssertEqual(language.translate(654).x, "DCLIV")
        XCTAssertEqual(language.translate(700).x, "DCC") // 500+100+100
        XCTAssertEqual(language.translate(777).x, "DCCLXXVII")
        XCTAssertEqual(language.translate(789).x, "DCCLXXXIX")
        XCTAssertEqual(language.translate(800).x, "DCCC") // 500+100+100+100
        XCTAssertEqual(language.translate(888).x, "DCCCLXXXVIII")
        XCTAssertEqual(language.translate(900).x, "CM") // 1000-100
        XCTAssertEqual(language.translate(1000).x, "M") // 1000
        XCTAssertEqual(language.translate(1001).x, "MI")
        XCTAssertEqual(language.translate(1_009).x, "MIX")
        XCTAssertEqual(language.translate(1_066).x, "MLXVI")
        XCTAssertEqual(language.translate(1_222).x, "MCCXXII")
        XCTAssertEqual(language.translate(1_444).x, "MCDXLIV")
        XCTAssertEqual(language.translate(1_666).x, "MDCLXVI")
        XCTAssertEqual(language.translate(2_000).x, "MM")
        XCTAssertEqual(language.translate(2_421).x, "MMCDXXI")
        XCTAssertEqual(language.translate(2_999).x, "MMCMXCIX")
        XCTAssertEqual(language.translate(3_000).x, "MMM")
        XCTAssertEqual(language.translate(3_500).x, "MMMD")
        XCTAssertEqual(language.translate(3_999).x, "MMMCMXCIX")
        XCTAssertEqual(language.translate(5_000).x, "V OVERLINE")
        XCTAssertEqual(language.translate(10_000).x, "X OVERLINE")
        XCTAssertEqual(language.translate(19876).x, "XIX OVERLINE DCCCLXXVI")
        XCTAssertEqual(language.translate(36_000).x, "XXXVI OVERLINE")
        XCTAssertEqual(language.translate(50_000).x, "L OVERLINE")
        XCTAssertEqual(language.translate(54321).x, "LIV OVERLINE CCCXXI")
        XCTAssertEqual(language.translate(87654).x, "LXXXVII OVERLINE DCLIV")
        XCTAssertEqual(language.translate(98765).x, "XCVIII OVERLINE DCCLXV")
        XCTAssertEqual(language.translate(100_000).x, "C OVERLINE")
        XCTAssertEqual(language.translate(123_456).x, "CXXIII OVERLINE CDLVI")
        XCTAssertEqual(language.translate(300000).x, "CCC OVERLINE")
        XCTAssertEqual(language.translate(500_000).x, "D OVERLINE")
        XCTAssertEqual(language.translate(987_654).x, "CMLXXXVII OVERLINE DCLIV")
        XCTAssertEqual(language.translate(1_000_000).x, "M OVERLINE")
        XCTAssertEqual(language.translate(-1).x, "negative not allowed")
    }
}
