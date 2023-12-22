//
//  Test_Vietnamese.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/15/23.
//

import XCTest

final class TestVietnames: XCTestCase {
    
    func test_Vietnamese() {
        let vietnamese = Vietnamese()
        // vietnamese.compact = false
        
        XCTAssertEqual(vietnamese.read(1001), "một nghìn không trăm lẻ một")
        
        XCTAssertEqual(vietnamese.read(0), "không")
        XCTAssertEqual(vietnamese.read(1), "một")
        XCTAssertEqual(vietnamese.read(2), "hai")
        XCTAssertEqual(vietnamese.read(3), "ba")
        XCTAssertEqual(vietnamese.read(4), "bốn")
        XCTAssertEqual(vietnamese.read(5), "năm")
        XCTAssertEqual(vietnamese.read(6), "sáu")
        XCTAssertEqual(vietnamese.read(7), "bảy")
        XCTAssertEqual(vietnamese.read(8), "tám")
        XCTAssertEqual(vietnamese.read(9), "chín")
        XCTAssertEqual(vietnamese.read(10), "mười")
        XCTAssertEqual(vietnamese.read(11), "mười một")
        XCTAssertEqual(vietnamese.read(12), "mười hai")
        XCTAssertEqual(vietnamese.read(13), "mười ba")
        XCTAssertEqual(vietnamese.read(14), "mười bốn")
        XCTAssertEqual(vietnamese.read(15), "mười lăm")
        XCTAssertEqual(vietnamese.read(16), "mười sáu")
        XCTAssertEqual(vietnamese.read(17), "mười bảy")
        XCTAssertEqual(vietnamese.read(18), "mười tám")
        XCTAssertEqual(vietnamese.read(19), "mười chín")
        XCTAssertEqual(vietnamese.read(20), "hai mươi")
        XCTAssertEqual(vietnamese.read(21), "hai mươi mốt")
        XCTAssertEqual(vietnamese.read(22), "hai mươi hai")
        XCTAssertEqual(vietnamese.read(23), "hai mươi ba")
        XCTAssertEqual(vietnamese.read(24), "hai mươi bốn")
        XCTAssertEqual(vietnamese.read(25), "hai mươi lăm")
        XCTAssertEqual(vietnamese.read(26), "hai mươi sáu")
        XCTAssertEqual(vietnamese.read(27), "hai mươi bảy")
        XCTAssertEqual(vietnamese.read(28), "hai mươi tám")
        XCTAssertEqual(vietnamese.read(29), "hai mươi chín")
        XCTAssertEqual(vietnamese.read(30), "ba mươi")
        XCTAssertEqual(vietnamese.read(31), "ba mươi mốt")
        XCTAssertEqual(vietnamese.read(32), "ba mươi hai")
        XCTAssertEqual(vietnamese.read(33), "ba mươi ba")
        XCTAssertEqual(vietnamese.read(34), "ba mươi bốn")
        XCTAssertEqual(vietnamese.read(35), "ba mươi lăm")
        XCTAssertEqual(vietnamese.read(36), "ba mươi sáu")
        XCTAssertEqual(vietnamese.read(37), "ba mươi bảy")
        XCTAssertEqual(vietnamese.read(38), "ba mươi tám")
        XCTAssertEqual(vietnamese.read(39), "ba mươi chín")
        XCTAssertEqual(vietnamese.read(40), "bốn mươi")
        XCTAssertEqual(vietnamese.read(41), "bốn mươi mốt")
        XCTAssertEqual(vietnamese.read(42), "bốn mươi hai")
        XCTAssertEqual(vietnamese.read(43), "bốn mươi ba")
        XCTAssertEqual(vietnamese.read(44), "bốn mươi bốn")
        XCTAssertEqual(vietnamese.read(45), "bốn mươi lăm")
        XCTAssertEqual(vietnamese.read(46), "bốn mươi sáu")
        XCTAssertEqual(vietnamese.read(47), "bốn mươi bảy")
        XCTAssertEqual(vietnamese.read(48), "bốn mươi tám")
        XCTAssertEqual(vietnamese.read(49), "bốn mươi chín")
        XCTAssertEqual(vietnamese.read(50), "năm mươi")
        XCTAssertEqual(vietnamese.read(51), "năm mươi mốt")
        XCTAssertEqual(vietnamese.read(52), "năm mươi hai")
        XCTAssertEqual(vietnamese.read(53), "năm mươi ba")
        XCTAssertEqual(vietnamese.read(54), "năm mươi bốn")
        XCTAssertEqual(vietnamese.read(55), "năm mươi lăm")
        XCTAssertEqual(vietnamese.read(56), "năm mươi sáu")
        XCTAssertEqual(vietnamese.read(57), "năm mươi bảy")
        XCTAssertEqual(vietnamese.read(58), "năm mươi tám")
        XCTAssertEqual(vietnamese.read(59), "năm mươi chín")
        XCTAssertEqual(vietnamese.read(60), "sáu mươi")
        XCTAssertEqual(vietnamese.read(61), "sáu mươi mốt")
        XCTAssertEqual(vietnamese.read(62), "sáu mươi hai")
        XCTAssertEqual(vietnamese.read(63), "sáu mươi ba")
        XCTAssertEqual(vietnamese.read(64), "sáu mươi bốn")
        XCTAssertEqual(vietnamese.read(65), "sáu mươi lăm")
        XCTAssertEqual(vietnamese.read(66), "sáu mươi sáu")
        XCTAssertEqual(vietnamese.read(67), "sáu mươi bảy")
        XCTAssertEqual(vietnamese.read(68), "sáu mươi tám")
        XCTAssertEqual(vietnamese.read(69), "sáu mươi chín")
        XCTAssertEqual(vietnamese.read(70), "bảy mươi")
        XCTAssertEqual(vietnamese.read(71), "bảy mươi mốt")
        XCTAssertEqual(vietnamese.read(72), "bảy mươi hai")
        XCTAssertEqual(vietnamese.read(73), "bảy mươi ba")
        XCTAssertEqual(vietnamese.read(74), "bảy mươi bốn")
        XCTAssertEqual(vietnamese.read(75), "bảy mươi lăm")
        XCTAssertEqual(vietnamese.read(76), "bảy mươi sáu")
        XCTAssertEqual(vietnamese.read(77), "bảy mươi bảy")
        XCTAssertEqual(vietnamese.read(78), "bảy mươi tám")
        XCTAssertEqual(vietnamese.read(79), "bảy mươi chín")
        XCTAssertEqual(vietnamese.read(80), "tám mươi")
        XCTAssertEqual(vietnamese.read(81), "tám mươi mốt")
        XCTAssertEqual(vietnamese.read(82), "tám mươi hai")
        XCTAssertEqual(vietnamese.read(83), "tám mươi ba")
        XCTAssertEqual(vietnamese.read(84), "tám mươi bốn")
        XCTAssertEqual(vietnamese.read(85), "tám mươi lăm")
        XCTAssertEqual(vietnamese.read(86), "tám mươi sáu")
        XCTAssertEqual(vietnamese.read(87), "tám mươi bảy")
        XCTAssertEqual(vietnamese.read(88), "tám mươi tám")
        XCTAssertEqual(vietnamese.read(89), "tám mươi chín")
        XCTAssertEqual(vietnamese.read(90), "chín mươi")
        XCTAssertEqual(vietnamese.read(91), "chín mươi mốt")
        XCTAssertEqual(vietnamese.read(92), "chín mươi hai")
        XCTAssertEqual(vietnamese.read(93), "chín mươi ba")
        XCTAssertEqual(vietnamese.read(94), "chín mươi bốn")
        XCTAssertEqual(vietnamese.read(95), "chín mươi lăm")
        XCTAssertEqual(vietnamese.read(96), "chín mươi sáu")
        XCTAssertEqual(vietnamese.read(97), "chín mươi bảy")
        XCTAssertEqual(vietnamese.read(98), "chín mươi tám")
        XCTAssertEqual(vietnamese.read(99), "chín mươi chín")
        XCTAssertEqual(vietnamese.read(100), "một trăm")
        XCTAssertEqual(vietnamese.read(101), "một trăm lẻ một")
        XCTAssertEqual(vietnamese.read(102), "một trăm lẻ hai")
        XCTAssertEqual(vietnamese.read(103), "một trăm lẻ ba")
        XCTAssertEqual(vietnamese.read(104), "một trăm lẻ bốn")
        XCTAssertEqual(vietnamese.read(105), "một trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(106), "một trăm lẻ sáu")
        XCTAssertEqual(vietnamese.read(107), "một trăm lẻ bảy")
        XCTAssertEqual(vietnamese.read(108), "một trăm lẻ tám")
        XCTAssertEqual(vietnamese.read(109), "một trăm lẻ chín")
        
//        vietnamese.secondLast = .linh
//        XCTAssertEqual(vietnamese.read(101), "một trăm linh một")
//        XCTAssertEqual(vietnamese.read(102), "một trăm linh hai")
//        XCTAssertEqual(vietnamese.read(103), "một trăm linh ba")
//        XCTAssertEqual(vietnamese.read(104), "một trăm linh bốn")
//        XCTAssertEqual(vietnamese.read(105), "một trăm linh năm")
//        XCTAssertEqual(vietnamese.read(106), "một trăm linh sáu")
//        XCTAssertEqual(vietnamese.read(107), "một trăm linh bảy")
//        XCTAssertEqual(vietnamese.read(108), "một trăm linh tám")
//        XCTAssertEqual(vietnamese.read(109), "một trăm linh chín")
//        vietnamese.secondLast = .lẻ
//        
        XCTAssertEqual(vietnamese.read(110), "một trăm mười")
        XCTAssertEqual(vietnamese.read(111), "một trăm mười một")
        XCTAssertEqual(vietnamese.read(119), "một trăm mười chín")
        XCTAssertEqual(vietnamese.read(120), "một trăm hai mươi")
        XCTAssertEqual(vietnamese.read(121), "một trăm hai mươi mốt")
        XCTAssertEqual(vietnamese.read(190), "một trăm chín mươi")
        XCTAssertEqual(vietnamese.read(999), "chín trăm chín mươi chín")
        XCTAssertEqual(vietnamese.read(1000), "một nghìn")
        XCTAssertEqual(vietnamese.read(1001), "một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.read(1005), "một nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(1009), "một nghìn không trăm lẻ chín")
        XCTAssertEqual(vietnamese.read(1010), "một nghìn không trăm mười")
        XCTAssertEqual(vietnamese.read(1011), "một nghìn không trăm mười một")
        XCTAssertEqual(vietnamese.read(1012), "một nghìn không trăm mười hai")
        XCTAssertEqual(vietnamese.read(1015), "một nghìn không trăm mười lăm")
        XCTAssertEqual(vietnamese.read(1035), "một nghìn không trăm ba mươi lăm")
        XCTAssertEqual(vietnamese.read(1099), "một nghìn không trăm chín mươi chín")
        XCTAssertEqual(vietnamese.read(3000), "ba nghìn")
        XCTAssertEqual(vietnamese.read(1100), "một nghìn một trăm")
        XCTAssertEqual(vietnamese.read(1101), "một nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.read(1105), "một nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(1110), "một nghìn một trăm mười")
        XCTAssertEqual(vietnamese.read(1111), "một nghìn một trăm mười một")
        XCTAssertEqual(vietnamese.read(1115), "một nghìn một trăm mười lăm")
        XCTAssertEqual(vietnamese.read(1121), "một nghìn một trăm hai mươi mốt")
        XCTAssertEqual(vietnamese.read(1125), "một nghìn một trăm hai mươi lăm")
        XCTAssertEqual(vietnamese.read(3005), "ba nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(10000), "mười nghìn")
        XCTAssertEqual(vietnamese.read(10001), "mười nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.read(20001), "hai mươi nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.read(20010), "hai mươi nghìn không trăm mười")
        XCTAssertEqual(vietnamese.read(20101), "hai mươi nghìn một trăm lẻ một")
        XCTAssertEqual(vietnamese.read(201001), "hai trăm lẻ một nghìn không trăm lẻ một")
        XCTAssertEqual(vietnamese.read(502305), "năm trăm lẻ hai nghìn ba trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(999999), "chín trăm chín mươi chín nghìn chín trăm chín mươi chín")
        XCTAssertEqual(vietnamese.read(62_000_000), "sáu mươi hai triệu")
        XCTAssertEqual(vietnamese.read(62_003_005), "sáu mươi hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(62_003_105), "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
        XCTAssertEqual(vietnamese.read(62_003_155), "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm năm mươi lăm")
        XCTAssertEqual(vietnamese.read(99_000_000_909), "chín mươi chín tỷ chín trăm lẻ chín")
        XCTAssertEqual(vietnamese.read(99_999_999_999), "chín mươi chín tỷ chín trăm chín mươi chín triệu chín trăm chín mươi chín nghìn chín trăm chín mươi chín")
//        
//        vietnamese.compact = true
//        XCTAssertEqual(vietnamese.read(0), "không")
//        XCTAssertEqual(vietnamese.read(1), "một")
//        XCTAssertEqual(vietnamese.read(2), "hai")
//        XCTAssertEqual(vietnamese.read(3), "ba")
//        XCTAssertEqual(vietnamese.read(4), "bốn")
//        XCTAssertEqual(vietnamese.read(5), "năm")
//        XCTAssertEqual(vietnamese.read(6), "sáu")
//        XCTAssertEqual(vietnamese.read(7), "bảy")
//        XCTAssertEqual(vietnamese.read(8), "tám")
//        XCTAssertEqual(vietnamese.read(9), "chín")
//        XCTAssertEqual(vietnamese.read(10), "mười")
//        XCTAssertEqual(vietnamese.read(11), "mười một")
//        XCTAssertEqual(vietnamese.read(12), "mười hai")
//        XCTAssertEqual(vietnamese.read(13), "mười ba")
//        XCTAssertEqual(vietnamese.read(14), "mười bốn")
//        XCTAssertEqual(vietnamese.read(15), "mười lăm")
//        XCTAssertEqual(vietnamese.read(16), "mười sáu")
//        XCTAssertEqual(vietnamese.read(17), "mười bảy")
//        XCTAssertEqual(vietnamese.read(18), "mười tám")
//        XCTAssertEqual(vietnamese.read(19), "mười chín")
//        XCTAssertEqual(vietnamese.read(20), "hai mươi")
//        XCTAssertEqual(vietnamese.read(21), "hai mốt")
//        XCTAssertEqual(vietnamese.read(22), "hai hai")
//        XCTAssertEqual(vietnamese.read(23), "hai ba")
//        XCTAssertEqual(vietnamese.read(24), "hai bốn")
//        XCTAssertEqual(vietnamese.read(25), "hai lăm")
//        XCTAssertEqual(vietnamese.read(26), "hai sáu")
//        XCTAssertEqual(vietnamese.read(27), "hai bảy")
//        XCTAssertEqual(vietnamese.read(28), "hai tám")
//        XCTAssertEqual(vietnamese.read(29), "hai chín")
//        XCTAssertEqual(vietnamese.read(30), "ba mươi")
//        XCTAssertEqual(vietnamese.read(31), "ba mốt")
//        XCTAssertEqual(vietnamese.read(32), "ba hai")
//        XCTAssertEqual(vietnamese.read(33), "ba ba")
//        XCTAssertEqual(vietnamese.read(34), "ba bốn")
//        XCTAssertEqual(vietnamese.read(35), "ba lăm")
//        XCTAssertEqual(vietnamese.read(36), "ba sáu")
//        XCTAssertEqual(vietnamese.read(37), "ba bảy")
//        XCTAssertEqual(vietnamese.read(38), "ba tám")
//        XCTAssertEqual(vietnamese.read(39), "ba chín")
//        XCTAssertEqual(vietnamese.read(40), "bốn mươi")
//        XCTAssertEqual(vietnamese.read(41), "bốn mốt")
//        XCTAssertEqual(vietnamese.read(42), "bốn hai")
//        XCTAssertEqual(vietnamese.read(43), "bốn ba")
//        XCTAssertEqual(vietnamese.read(44), "bốn bốn")
//        XCTAssertEqual(vietnamese.read(45), "bốn lăm")
//        XCTAssertEqual(vietnamese.read(46), "bốn sáu")
//        XCTAssertEqual(vietnamese.read(47), "bốn bảy")
//        XCTAssertEqual(vietnamese.read(48), "bốn tám")
//        XCTAssertEqual(vietnamese.read(49), "bốn chín")
//        XCTAssertEqual(vietnamese.read(50), "năm mươi")
//        XCTAssertEqual(vietnamese.read(51), "năm mốt")
//        XCTAssertEqual(vietnamese.read(52), "năm hai")
//        XCTAssertEqual(vietnamese.read(53), "năm ba")
//        XCTAssertEqual(vietnamese.read(54), "năm bốn")
//        XCTAssertEqual(vietnamese.read(55), "năm lăm")
//        XCTAssertEqual(vietnamese.read(56), "năm sáu")
//        XCTAssertEqual(vietnamese.read(57), "năm bảy")
//        XCTAssertEqual(vietnamese.read(58), "năm tám")
//        XCTAssertEqual(vietnamese.read(59), "năm chín")
//        XCTAssertEqual(vietnamese.read(60), "sáu mươi")
//        XCTAssertEqual(vietnamese.read(61), "sáu mốt")
//        XCTAssertEqual(vietnamese.read(62), "sáu hai")
//        XCTAssertEqual(vietnamese.read(63), "sáu ba")
//        XCTAssertEqual(vietnamese.read(64), "sáu bốn")
//        XCTAssertEqual(vietnamese.read(65), "sáu lăm")
//        XCTAssertEqual(vietnamese.read(66), "sáu sáu")
//        XCTAssertEqual(vietnamese.read(67), "sáu bảy")
//        XCTAssertEqual(vietnamese.read(68), "sáu tám")
//        XCTAssertEqual(vietnamese.read(69), "sáu chín")
//        XCTAssertEqual(vietnamese.read(70), "bảy mươi")
//        XCTAssertEqual(vietnamese.read(71), "bảy mốt")
//        XCTAssertEqual(vietnamese.read(72), "bảy hai")
//        XCTAssertEqual(vietnamese.read(73), "bảy ba")
//        XCTAssertEqual(vietnamese.read(74), "bảy bốn")
//        XCTAssertEqual(vietnamese.read(75), "bảy lăm")
//        XCTAssertEqual(vietnamese.read(76), "bảy sáu")
//        XCTAssertEqual(vietnamese.read(77), "bảy bảy")
//        XCTAssertEqual(vietnamese.read(78), "bảy tám")
//        XCTAssertEqual(vietnamese.read(79), "bảy chín")
//        XCTAssertEqual(vietnamese.read(80), "tám mươi")
//        XCTAssertEqual(vietnamese.read(81), "tám mốt")
//        XCTAssertEqual(vietnamese.read(82), "tám hai")
//        XCTAssertEqual(vietnamese.read(83), "tám ba")
//        XCTAssertEqual(vietnamese.read(84), "tám bốn")
//        XCTAssertEqual(vietnamese.read(85), "tám lăm")
//        XCTAssertEqual(vietnamese.read(86), "tám sáu")
//        XCTAssertEqual(vietnamese.read(87), "tám bảy")
//        XCTAssertEqual(vietnamese.read(88), "tám tám")
//        XCTAssertEqual(vietnamese.read(89), "tám chín")
//        XCTAssertEqual(vietnamese.read(90), "chín mươi")
//        XCTAssertEqual(vietnamese.read(91), "chín mốt")
//        XCTAssertEqual(vietnamese.read(92), "chín hai")
//        XCTAssertEqual(vietnamese.read(93), "chín ba")
//        XCTAssertEqual(vietnamese.read(94), "chín bốn")
//        XCTAssertEqual(vietnamese.read(95), "chín lăm")
//        XCTAssertEqual(vietnamese.read(96), "chín sáu")
//        XCTAssertEqual(vietnamese.read(97), "chín bảy")
//        XCTAssertEqual(vietnamese.read(98), "chín tám")
//        XCTAssertEqual(vietnamese.read(99), "chín chín")
//        XCTAssertEqual(vietnamese.read(100), "một trăm")
//        XCTAssertEqual(vietnamese.read(101), "một trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(102), "một trăm lẻ hai")
//        XCTAssertEqual(vietnamese.read(103), "một trăm lẻ ba")
//        XCTAssertEqual(vietnamese.read(104), "một trăm lẻ bốn")
//        XCTAssertEqual(vietnamese.read(105), "một trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(106), "một trăm lẻ sáu")
//        XCTAssertEqual(vietnamese.read(107), "một trăm lẻ bảy")
//        XCTAssertEqual(vietnamese.read(108), "một trăm lẻ tám")
//        XCTAssertEqual(vietnamese.read(109), "một trăm lẻ chín")
//        
//        vietnamese.secondLast = .linh
//        XCTAssertEqual(vietnamese.read(101), "một trăm linh một")
//        XCTAssertEqual(vietnamese.read(102), "một trăm linh hai")
//        XCTAssertEqual(vietnamese.read(103), "một trăm linh ba")
//        XCTAssertEqual(vietnamese.read(104), "một trăm linh bốn")
//        XCTAssertEqual(vietnamese.read(105), "một trăm linh năm")
//        XCTAssertEqual(vietnamese.read(106), "một trăm linh sáu")
//        XCTAssertEqual(vietnamese.read(107), "một trăm linh bảy")
//        XCTAssertEqual(vietnamese.read(108), "một trăm linh tám")
//        XCTAssertEqual(vietnamese.read(109), "một trăm linh chín")
//        vietnamese.secondLast = .lẻ
//        
//        XCTAssertEqual(vietnamese.read(110), "một trăm mười")
//        XCTAssertEqual(vietnamese.read(111), "một trăm mười một")
//        XCTAssertEqual(vietnamese.read(119), "một trăm mười chín")
//        XCTAssertEqual(vietnamese.read(120), "một trăm hai mươi")
//        XCTAssertEqual(vietnamese.read(121), "một trăm hai mốt")
//        XCTAssertEqual(vietnamese.read(190), "một trăm chín mươi")
//        XCTAssertEqual(vietnamese.read(999), "chín trăm chín chín")
//        XCTAssertEqual(vietnamese.read(1_000), "một nghìn")
//        XCTAssertEqual(vietnamese.read(1_001), "một nghìn không trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(1_005), "một nghìn không trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(1_009), "một nghìn không trăm lẻ chín")
//        XCTAssertEqual(vietnamese.read(1_010), "một nghìn không trăm mười")
//        XCTAssertEqual(vietnamese.read(1_011), "một nghìn không trăm mười một")
//        XCTAssertEqual(vietnamese.read(1_012), "một nghìn không trăm mười hai")
//        XCTAssertEqual(vietnamese.read(1_015), "một nghìn không trăm mười lăm")
//        XCTAssertEqual(vietnamese.read(1_035), "một nghìn không trăm ba lăm")
//        XCTAssertEqual(vietnamese.read(1_099), "một nghìn không trăm chín chín")
//        XCTAssertEqual(vietnamese.read(1_100), "một nghìn một trăm")
//        XCTAssertEqual(vietnamese.read(1_101), "một nghìn một trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(1_105), "một nghìn một trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(1_110), "một nghìn một trăm mười")
//        XCTAssertEqual(vietnamese.read(1_111), "một nghìn một trăm mười một")
//        XCTAssertEqual(vietnamese.read(1_115), "một nghìn một trăm mười lăm")
//        XCTAssertEqual(vietnamese.read(1_121), "một nghìn một trăm hai mốt")
//        XCTAssertEqual(vietnamese.read(1_125), "một nghìn một trăm hai lăm")
//        XCTAssertEqual(vietnamese.read(10_000), "mười nghìn")
//        XCTAssertEqual(vietnamese.read(10_001), "mười nghìn không trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(20_001), "hai mươi nghìn không trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(20_010), "hai mươi nghìn không trăm mười")
//        XCTAssertEqual(vietnamese.read(201_01), "hai mươi nghìn một trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(201_001), "hai trăm lẻ một nghìn không trăm lẻ một")
//        XCTAssertEqual(vietnamese.read(502_305), "năm trăm lẻ hai nghìn ba trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(999_999), "chín trăm chín chín nghìn chín trăm chín chín")
//        XCTAssertEqual(vietnamese.read(62_000_000), "sáu hai triệu")
//        XCTAssertEqual(vietnamese.read(62_003_005), "sáu hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(62_003_105), "sáu hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
//        XCTAssertEqual(vietnamese.read(62_003_155), "sáu hai triệu không trăm lẻ ba nghìn một trăm năm lăm")
//        XCTAssertEqual(vietnamese.read(99_000_000_909), "chín chín tỷ chín trăm lẻ chín")
//        XCTAssertEqual(vietnamese.read(99_999_999_999), "chín chín tỷ chín trăm chín chín triệu chín trăm chín chín nghìn chín trăm chín chín")
    }
}