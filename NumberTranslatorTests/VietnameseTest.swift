// Note: This file is automatically generated
//       It will be overwritten when testing

import Testing
@testable import NumberTranslator

@Test func Vietnamese() {
    let translator = VietnameseImplementation()

    translator.vietnameseCompact = false

    translator.vietnameseThousand = .nghìn

    translator.vietnameseSecondLast = .lẻ
    #expect(translator.translate(0).x == "không")
    #expect(translator.translate(1).x == "một")
    #expect(translator.translate(2).x == "hai")
    #expect(translator.translate(3).x == "ba")
    #expect(translator.translate(4).x == "bốn")
    #expect(translator.translate(5).x == "năm")
    #expect(translator.translate(6).x == "sáu")
    #expect(translator.translate(7).x == "bảy")
    #expect(translator.translate(8).x == "tám")
    #expect(translator.translate(9).x == "chín")
    #expect(translator.translate(10).x == "mười")
    #expect(translator.translate(11).x == "mười một")
    #expect(translator.translate(12).x == "mười hai")
    #expect(translator.translate(13).x == "mười ba")
    #expect(translator.translate(14).x == "mười bốn")
    #expect(translator.translate(15).x == "mười lăm")
    #expect(translator.translate(16).x == "mười sáu")
    #expect(translator.translate(17).x == "mười bảy")
    #expect(translator.translate(18).x == "mười tám")
    #expect(translator.translate(19).x == "mười chín")
    #expect(translator.translate(20).x == "hai mươi")
    #expect(translator.translate(21).x == "hai mươi mốt")
    #expect(translator.translate(22).x == "hai mươi hai")
    #expect(translator.translate(23).x == "hai mươi ba")
    #expect(translator.translate(24).x == "hai mươi bốn")
    #expect(translator.translate(25).x == "hai mươi lăm")
    #expect(translator.translate(26).x == "hai mươi sáu")
    #expect(translator.translate(27).x == "hai mươi bảy")
    #expect(translator.translate(28).x == "hai mươi tám")
    #expect(translator.translate(29).x == "hai mươi chín")
    #expect(translator.translate(30).x == "ba mươi")
    #expect(translator.translate(31).x == "ba mươi mốt")
    #expect(translator.translate(32).x == "ba mươi hai")
    #expect(translator.translate(33).x == "ba mươi ba")
    #expect(translator.translate(34).x == "ba mươi bốn")
    #expect(translator.translate(35).x == "ba mươi lăm")
    #expect(translator.translate(36).x == "ba mươi sáu")
    #expect(translator.translate(37).x == "ba mươi bảy")
    #expect(translator.translate(38).x == "ba mươi tám")
    #expect(translator.translate(39).x == "ba mươi chín")
    #expect(translator.translate(40).x == "bốn mươi")
    #expect(translator.translate(41).x == "bốn mươi mốt")
    #expect(translator.translate(42).x == "bốn mươi hai")
    #expect(translator.translate(43).x == "bốn mươi ba")
    #expect(translator.translate(44).x == "bốn mươi bốn")
    #expect(translator.translate(45).x == "bốn mươi lăm")
    #expect(translator.translate(46).x == "bốn mươi sáu")
    #expect(translator.translate(47).x == "bốn mươi bảy")
    #expect(translator.translate(48).x == "bốn mươi tám")
    #expect(translator.translate(49).x == "bốn mươi chín")
    #expect(translator.translate(50).x == "năm mươi")
    #expect(translator.translate(51).x == "năm mươi mốt")
    #expect(translator.translate(52).x == "năm mươi hai")
    #expect(translator.translate(53).x == "năm mươi ba")
    #expect(translator.translate(54).x == "năm mươi bốn")
    #expect(translator.translate(55).x == "năm mươi lăm")
    #expect(translator.translate(56).x == "năm mươi sáu")
    #expect(translator.translate(57).x == "năm mươi bảy")
    #expect(translator.translate(58).x == "năm mươi tám")
    #expect(translator.translate(59).x == "năm mươi chín")
    #expect(translator.translate(60).x == "sáu mươi")
    #expect(translator.translate(61).x == "sáu mươi mốt")
    #expect(translator.translate(62).x == "sáu mươi hai")
    #expect(translator.translate(63).x == "sáu mươi ba")
    #expect(translator.translate(64).x == "sáu mươi bốn")
    #expect(translator.translate(65).x == "sáu mươi lăm")
    #expect(translator.translate(66).x == "sáu mươi sáu")
    #expect(translator.translate(67).x == "sáu mươi bảy")
    #expect(translator.translate(68).x == "sáu mươi tám")
    #expect(translator.translate(69).x == "sáu mươi chín")
    #expect(translator.translate(70).x == "bảy mươi")
    #expect(translator.translate(71).x == "bảy mươi mốt")
    #expect(translator.translate(72).x == "bảy mươi hai")
    #expect(translator.translate(73).x == "bảy mươi ba")
    #expect(translator.translate(74).x == "bảy mươi bốn")
    #expect(translator.translate(75).x == "bảy mươi lăm")
    #expect(translator.translate(76).x == "bảy mươi sáu")
    #expect(translator.translate(77).x == "bảy mươi bảy")
    #expect(translator.translate(78).x == "bảy mươi tám")
    #expect(translator.translate(79).x == "bảy mươi chín")
    #expect(translator.translate(80).x == "tám mươi")
    #expect(translator.translate(81).x == "tám mươi mốt")
    #expect(translator.translate(82).x == "tám mươi hai")
    #expect(translator.translate(83).x == "tám mươi ba")
    #expect(translator.translate(84).x == "tám mươi bốn")
    #expect(translator.translate(85).x == "tám mươi lăm")
    #expect(translator.translate(86).x == "tám mươi sáu")
    #expect(translator.translate(87).x == "tám mươi bảy")
    #expect(translator.translate(88).x == "tám mươi tám")
    #expect(translator.translate(89).x == "tám mươi chín")
    #expect(translator.translate(90).x == "chín mươi")
    #expect(translator.translate(91).x == "chín mươi mốt")
    #expect(translator.translate(92).x == "chín mươi hai")
    #expect(translator.translate(93).x == "chín mươi ba")
    #expect(translator.translate(94).x == "chín mươi bốn")
    #expect(translator.translate(95).x == "chín mươi lăm")
    #expect(translator.translate(96).x == "chín mươi sáu")
    #expect(translator.translate(97).x == "chín mươi bảy")
    #expect(translator.translate(98).x == "chín mươi tám")
    #expect(translator.translate(99).x == "chín mươi chín")
    #expect(translator.translate(100).x == "một trăm")
    #expect(translator.translate(101).x == "một trăm lẻ một")
    #expect(translator.translate(102).x == "một trăm lẻ hai")
    #expect(translator.translate(103).x == "một trăm lẻ ba")
    #expect(translator.translate(104).x == "một trăm lẻ bốn")
    #expect(translator.translate(105).x == "một trăm lẻ năm")
    #expect(translator.translate(106).x == "một trăm lẻ sáu")
    #expect(translator.translate(107).x == "một trăm lẻ bảy")
    #expect(translator.translate(108).x == "một trăm lẻ tám")
    #expect(translator.translate(109).x == "một trăm lẻ chín")

    translator.vietnameseSecondLast = .linh
    #expect(translator.translate(101).x == "một trăm linh một")
    #expect(translator.translate(102).x == "một trăm linh hai")
    #expect(translator.translate(103).x == "một trăm linh ba")
    #expect(translator.translate(104).x == "một trăm linh bốn")
    #expect(translator.translate(105).x == "một trăm linh năm")
    #expect(translator.translate(106).x == "một trăm linh sáu")
    #expect(translator.translate(107).x == "một trăm linh bảy")
    #expect(translator.translate(108).x == "một trăm linh tám")
    #expect(translator.translate(109).x == "một trăm linh chín")

    translator.vietnameseSecondLast = .lẻ
    #expect(translator.translate(110).x == "một trăm mười")
    #expect(translator.translate(111).x == "một trăm mười một")
    #expect(translator.translate(119).x == "một trăm mười chín")
    #expect(translator.translate(120).x == "một trăm hai mươi")
    #expect(translator.translate(121).x == "một trăm hai mươi mốt")
    #expect(translator.translate(190).x == "một trăm chín mươi")
    #expect(translator.translate(999).x == "chín trăm chín mươi chín")
    #expect(translator.translate(1_000).x == "một nghìn")
    #expect(translator.translate(1_001).x == "một nghìn không trăm lẻ một")
    #expect(translator.translate(1_005).x == "một nghìn không trăm lẻ năm")
    #expect(translator.translate(1_009).x == "một nghìn không trăm lẻ chín")
    #expect(translator.translate(1_010).x == "một nghìn không trăm mười")
    #expect(translator.translate(1_011).x == "một nghìn không trăm mười một")
    #expect(translator.translate(1_012).x == "một nghìn không trăm mười hai")
    #expect(translator.translate(1_015).x == "một nghìn không trăm mười lăm")
    #expect(translator.translate(1_035).x == "một nghìn không trăm ba mươi lăm")
    #expect(translator.translate(1_099).x == "một nghìn không trăm chín mươi chín")
    #expect(translator.translate(3_000).x == "ba nghìn")
    #expect(translator.translate(1_100).x == "một nghìn một trăm")
    #expect(translator.translate(1_101).x == "một nghìn một trăm lẻ một")
    #expect(translator.translate(1_105).x == "một nghìn một trăm lẻ năm")
    #expect(translator.translate(1_110).x == "một nghìn một trăm mười")
    #expect(translator.translate(1_111).x == "một nghìn một trăm mười một")
    #expect(translator.translate(1_115).x == "một nghìn một trăm mười lăm")
    #expect(translator.translate(1_121).x == "một nghìn một trăm hai mươi mốt")
    #expect(translator.translate(1_125).x == "một nghìn một trăm hai mươi lăm")
    #expect(translator.translate(2_002).x == "hai nghìn không trăm lẻ hai")
    #expect(translator.translate(3_005).x == "ba nghìn không trăm lẻ năm")
    #expect(translator.translate(10_000).x == "mười nghìn")
    #expect(translator.translate(10_001).x == "mười nghìn không trăm lẻ một")
    #expect(translator.translate(20_001).x == "hai mươi nghìn không trăm lẻ một")
    #expect(translator.translate(20_010).x == "hai mươi nghìn không trăm mười")
    #expect(translator.translate(34_000).x == "ba mươi bốn nghìn")
    #expect(translator.translate(38_003).x == "ba mươi tám nghìn không trăm lẻ ba")
    // vạn is 10000
    // 34_000 Ba vạn bốn nghìn is not wrong
    // 34_200 Ba vạn bốn nghìn hai trăm
    #expect(translator.translate(52_425).x == "năm mươi hai nghìn bốn trăm hai mươi lăm")
    #expect(translator.translate(20_101).x == "hai mươi nghìn một trăm lẻ một")
    #expect(translator.translate(201_001).x == "hai trăm lẻ một nghìn không trăm lẻ một")
    #expect(translator.translate(502_305).x == "năm trăm lẻ hai nghìn ba trăm lẻ năm")
    #expect(translator.translate(999_999).x == "chín trăm chín mươi chín nghìn chín trăm chín mươi chín")
    #expect(translator.translate(1_000_000).x == "một triệu")
    #expect(translator.translate(1_000_003).x == "một triệu không trăm lẻ ba")
    #expect(translator.translate(1_000_010).x == "một triệu không trăm mười")
    #expect(translator.translate(1_000_011).x == "một triệu không trăm mười một")
    #expect(translator.translate(1_000_111).x == "một triệu một trăm mười một")
    // một or mốt ????  1_000_011 một triệu không trăm mười mốt
    // một or mốt ????  1_000_111 một triệu mốt trăm mười mốt
    // không trăm lẻ or not???
    #expect(translator.translate(1_003_000).x == "một triệu không trăm lẻ ba nghìn")
    #expect(translator.translate(3_009_000).x == "ba triệu không trăm lẻ chín nghìn")
    #expect(translator.translate(1_000_000_000).x == "một tỷ")
    #expect(translator.translate(1_000_000_003).x == "một tỷ không trăm lẻ ba")
    #expect(translator.translate(62_000_000).x == "sáu mươi hai triệu")
    #expect(translator.translate(62_003_005).x == "sáu mươi hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
    #expect(translator.translate(62_003_105).x == "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
    #expect(translator.translate(62_003_155).x == "sáu mươi hai triệu không trăm lẻ ba nghìn một trăm năm mươi lăm")
    #expect(translator.translate(99_000_000_909).x == "chín mươi chín tỷ chín trăm lẻ chín")
    #expect(translator.translate(99_999_999_999).x == "chín mươi chín tỷ chín trăm chín mươi chín triệu chín trăm chín mươi chín nghìn chín trăm chín mươi chín")

    translator.vietnameseCompact = true
    #expect(translator.translate(0).x == "không")
    #expect(translator.translate(1).x == "một")
    #expect(translator.translate(2).x == "hai")
    #expect(translator.translate(3).x == "ba")
    #expect(translator.translate(4).x == "bốn")
    #expect(translator.translate(5).x == "năm")
    #expect(translator.translate(6).x == "sáu")
    #expect(translator.translate(7).x == "bảy")
    #expect(translator.translate(8).x == "tám")
    #expect(translator.translate(9).x == "chín")
    #expect(translator.translate(10).x == "mười")
    #expect(translator.translate(11).x == "mười một")
    #expect(translator.translate(12).x == "mười hai")
    #expect(translator.translate(13).x == "mười ba")
    #expect(translator.translate(14).x == "mười bốn")
    #expect(translator.translate(15).x == "mười lăm")
    #expect(translator.translate(16).x == "mười sáu")
    #expect(translator.translate(17).x == "mười bảy")
    #expect(translator.translate(18).x == "mười tám")
    #expect(translator.translate(19).x == "mười chín")
    #expect(translator.translate(20).x == "hai mươi")
    #expect(translator.translate(21).x == "hai mốt")
    #expect(translator.translate(22).x == "hai hai")
    #expect(translator.translate(23).x == "hai ba")
    #expect(translator.translate(24).x == "hai bốn")
    #expect(translator.translate(25).x == "hai lăm")
    #expect(translator.translate(26).x == "hai sáu")
    #expect(translator.translate(27).x == "hai bảy")
    #expect(translator.translate(28).x == "hai tám")
    #expect(translator.translate(29).x == "hai chín")
    #expect(translator.translate(30).x == "ba mươi")
    #expect(translator.translate(31).x == "ba mốt")
    #expect(translator.translate(32).x == "ba hai")
    #expect(translator.translate(33).x == "ba ba")
    #expect(translator.translate(34).x == "ba bốn")
    #expect(translator.translate(35).x == "ba lăm")
    #expect(translator.translate(36).x == "ba sáu")
    #expect(translator.translate(37).x == "ba bảy")
    #expect(translator.translate(38).x == "ba tám")
    #expect(translator.translate(39).x == "ba chín")
    #expect(translator.translate(40).x == "bốn mươi")
    #expect(translator.translate(41).x == "bốn mốt")
    #expect(translator.translate(42).x == "bốn hai")
    #expect(translator.translate(43).x == "bốn ba")
    #expect(translator.translate(44).x == "bốn bốn")
    #expect(translator.translate(45).x == "bốn lăm")
    #expect(translator.translate(46).x == "bốn sáu")
    #expect(translator.translate(47).x == "bốn bảy")
    #expect(translator.translate(48).x == "bốn tám")
    #expect(translator.translate(49).x == "bốn chín")
    #expect(translator.translate(50).x == "năm mươi")
    #expect(translator.translate(51).x == "năm mốt")
    #expect(translator.translate(52).x == "năm hai")
    #expect(translator.translate(53).x == "năm ba")
    #expect(translator.translate(54).x == "năm bốn")
    #expect(translator.translate(55).x == "năm lăm")
    #expect(translator.translate(56).x == "năm sáu")
    #expect(translator.translate(57).x == "năm bảy")
    #expect(translator.translate(58).x == "năm tám")
    #expect(translator.translate(59).x == "năm chín")
    #expect(translator.translate(60).x == "sáu mươi")
    #expect(translator.translate(61).x == "sáu mốt")
    #expect(translator.translate(62).x == "sáu hai")
    #expect(translator.translate(63).x == "sáu ba")
    #expect(translator.translate(64).x == "sáu bốn")
    #expect(translator.translate(65).x == "sáu lăm")
    #expect(translator.translate(66).x == "sáu sáu")
    #expect(translator.translate(67).x == "sáu bảy")
    #expect(translator.translate(68).x == "sáu tám")
    #expect(translator.translate(69).x == "sáu chín")
    #expect(translator.translate(70).x == "bảy mươi")
    #expect(translator.translate(71).x == "bảy mốt")
    #expect(translator.translate(72).x == "bảy hai")
    #expect(translator.translate(73).x == "bảy ba")
    #expect(translator.translate(74).x == "bảy bốn")
    #expect(translator.translate(75).x == "bảy lăm")
    #expect(translator.translate(76).x == "bảy sáu")
    #expect(translator.translate(77).x == "bảy bảy")
    #expect(translator.translate(78).x == "bảy tám")
    #expect(translator.translate(79).x == "bảy chín")
    #expect(translator.translate(80).x == "tám mươi")
    #expect(translator.translate(81).x == "tám mốt")
    #expect(translator.translate(82).x == "tám hai")
    #expect(translator.translate(83).x == "tám ba")
    #expect(translator.translate(84).x == "tám bốn")
    #expect(translator.translate(85).x == "tám lăm")
    #expect(translator.translate(86).x == "tám sáu")
    #expect(translator.translate(87).x == "tám bảy")
    #expect(translator.translate(88).x == "tám tám")
    #expect(translator.translate(89).x == "tám chín")
    #expect(translator.translate(90).x == "chín mươi")
    #expect(translator.translate(91).x == "chín mốt")
    #expect(translator.translate(92).x == "chín hai")
    #expect(translator.translate(93).x == "chín ba")
    #expect(translator.translate(94).x == "chín bốn")
    #expect(translator.translate(95).x == "chín lăm")
    #expect(translator.translate(96).x == "chín sáu")
    #expect(translator.translate(97).x == "chín bảy")
    #expect(translator.translate(98).x == "chín tám")
    #expect(translator.translate(99).x == "chín chín")
    #expect(translator.translate(100).x == "một trăm")
    #expect(translator.translate(101).x == "một trăm lẻ một")
    #expect(translator.translate(102).x == "một trăm lẻ hai")
    #expect(translator.translate(103).x == "một trăm lẻ ba")
    #expect(translator.translate(104).x == "một trăm lẻ bốn")
    #expect(translator.translate(105).x == "một trăm lẻ năm")
    #expect(translator.translate(106).x == "một trăm lẻ sáu")
    #expect(translator.translate(107).x == "một trăm lẻ bảy")
    #expect(translator.translate(108).x == "một trăm lẻ tám")
    #expect(translator.translate(109).x == "một trăm lẻ chín")

    translator.vietnameseSecondLast = .linh
    #expect(translator.translate(101).x == "một trăm linh một")
    #expect(translator.translate(102).x == "một trăm linh hai")
    #expect(translator.translate(103).x == "một trăm linh ba")
    #expect(translator.translate(104).x == "một trăm linh bốn")
    #expect(translator.translate(105).x == "một trăm linh năm")
    #expect(translator.translate(106).x == "một trăm linh sáu")
    #expect(translator.translate(107).x == "một trăm linh bảy")
    #expect(translator.translate(108).x == "một trăm linh tám")
    #expect(translator.translate(109).x == "một trăm linh chín")

    translator.vietnameseSecondLast = .lẻ
    #expect(translator.translate(110).x == "một trăm mười")
    #expect(translator.translate(111).x == "một trăm mười một")
    #expect(translator.translate(119).x == "một trăm mười chín")
    #expect(translator.translate(120).x == "một trăm hai mươi")
    #expect(translator.translate(121).x == "một trăm hai mốt")
    #expect(translator.translate(190).x == "một trăm chín mươi")
    #expect(translator.translate(999).x == "chín trăm chín chín")
    #expect(translator.translate(1_000).x == "một nghìn")
    #expect(translator.translate(1_001).x == "một nghìn không trăm lẻ một")
    #expect(translator.translate(1_005).x == "một nghìn không trăm lẻ năm")
    #expect(translator.translate(1_009).x == "một nghìn không trăm lẻ chín")
    #expect(translator.translate(1_010).x == "một nghìn không trăm mười")
    #expect(translator.translate(1_011).x == "một nghìn không trăm mười một")
    #expect(translator.translate(1_012).x == "một nghìn không trăm mười hai")
    #expect(translator.translate(1_015).x == "một nghìn không trăm mười lăm")
    #expect(translator.translate(1_035).x == "một nghìn không trăm ba lăm")
    #expect(translator.translate(1_099).x == "một nghìn không trăm chín chín")
    #expect(translator.translate(1_100).x == "một nghìn một trăm")
    #expect(translator.translate(1_101).x == "một nghìn một trăm lẻ một")
    #expect(translator.translate(1_105).x == "một nghìn một trăm lẻ năm")
    #expect(translator.translate(1_110).x == "một nghìn một trăm mười")
    #expect(translator.translate(1_111).x == "một nghìn một trăm mười một")
    #expect(translator.translate(1_115).x == "một nghìn một trăm mười lăm")
    #expect(translator.translate(1_121).x == "một nghìn một trăm hai mốt")
    #expect(translator.translate(1_125).x == "một nghìn một trăm hai lăm")
    #expect(translator.translate(10_000).x == "mười nghìn")
    #expect(translator.translate(10_001).x == "mười nghìn không trăm lẻ một")
    #expect(translator.translate(20_001).x == "hai mươi nghìn không trăm lẻ một")
    #expect(translator.translate(20_010).x == "hai mươi nghìn không trăm mười")
    #expect(translator.translate(201_01).x == "hai mươi nghìn một trăm lẻ một")
    #expect(translator.translate(201_001).x == "hai trăm lẻ một nghìn không trăm lẻ một")
    #expect(translator.translate(502_305).x == "năm trăm lẻ hai nghìn ba trăm lẻ năm")
    #expect(translator.translate(999_999).x == "chín trăm chín chín nghìn chín trăm chín chín")
    #expect(translator.translate(62_000_000).x == "sáu hai triệu")
    #expect(translator.translate(62_003_005).x == "sáu hai triệu không trăm lẻ ba nghìn không trăm lẻ năm")
    #expect(translator.translate(62_003_105).x == "sáu hai triệu không trăm lẻ ba nghìn một trăm lẻ năm")
    #expect(translator.translate(62_003_155).x == "sáu hai triệu không trăm lẻ ba nghìn một trăm năm lăm")
    #expect(translator.translate(99_000_000_909).x == "chín chín tỷ chín trăm lẻ chín")
    #expect(translator.translate(99_999_999_999).x == "chín chín tỷ chín trăm chín chín triệu chín trăm chín chín nghìn chín trăm chín chín")

    translator.vietnameseThousand = .nghìn
    #expect(translator.translate(1_000_000_000_000).x == "một nghìn tỷ")
    #expect(translator.translate(999_000_000_000_000).x == "chín trăm chín chín nghìn tỷ")
    #expect(translator.translate(1_000_000_000_003).x == "một nghìn tỷ không trăm lẻ ba")

    translator.vietnameseThousand = .ngàn
    #expect(translator.translate(1_000_000_000_000).x == "một ngàn tỷ")
    #expect(translator.translate(999_000_000_000_000).x == "chín trăm chín chín ngàn tỷ")
}