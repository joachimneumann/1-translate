//
//  Test_Vietnamese.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/15/23.
//

import XCTest

final class TestVietnames: XCTestCase {
    
    func test_Vietnamese() {
        let vietnamese = TranslateVietnamese()
        vietnamese.compact = false
        
        XCTAssertEqual(vietnamese.translate(1001), "một nghìn không trăm lẻ một")
        
        XCTAssertEqual(vietnamese.translate(0), "không")
        XCTAssertEqual(vietnamese.translate(1), "một")
        XCTAssertEqual(vietnamese.translate(2), "hai")
        XCTAssertEqual(vietnamese.translate(3), "ba")
        XCTAssertEqual(vietnamese.translate(4), "bốn")
        XCTAssertEqual(vietnamese.translate(5), "năm")
        XCTAssertEqual(vietnamese.translate(6), "sáu")
        XCTAssertEqual(vietnamese.translate(7), "bảy")
        XCTAssertEqual(vietnamese.translate(8), "tám")
        XCTAssertEqual(vietnamese.translate(9), "chín")
        XCTAssertEqual(vietnamese.translate(10), "mười")
        XCTAssertEqual(vietnamese.translate(11), "mười một")
        XCTAssertEqual(vietnamese.translate(12), "mười hai")
        XCTAssertEqual(vietnamese.translate(13), "mười ba")
        XCTAssertEqual(vietnamese.translate(14), "mười bốn")
        XCTAssertEqual(vietnamese.translate(15), "mười lăm")
        XCTAssertEqual(vietnamese.translate(16), "mười sáu")
        XCTAssertEqual(vietnamese.translate(17), "mười bảy")
        XCTAssertEqual(vietnamese.translate(18), "mười tám")
        XCTAssertEqual(vietnamese.translate(19), "mười chín")
        XCTAssertEqual(vietnamese.translate(20), "hai mươi")
        XCTAssertEqual(vietnamese.translate(21), "hai mươi mốt")
        XCTAssertEqual(vietnamese.translate(22), "hai mươi hai")
        XCTAssertEqual(vietnamese.translate(23), "hai mươi ba")
        XCTAssertEqual(vietnamese.translate(24), "hai mươi bốn")
        XCTAssertEqual(vietnamese.translate(25), "hai mươi lăm")
        XCTAssertEqual(vietnamese.translate(26), "hai mươi sáu")
        XCTAssertEqual(vietnamese.translate(27), "hai mươi bảy")
        XCTAssertEqual(vietnamese.translate(28), "hai mươi tám")
        XCTAssertEqual(vietnamese.translate(29), "hai mươi chín")
        XCTAssertEqual(vietnamese.translate(30), "ba mươi")
        XCTAssertEqual(vietnamese.translate(31), "ba mươi mốt")
        XCTAssertEqual(vietnamese.translate(32), "ba mươi hai")
        XCTAssertEqual(vietnamese.translate(33), "ba mươi ba")
        XCTAssertEqual(vietnamese.translate(34), "ba mươi bốn")
        XCTAssertEqual(vietnamese.translate(35), "ba mươi lăm")
        XCTAssertEqual(vietnamese.translate(36), "ba mươi sáu")
        XCTAssertEqual(vietnamese.translate(37), "ba mươi bảy")
        XCTAssertEqual(vietnamese.translate(38), "ba mươi tám")
        XCTAssertEqual(vietnamese.translate(39), "ba mươi chín")
        XCTAssertEqual(vietnamese.translate(40), "bốn mươi")
        XCTAssertEqual(vietnamese.translate(41), "bốn mươi mốt")
        XCTAssertEqual(vietnamese.translate(42), "bốn mươi hai")
        XCTAssertEqual(vietnamese.translate(43), "bốn mươi ba")
        XCTAssertEqual(vietnamese.translate(44), "bốn mươi bốn")
        XCTAssertEqual(vietnamese.translate(45), "bốn mươi lăm")
        XCTAssertEqual(vietnamese.translate(46), "bốn mươi sáu")
        XCTAssertEqual(vietnamese.translate(47), "bốn mươi bảy")
        XCTAssertEqual(vietnamese.translate(48), "bốn mươi tám")
        XCTAssertEqual(vietnamese.translate(49), "bốn mươi chín")
        XCTAssertEqual(vietnamese.translate(50), "năm mươi")
        XCTAssertEqual(vietnamese.translate(51), "năm mươi mốt")
        XCTAssertEqual(vietnamese.translate(52), "năm mươi hai")
        XCTAssertEqual(vietnamese.translate(53), "năm mươi ba")
        XCTAssertEqual(vietnamese.translate(54), "năm mươi bốn")
        XCTAssertEqual(vietnamese.translate(55), "năm mươi lăm")
        XCTAssertEqual(vietnamese.translate(56), "năm mươi sáu")
        XCTAssertEqual(vietnamese.translate(57), "năm mươi bảy")
        XCTAssertEqual(vietnamese.translate(58), "năm mươi tám")
        XCTAssertEqual(vietnamese.translate(59), "năm mươi chín")
        XCTAssertEqual(vietnamese.translate(60), "sáu mươi")
        XCTAssertEqual(vietnamese.translate(61), "sáu mươi mốt")
        XCTAssertEqual(vietnamese.translate(62), "sáu mươi hai")
        XCTAssertEqual(vietnamese.translate(63), "sáu mươi ba")
        XCTAssertEqual(vietnamese.translate(64), "sáu mươi bốn")
        XCTAssertEqual(vietnamese.translate(65), "sáu mươi lăm")
        XCTAssertEqual(vietnamese.translate(66), "sáu mươi sáu")
        XCTAssertEqual(vietnamese.translate(67), "sáu mươi bảy")
        XCTAssertEqual(vietnamese.translate(68), "sáu mươi tám")
        XCTAssertEqual(vietnamese.translate(69), "sáu mươi chín")
        XCTAssertEqual(vietnamese.translate(70), "bảy mươi")
        XCTAssertEqual(vietnamese.translate(71), "bảy mươi mốt")
        XCTAssertEqual(vietnamese.translate(72), "bảy mươi hai")
        XCTAssertEqual(vietnamese.translate(73), "bảy mươi ba")
        XCTAssertEqual(vietnamese.translate(74), "bảy mươi bốn")
        XCTAssertEqual(vietnamese.translate(75), "bảy mươi lăm")
        XCTAssertEqual(vietnamese.translate(76), "bảy mươi sáu")
        XCTAssertEqual(vietnamese.translate(77), "bảy mươi bảy")
        XCTAssertEqual(vietnamese.translate(78), "bảy mươi tám")
        XCTAssertEqual(vietnamese.translate(79), "bảy mươi chín")
        XCTAssertEqual(vietnamese.translate(80), "tám mươi")
        XCTAssertEqual(vietnamese.translate(81), "tám mươi mốt")
        XCTAssertEqual(vietnamese.translate(82), "tám mươi hai")
        XCTAssertEqual(vietnamese.translate(83), "tám mươi ba")
        XCTAssertEqual(vietnamese.translate(84), "tám mươi bốn")
        XCTAssertEqual(vietnamese.translate(85), "tám mươi lăm")
        XCTAssertEqual(vietnamese.translate(86), "tám mươi sáu")
        XCTAssertEqual(vietnamese.translate(87), "tám mươi bảy")
        XCTAssertEqual(vietnamese.translate(88), "tám mươi tám")
        XCTAssertEqual(vietnamese.translate(89), "tám mươi chín")
        XCTAssertEqual(vietnamese.translate(90), "chín mươi")
        XCTAssertEqual(vietnamese.translate(91), "chín mươi mốt")
        XCTAssertEqual(vietnamese.translate(92), "chín mươi hai")
        XCTAssertEqual(vietnamese.translate(93), "chín mươi ba")
        XCTAssertEqual(vietnamese.translate(94), "chín mươi bốn")
        XCTAssertEqual(vietnamese.translate(95), "chín mươi lăm")
        XCTAssertEqual(vietnamese.translate(96), "chín mươi sáu")
        XCTAssertEqual(vietnamese.translate(97), "chín mươi bảy")
        XCTAssertEqual(vietnamese.translate(98), "chín mươi tám")
        XCTAssertEqual(vietnamese.translate(99), "chín mươi chín")
        XCTAssertEqual(vietnamese.translate(100), "một trăm")
        XCTAssertEqual(vietnamese.translate(101), "một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(102), "một trăm lẻ hai")
        XCTAssertEqual(vietnamese.translate(103), "một trăm lẻ ba")
        XCTAssertEqual(vietnamese.translate(104), "một trăm lẻ bốn")
        XCTAssertEqual(vietnamese.translate(105), "một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(106), "một trăm lẻ sáu")
        XCTAssertEqual(vietnamese.translate(107), "một trăm lẻ bảy")
        XCTAssertEqual(vietnamese.translate(108), "một trăm lẻ tám")
        XCTAssertEqual(vietnamese.translate(109), "một trăm lẻ chín")
        
        vietnamese.secondLast = .linh
        XCTAssertEqual(vietnamese.translate(101), "một trăm linh một")
        XCTAssertEqual(vietnamese.translate(102), "một trăm linh hai")
        XCTAssertEqual(vietnamese.translate(103), "một trăm linh ba")
        XCTAssertEqual(vietnamese.translate(104), "một trăm linh bốn")
        XCTAssertEqual(vietnamese.translate(105), "một trăm linh năm")
        XCTAssertEqual(vietnamese.translate(106), "một trăm linh sáu")
        XCTAssertEqual(vietnamese.translate(107), "một trăm linh bảy")
        XCTAssertEqual(vietnamese.translate(108), "một trăm linh tám")
        XCTAssertEqual(vietnamese.translate(109), "một trăm linh chín")
        vietnamese.secondLast = .lẻ
        
        XCTAssertEqual(vietnamese.translate(110), "một trăm mười")
        XCTAssertEqual(vietnamese.translate(111), "một trăm mười một")
        XCTAssertEqual(vietnamese.translate(119), "một trăm mười chín")
        XCTAssertEqual(vietnamese.translate(120), "một trăm hai mươi")
        XCTAssertEqual(vietnamese.translate(121), "một trăm hai mươi mốt")
        XCTAssertEqual(vietnamese.translate(190), "một trăm chín mươi")
        XCTAssertEqual(vietnamese.translate(999), "chín trăm chín mươi chín")
        XCTAssertEqual(vietnamese.translate(1000), "một nghìn")
        XCTAssertEqual(vietnamese.translate(1001), "một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(1005), "một nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(1009), "một nghìn không trăm lẻ chín")
        XCTAssertEqual(vietnamese.translate(1010), "một nghìn không trăm mười")
        XCTAssertEqual(vietnamese.translate(1011), "một nghìn không trăm mười một")
        XCTAssertEqual(vietnamese.translate(1012), "một nghìn không trăm mười hai")
        XCTAssertEqual(vietnamese.translate(1015), "một nghìn không trăm mười lăm")
        XCTAssertEqual(vietnamese.translate(1035), "một nghìn không trăm ba mươi lăm")
        XCTAssertEqual(vietnamese.translate(1099), "một nghìn không trăm chín mươi chín")
        XCTAssertEqual(vietnamese.translate(1100), "một nghìn một trăm")
        XCTAssertEqual(vietnamese.translate(1101), "một nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(1105), "một nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(1110), "một nghìn một trăm mười")
        XCTAssertEqual(vietnamese.translate(1111), "một nghìn một trăm mười một")
        XCTAssertEqual(vietnamese.translate(1115), "một nghìn một trăm mười lăm")
        XCTAssertEqual(vietnamese.translate(1121), "một nghìn một trăm hai mươi mốt")
        XCTAssertEqual(vietnamese.translate(1125), "một nghìn một trăm hai mươi lăm")
        XCTAssertEqual(vietnamese.translate(10000), "mười nghìn")
        XCTAssertEqual(vietnamese.translate(10001), "mười nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(20001), "hai mươi nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(20010), "hai mươi nghìn không trăm mười")
        XCTAssertEqual(vietnamese.translate(20101), "hai mươi nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(201001), "hai trăm lẻ một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(502305), "năm trăm lẻ hai nghìn ba trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(999999), "chín trăm chín mươi chín nghìn chín trăm chín mươi chín")
        XCTAssertEqual(vietnamese.translate(62_000_000), "sáu mươi hai triệu")
        XCTAssertEqual(vietnamese.translate(62_003_005), "sáu mươi hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(62_003_105), "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(62_003_155), "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm năm mươi lăm")
        XCTAssertEqual(vietnamese.translate(99_000_000_909), "chín mươi chín tỷ chín trăm lẻ chín")
        XCTAssertEqual(vietnamese.translate(99_999_999_999), "chín mươi chín tỷ chín trăm chín mươi chín triệu chín trăm chín mươi chín nghìn chín trăm chín mươi chín")
        
        vietnamese.compact = true
        XCTAssertEqual(vietnamese.translate(0), "không")
        XCTAssertEqual(vietnamese.translate(1), "một")
        XCTAssertEqual(vietnamese.translate(2), "hai")
        XCTAssertEqual(vietnamese.translate(3), "ba")
        XCTAssertEqual(vietnamese.translate(4), "bốn")
        XCTAssertEqual(vietnamese.translate(5), "năm")
        XCTAssertEqual(vietnamese.translate(6), "sáu")
        XCTAssertEqual(vietnamese.translate(7), "bảy")
        XCTAssertEqual(vietnamese.translate(8), "tám")
        XCTAssertEqual(vietnamese.translate(9), "chín")
        XCTAssertEqual(vietnamese.translate(10), "mười")
        XCTAssertEqual(vietnamese.translate(11), "mười một")
        XCTAssertEqual(vietnamese.translate(12), "mười hai")
        XCTAssertEqual(vietnamese.translate(13), "mười ba")
        XCTAssertEqual(vietnamese.translate(14), "mười bốn")
        XCTAssertEqual(vietnamese.translate(15), "mười lăm")
        XCTAssertEqual(vietnamese.translate(16), "mười sáu")
        XCTAssertEqual(vietnamese.translate(17), "mười bảy")
        XCTAssertEqual(vietnamese.translate(18), "mười tám")
        XCTAssertEqual(vietnamese.translate(19), "mười chín")
        XCTAssertEqual(vietnamese.translate(20), "hai mươi")
        XCTAssertEqual(vietnamese.translate(21), "hai mốt")
        XCTAssertEqual(vietnamese.translate(22), "hai hai")
        XCTAssertEqual(vietnamese.translate(23), "hai ba")
        XCTAssertEqual(vietnamese.translate(24), "hai bốn")
        XCTAssertEqual(vietnamese.translate(25), "hai lăm")
        XCTAssertEqual(vietnamese.translate(26), "hai sáu")
        XCTAssertEqual(vietnamese.translate(27), "hai bảy")
        XCTAssertEqual(vietnamese.translate(28), "hai tám")
        XCTAssertEqual(vietnamese.translate(29), "hai chín")
        XCTAssertEqual(vietnamese.translate(30), "ba mươi")
        XCTAssertEqual(vietnamese.translate(31), "ba mốt")
        XCTAssertEqual(vietnamese.translate(32), "ba hai")
        XCTAssertEqual(vietnamese.translate(33), "ba ba")
        XCTAssertEqual(vietnamese.translate(34), "ba bốn")
        XCTAssertEqual(vietnamese.translate(35), "ba lăm")
        XCTAssertEqual(vietnamese.translate(36), "ba sáu")
        XCTAssertEqual(vietnamese.translate(37), "ba bảy")
        XCTAssertEqual(vietnamese.translate(38), "ba tám")
        XCTAssertEqual(vietnamese.translate(39), "ba chín")
        XCTAssertEqual(vietnamese.translate(40), "bốn mươi")
        XCTAssertEqual(vietnamese.translate(41), "bốn mốt")
        XCTAssertEqual(vietnamese.translate(42), "bốn hai")
        XCTAssertEqual(vietnamese.translate(43), "bốn ba")
        XCTAssertEqual(vietnamese.translate(44), "bốn bốn")
        XCTAssertEqual(vietnamese.translate(45), "bốn lăm")
        XCTAssertEqual(vietnamese.translate(46), "bốn sáu")
        XCTAssertEqual(vietnamese.translate(47), "bốn bảy")
        XCTAssertEqual(vietnamese.translate(48), "bốn tám")
        XCTAssertEqual(vietnamese.translate(49), "bốn chín")
        XCTAssertEqual(vietnamese.translate(50), "năm mươi")
        XCTAssertEqual(vietnamese.translate(51), "năm mốt")
        XCTAssertEqual(vietnamese.translate(52), "năm hai")
        XCTAssertEqual(vietnamese.translate(53), "năm ba")
        XCTAssertEqual(vietnamese.translate(54), "năm bốn")
        XCTAssertEqual(vietnamese.translate(55), "năm lăm")
        XCTAssertEqual(vietnamese.translate(56), "năm sáu")
        XCTAssertEqual(vietnamese.translate(57), "năm bảy")
        XCTAssertEqual(vietnamese.translate(58), "năm tám")
        XCTAssertEqual(vietnamese.translate(59), "năm chín")
        XCTAssertEqual(vietnamese.translate(60), "sáu mươi")
        XCTAssertEqual(vietnamese.translate(61), "sáu mốt")
        XCTAssertEqual(vietnamese.translate(62), "sáu hai")
        XCTAssertEqual(vietnamese.translate(63), "sáu ba")
        XCTAssertEqual(vietnamese.translate(64), "sáu bốn")
        XCTAssertEqual(vietnamese.translate(65), "sáu lăm")
        XCTAssertEqual(vietnamese.translate(66), "sáu sáu")
        XCTAssertEqual(vietnamese.translate(67), "sáu bảy")
        XCTAssertEqual(vietnamese.translate(68), "sáu tám")
        XCTAssertEqual(vietnamese.translate(69), "sáu chín")
        XCTAssertEqual(vietnamese.translate(70), "bảy mươi")
        XCTAssertEqual(vietnamese.translate(71), "bảy mốt")
        XCTAssertEqual(vietnamese.translate(72), "bảy hai")
        XCTAssertEqual(vietnamese.translate(73), "bảy ba")
        XCTAssertEqual(vietnamese.translate(74), "bảy bốn")
        XCTAssertEqual(vietnamese.translate(75), "bảy lăm")
        XCTAssertEqual(vietnamese.translate(76), "bảy sáu")
        XCTAssertEqual(vietnamese.translate(77), "bảy bảy")
        XCTAssertEqual(vietnamese.translate(78), "bảy tám")
        XCTAssertEqual(vietnamese.translate(79), "bảy chín")
        XCTAssertEqual(vietnamese.translate(80), "tám mươi")
        XCTAssertEqual(vietnamese.translate(81), "tám mốt")
        XCTAssertEqual(vietnamese.translate(82), "tám hai")
        XCTAssertEqual(vietnamese.translate(83), "tám ba")
        XCTAssertEqual(vietnamese.translate(84), "tám bốn")
        XCTAssertEqual(vietnamese.translate(85), "tám lăm")
        XCTAssertEqual(vietnamese.translate(86), "tám sáu")
        XCTAssertEqual(vietnamese.translate(87), "tám bảy")
        XCTAssertEqual(vietnamese.translate(88), "tám tám")
        XCTAssertEqual(vietnamese.translate(89), "tám chín")
        XCTAssertEqual(vietnamese.translate(90), "chín mươi")
        XCTAssertEqual(vietnamese.translate(91), "chín mốt")
        XCTAssertEqual(vietnamese.translate(92), "chín hai")
        XCTAssertEqual(vietnamese.translate(93), "chín ba")
        XCTAssertEqual(vietnamese.translate(94), "chín bốn")
        XCTAssertEqual(vietnamese.translate(95), "chín lăm")
        XCTAssertEqual(vietnamese.translate(96), "chín sáu")
        XCTAssertEqual(vietnamese.translate(97), "chín bảy")
        XCTAssertEqual(vietnamese.translate(98), "chín tám")
        XCTAssertEqual(vietnamese.translate(99), "chín chín")
        XCTAssertEqual(vietnamese.translate(100), "một trăm")
        XCTAssertEqual(vietnamese.translate(101), "một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(102), "một trăm lẻ hai")
        XCTAssertEqual(vietnamese.translate(103), "một trăm lẻ ba")
        XCTAssertEqual(vietnamese.translate(104), "một trăm lẻ bốn")
        XCTAssertEqual(vietnamese.translate(105), "một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(106), "một trăm lẻ sáu")
        XCTAssertEqual(vietnamese.translate(107), "một trăm lẻ bảy")
        XCTAssertEqual(vietnamese.translate(108), "một trăm lẻ tám")
        XCTAssertEqual(vietnamese.translate(109), "một trăm lẻ chín")
        
        vietnamese.secondLast = .linh
        XCTAssertEqual(vietnamese.translate(101), "một trăm linh một")
        XCTAssertEqual(vietnamese.translate(102), "một trăm linh hai")
        XCTAssertEqual(vietnamese.translate(103), "một trăm linh ba")
        XCTAssertEqual(vietnamese.translate(104), "một trăm linh bốn")
        XCTAssertEqual(vietnamese.translate(105), "một trăm linh năm")
        XCTAssertEqual(vietnamese.translate(106), "một trăm linh sáu")
        XCTAssertEqual(vietnamese.translate(107), "một trăm linh bảy")
        XCTAssertEqual(vietnamese.translate(108), "một trăm linh tám")
        XCTAssertEqual(vietnamese.translate(109), "một trăm linh chín")
        vietnamese.secondLast = .lẻ
        
        XCTAssertEqual(vietnamese.translate(110), "một trăm mười")
        XCTAssertEqual(vietnamese.translate(111), "một trăm mười một")
        XCTAssertEqual(vietnamese.translate(119), "một trăm mười chín")
        XCTAssertEqual(vietnamese.translate(120), "một trăm hai mươi")
        XCTAssertEqual(vietnamese.translate(121), "một trăm hai mốt")
        XCTAssertEqual(vietnamese.translate(190), "một trăm chín mươi")
        XCTAssertEqual(vietnamese.translate(999), "chín trăm chín chín")
        XCTAssertEqual(vietnamese.translate(1_000), "một nghìn")
        XCTAssertEqual(vietnamese.translate(1_001), "một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(1_005), "một nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(1_009), "một nghìn không trăm lẻ chín")
        XCTAssertEqual(vietnamese.translate(1_010), "một nghìn không trăm mười")
        XCTAssertEqual(vietnamese.translate(1_011), "một nghìn không trăm mười một")
        XCTAssertEqual(vietnamese.translate(1_012), "một nghìn không trăm mười hai")
        XCTAssertEqual(vietnamese.translate(1_015), "một nghìn không trăm mười lăm")
        XCTAssertEqual(vietnamese.translate(1_035), "một nghìn không trăm ba lăm")
        XCTAssertEqual(vietnamese.translate(1_099), "một nghìn không trăm chín chín")
        XCTAssertEqual(vietnamese.translate(1_100), "một nghìn một trăm")
        XCTAssertEqual(vietnamese.translate(1_101), "một nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(1_105), "một nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(1_110), "một nghìn một trăm mười")
        XCTAssertEqual(vietnamese.translate(1_111), "một nghìn một trăm mười một")
        XCTAssertEqual(vietnamese.translate(1_115), "một nghìn một trăm mười lăm")
        XCTAssertEqual(vietnamese.translate(1_121), "một nghìn một trăm hai mốt")
        XCTAssertEqual(vietnamese.translate(1_125), "một nghìn một trăm hai lăm")
        XCTAssertEqual(vietnamese.translate(10_000), "mười nghìn")
        XCTAssertEqual(vietnamese.translate(10_001), "mười nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(20_001), "hai mươi nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(20_010), "hai mươi nghìn không trăm mười")
        XCTAssertEqual(vietnamese.translate(201_01), "hai mươi nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(201_001), "hai trăm lẻ một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.translate(502_305), "năm trăm lẻ hai nghìn ba trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(999_999), "chín trăm chín chín nghìn chín trăm chín chín")
        XCTAssertEqual(vietnamese.translate(62_000_000), "sáu hai triệu")
        XCTAssertEqual(vietnamese.translate(62_003_005), "sáu hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(62_003_105), "sáu hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.translate(62_003_155), "sáu hai triệu không trăm lẻ ba nghìn một trăm năm lăm")
        XCTAssertEqual(vietnamese.translate(99_000_000_909), "chín chín tỷ chín trăm lẻ chín")
        XCTAssertEqual(vietnamese.translate(99_999_999_999), "chín chín tỷ chín trăm chín chín triệu chín trăm chín chín nghìn chín trăm chín chín")
    }
}
