//
//  Test_Automatic_Norwegian.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticNorwegian: XCTestCase {

    func test_automatic_norwegian() {
        let norwegian = TranslateNorwegian()
        norwegian.groupSeparator = ""
        norwegian.decimalSeparator = "."
        XCTAssertEqual(norwegian.translate(0), "null")
        XCTAssertEqual(norwegian.translate(1), "en")
        XCTAssertEqual(norwegian.translate(2), "to")
        XCTAssertEqual(norwegian.translate(3), "tre")
        XCTAssertEqual(norwegian.translate(4), "fire")
        XCTAssertEqual(norwegian.translate(5), "fem")
        XCTAssertEqual(norwegian.translate(6), "seks")
        XCTAssertEqual(norwegian.translate(7), "syv")
        XCTAssertEqual(norwegian.translate(8), "åtte")
        XCTAssertEqual(norwegian.translate(9), "ni")
        XCTAssertEqual(norwegian.translate(10), "ti")
        XCTAssertEqual(norwegian.translate(11), "elleve")
        XCTAssertEqual(norwegian.translate(12), "tolv")
        XCTAssertEqual(norwegian.translate(13), "tretten")
        XCTAssertEqual(norwegian.translate(14), "fjorten")
        XCTAssertEqual(norwegian.translate(15), "femten")
        XCTAssertEqual(norwegian.translate(16), "seksten")
        XCTAssertEqual(norwegian.translate(17), "sytten")
        XCTAssertEqual(norwegian.translate(18), "atten")
        XCTAssertEqual(norwegian.translate(19), "nitten")
        XCTAssertEqual(norwegian.translate(20), "tjue")
        XCTAssertEqual(norwegian.translate(21), "21")
        XCTAssertEqual(norwegian.translate(22), "tjueto")
        XCTAssertEqual(norwegian.translate(23), "tjuetre")
        XCTAssertEqual(norwegian.translate(24), "tjuefire")
        XCTAssertEqual(norwegian.translate(25), "tjuefem")
        XCTAssertEqual(norwegian.translate(26), "tjueseks")
        XCTAssertEqual(norwegian.translate(27), "tjuesju")
        XCTAssertEqual(norwegian.translate(28), "tjueåtte")
        XCTAssertEqual(norwegian.translate(29), "tjueen")
        XCTAssertEqual(norwegian.translate(20), "tjue")
        XCTAssertEqual(norwegian.translate(31), "trettini")
        XCTAssertEqual(norwegian.translate(32), "trettito")
        XCTAssertEqual(norwegian.translate(33), "tretti-tre")
        XCTAssertEqual(norwegian.translate(34), "trettifire")
        XCTAssertEqual(norwegian.translate(35), "trettifem")
        XCTAssertEqual(norwegian.translate(36), "trettiseks")
        XCTAssertEqual(norwegian.translate(37), "trettisju")
        XCTAssertEqual(norwegian.translate(38), "trettiåtte")
        XCTAssertEqual(norwegian.translate(39), "tretti-ni")
        XCTAssertEqual(norwegian.translate(40), "førti")
        XCTAssertEqual(norwegian.translate(41), "førti-en")
        XCTAssertEqual(norwegian.translate(42), "førti-to")
        XCTAssertEqual(norwegian.translate(43), "førti-tre")
        XCTAssertEqual(norwegian.translate(44), "førtifire")
        XCTAssertEqual(norwegian.translate(45), "førtifem")
        XCTAssertEqual(norwegian.translate(46), "førti-seks")
        XCTAssertEqual(norwegian.translate(47), "førti-syv")
        XCTAssertEqual(norwegian.translate(48), "førtiåtte")
        XCTAssertEqual(norwegian.translate(49), "førti-ni")
        XCTAssertEqual(norwegian.translate(50), "femti")
        XCTAssertEqual(norwegian.translate(51), "femti")
        XCTAssertEqual(norwegian.translate(52), "femti-to")
        XCTAssertEqual(norwegian.translate(53), "femti-tre")
        XCTAssertEqual(norwegian.translate(54), "femti-fire")
        XCTAssertEqual(norwegian.translate(55), "femtifem")
        XCTAssertEqual(norwegian.translate(56), "femti-seks")
        XCTAssertEqual(norwegian.translate(57), "femti-syv")
        XCTAssertEqual(norwegian.translate(58), "femtiåtte")
        XCTAssertEqual(norwegian.translate(59), "femti-ni")
        XCTAssertEqual(norwegian.translate(60), "seksti")
        XCTAssertEqual(norwegian.translate(61), "seksti")
        XCTAssertEqual(norwegian.translate(62), "seksti-to")
        XCTAssertEqual(norwegian.translate(63), "seksti-tre")
        XCTAssertEqual(norwegian.translate(64), "sekstifire")
        XCTAssertEqual(norwegian.translate(65), "sekstifem")
        XCTAssertEqual(norwegian.translate(66), "seksti-seks")
        XCTAssertEqual(norwegian.translate(67), "seksti-syv")
        XCTAssertEqual(norwegian.translate(68), "sekstiåtte")
        XCTAssertEqual(norwegian.translate(69), "seksti-ni")
        XCTAssertEqual(norwegian.translate(70), "sytti")
        XCTAssertEqual(norwegian.translate(71), "sytti")
        XCTAssertEqual(norwegian.translate(72), "syttito")
        XCTAssertEqual(norwegian.translate(73), "sytti-tre")
        XCTAssertEqual(norwegian.translate(74), "syttifire")
        XCTAssertEqual(norwegian.translate(75), "syttifem")
        XCTAssertEqual(norwegian.translate(76), "syttiseks")
        XCTAssertEqual(norwegian.translate(77), "syttisju")
        XCTAssertEqual(norwegian.translate(78), "syttiåtte")
        XCTAssertEqual(norwegian.translate(79), "sytti-ni")
        XCTAssertEqual(norwegian.translate(80), "åtti")
        XCTAssertEqual(norwegian.translate(81), "åtti")
        XCTAssertEqual(norwegian.translate(82), "åttito")
        XCTAssertEqual(norwegian.translate(83), "åttitre")
        XCTAssertEqual(norwegian.translate(84), "åttifire")
        XCTAssertEqual(norwegian.translate(85), "åttifem")
        XCTAssertEqual(norwegian.translate(86), "åttiseks")
        XCTAssertEqual(norwegian.translate(87), "åttisju")
        XCTAssertEqual(norwegian.translate(88), "åttiåtte")
        XCTAssertEqual(norwegian.translate(89), "åtti-ni")
        XCTAssertEqual(norwegian.translate(90), "nitti")
        XCTAssertEqual(norwegian.translate(91), "nittini")
        XCTAssertEqual(norwegian.translate(92), "nittito")
        XCTAssertEqual(norwegian.translate(93), "nitti-tre")
        XCTAssertEqual(norwegian.translate(94), "nittifire")
        XCTAssertEqual(norwegian.translate(95), "nittifem")
        XCTAssertEqual(norwegian.translate(96), "nitti-seks")
        XCTAssertEqual(norwegian.translate(97), "nitti-syv")
        XCTAssertEqual(norwegian.translate(98), "nittiåtte")
        XCTAssertEqual(norwegian.translate(99), "nittini")
        XCTAssertEqual(norwegian.translate(100), "hundre")
        XCTAssertEqual(norwegian.translate(101), "hundreen")
        XCTAssertEqual(norwegian.translate(102), "hundreto")
        XCTAssertEqual(norwegian.translate(103), "hundretre")
        XCTAssertEqual(norwegian.translate(104), "hundrefire")
        XCTAssertEqual(norwegian.translate(105), "hundrefem")
        XCTAssertEqual(norwegian.translate(106), "hundreseks")
        XCTAssertEqual(norwegian.translate(107), "hundresyv")
        XCTAssertEqual(norwegian.translate(108), "hundreåtte")
        XCTAssertEqual(norwegian.translate(109), "hundreni")
        XCTAssertEqual(norwegian.translate(110), "hundreti")
        XCTAssertEqual(norwegian.translate(111), "hundreelleve")
        XCTAssertEqual(norwegian.translate(112), "hundretolv")
        XCTAssertEqual(norwegian.translate(113), "hundretretten")
        XCTAssertEqual(norwegian.translate(119), "hundrenitten")
        XCTAssertEqual(norwegian.translate(120), "hundretjue")
        XCTAssertEqual(norwegian.translate(121), "hundretjueen")
        XCTAssertEqual(norwegian.translate(190), "hundrenitti")
        XCTAssertEqual(norwegian.translate(444), "firehundreførtifire")
        XCTAssertEqual(norwegian.translate(999), "nihundrenittini")
        XCTAssertEqual(norwegian.translate(1_000), "tusen")
        XCTAssertEqual(norwegian.translate(1_001), "tusenen")
        XCTAssertEqual(norwegian.translate(1_005), "tusenfem")
        XCTAssertEqual(norwegian.translate(1_009), "tusenni")
        XCTAssertEqual(norwegian.translate(1_010), "tusenti")
        XCTAssertEqual(norwegian.translate(1_011), "tusenelleve")
        XCTAssertEqual(norwegian.translate(1_012), "tusentolv")
        XCTAssertEqual(norwegian.translate(1_015), "tusenfemten")
        XCTAssertEqual(norwegian.translate(1_035), "tusentrettifem")
        XCTAssertEqual(norwegian.translate(1_099), "tusennittini")
        XCTAssertEqual(norwegian.translate(1_100), "tusenhundre")
        XCTAssertEqual(norwegian.translate(1_101), "tusenhundreen")
        XCTAssertEqual(norwegian.translate(1_105), "tusenhundrefem")
        XCTAssertEqual(norwegian.translate(1_110), "tusenhundreti")
        XCTAssertEqual(norwegian.translate(1_111), "tusenhundreelleve")
        XCTAssertEqual(norwegian.translate(1_115), "tusenhundrefemten")
        XCTAssertEqual(norwegian.translate(1_121), "tusenhundretjueen")
        XCTAssertEqual(norwegian.translate(1_125), "tusenhundretjuefem")
        XCTAssertEqual(norwegian.translate(10_000), "titusen")
        XCTAssertEqual(norwegian.translate(10_001), "titusenen")
        XCTAssertEqual(norwegian.translate(20_001), "tjuetusenen")
        XCTAssertEqual(norwegian.translate(20_010), "tjuetusenti")
        XCTAssertEqual(norwegian.translate(20_101), "tjuetusenhundreen")
        XCTAssertEqual(norwegian.translate(201_001), "tohundretusenen")
        XCTAssertEqual(norwegian.translate(502_305), "femhundretotusentrehundrefem")
        XCTAssertEqual(norwegian.translate(999_999), "nihundrenittinitusennihundrenittini")
        XCTAssertEqual(norwegian.translate(62_000_000), "seksti-tomillioner")
        XCTAssertEqual(norwegian.translate(62_003_005), "seksti-tomillionertretusenfem")
        XCTAssertEqual(norwegian.translate(62_003_105), "seksti-tomillionertretusenhundrefem")
        XCTAssertEqual(norwegian.translate(62_003_155), "seksti-tomillionertretusenhundrefemtifem")
        XCTAssertEqual(norwegian.translate(99_000_000_909), "nittinimilliardernihundreni")
        XCTAssertEqual(norwegian.translate(99_999_999_999), "nittinimilliardernihundrenittinimillionernihundrenittinitusennihundrenittini")
        XCTAssertEqual(norwegian.translate(-1), "minusen")
        XCTAssertEqual(norwegian.translate(-15), "minusettpoengfem")
        XCTAssertEqual(norwegian.translate(1.5), "ettpunktfem")
        XCTAssertEqual(norwegian.translate(3.1415926), "trepunktenfireenfemnitoseks")
        XCTAssertEqual(norwegian.translate(-3.1415926), "minustrepunktenfireenfemnitoseks")
        XCTAssertEqual(norwegian.translate(3.4e13), "trepoengfiregangertitiltrettenkraft")
        }
}