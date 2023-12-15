//
//  Test_Automatic_Scots gaelic.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticScots gaelic: XCTestCase {

    func test_automatic_scots gaelic() {
        let scots gaelic = TranslateScots gaelic()
        scots gaelic.groupSeparator = ""
        scots gaelic.decimalSeparator = "."
        XCTAssertEqual(scots gaelic.translate(0), "neoni")
        XCTAssertEqual(scots gaelic.translate(1), "aon")
        XCTAssertEqual(scots gaelic.translate(2), "dhà")
        XCTAssertEqual(scots gaelic.translate(3), "trì")
        XCTAssertEqual(scots gaelic.translate(4), "ceithir")
        XCTAssertEqual(scots gaelic.translate(5), "còig")
        XCTAssertEqual(scots gaelic.translate(6), "sia")
        XCTAssertEqual(scots gaelic.translate(7), "seachd")
        XCTAssertEqual(scots gaelic.translate(8), "Ochd")
        XCTAssertEqual(scots gaelic.translate(9), "naoi")
        XCTAssertEqual(scots gaelic.translate(10), "deich")
        XCTAssertEqual(scots gaelic.translate(11), "aon-deug")
        XCTAssertEqual(scots gaelic.translate(12), "dusan")
        XCTAssertEqual(scots gaelic.translate(13), "trì-deug")
        XCTAssertEqual(scots gaelic.translate(14), "ceithir-deug")
        XCTAssertEqual(scots gaelic.translate(15), "còig-deug")
        XCTAssertEqual(scots gaelic.translate(16), "sia-deug")
        XCTAssertEqual(scots gaelic.translate(17), "seachd-deug")
        XCTAssertEqual(scots gaelic.translate(18), "ochd-deug")
        XCTAssertEqual(scots gaelic.translate(19), "naoi-deug")
        XCTAssertEqual(scots gaelic.translate(20), "fichead")
        XCTAssertEqual(scots gaelic.translate(21), "fichead'sah-aon")
        XCTAssertEqual(scots gaelic.translate(22), "fichead'sadhà")
        XCTAssertEqual(scots gaelic.translate(23), "fichead'satrì")
        XCTAssertEqual(scots gaelic.translate(24), "ceithirairfhichead")
        XCTAssertEqual(scots gaelic.translate(25), "còigairfhichead")
        XCTAssertEqual(scots gaelic.translate(26), "fichead'sasia")
        XCTAssertEqual(scots gaelic.translate(27), "fichead'saseachd")
        XCTAssertEqual(scots gaelic.translate(28), "Ochdfichead")
        XCTAssertEqual(scots gaelic.translate(29), "fichead'sanaoi")
        XCTAssertEqual(scots gaelic.translate(20), "fichead")
        XCTAssertEqual(scots gaelic.translate(31), "Trithead'sah-One")
        XCTAssertEqual(scots gaelic.translate(32), "Trithead'sadhà")
        XCTAssertEqual(scots gaelic.translate(33), "trithead'satrì")
        XCTAssertEqual(scots gaelic.translate(34), "trithead'saceithir")
        XCTAssertEqual(scots gaelic.translate(35), "trithead'sacòig")
        XCTAssertEqual(scots gaelic.translate(36), "trithead'sasia")
        XCTAssertEqual(scots gaelic.translate(37), "Trithead'saseachd")
        XCTAssertEqual(scots gaelic.translate(38), "trithead'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(39), "trithead'sanaoi")
        XCTAssertEqual(scots gaelic.translate(40), "ceathrad")
        XCTAssertEqual(scots gaelic.translate(41), "ceathrad'sah-aon")
        XCTAssertEqual(scots gaelic.translate(42), "Dàfhicheadsadhà")
        XCTAssertEqual(scots gaelic.translate(43), "ceathrad'satrì")
        XCTAssertEqual(scots gaelic.translate(44), "ceathrad'saceithir")
        XCTAssertEqual(scots gaelic.translate(45), "ceathrad'sacòig")
        XCTAssertEqual(scots gaelic.translate(46), "ceathrad'sasia")
        XCTAssertEqual(scots gaelic.translate(47), "ceathrad'saseachd")
        XCTAssertEqual(scots gaelic.translate(48), "ceathrad'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(49), "ceathrad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(50), "leth-cheud")
        XCTAssertEqual(scots gaelic.translate(51), "leth-cheud'sah-aon")
        XCTAssertEqual(scots gaelic.translate(52), "leth-cheud'sadhà")
        XCTAssertEqual(scots gaelic.translate(53), "leth-cheud'satrì")
        XCTAssertEqual(scots gaelic.translate(54), "leth-cheud'saceithir")
        XCTAssertEqual(scots gaelic.translate(55), "leth-cheud'sacòig")
        XCTAssertEqual(scots gaelic.translate(56), "leth-cheud'sasia")
        XCTAssertEqual(scots gaelic.translate(57), "leth-cheud'saseachd")
        XCTAssertEqual(scots gaelic.translate(58), "leth-cheud'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(59), "leth-cheud'sanaoi")
        XCTAssertEqual(scots gaelic.translate(60), "Seasgad")
        XCTAssertEqual(scots gaelic.translate(61), "seasgad'sah-aon")
        XCTAssertEqual(scots gaelic.translate(62), "seasgad'sadhà")
        XCTAssertEqual(scots gaelic.translate(63), "seasgad'satrì")
        XCTAssertEqual(scots gaelic.translate(64), "seasgad'saceithir")
        XCTAssertEqual(scots gaelic.translate(65), "seasgad'sacòig")
        XCTAssertEqual(scots gaelic.translate(66), "Seasgad'sasia")
        XCTAssertEqual(scots gaelic.translate(67), "seasgad'saseachd")
        XCTAssertEqual(scots gaelic.translate(68), "seasgad'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(69), "seasgad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(70), "seachdad")
        XCTAssertEqual(scots gaelic.translate(71), "seachdad'sah-aon")
        XCTAssertEqual(scots gaelic.translate(72), "seachdad'sadhà")
        XCTAssertEqual(scots gaelic.translate(73), "seachdad'satrì")
        XCTAssertEqual(scots gaelic.translate(74), "seachdad'saceithir")
        XCTAssertEqual(scots gaelic.translate(75), "seachdad'sacòig")
        XCTAssertEqual(scots gaelic.translate(76), "seachdad'sasia")
        XCTAssertEqual(scots gaelic.translate(77), "seachdad'saseachd")
        XCTAssertEqual(scots gaelic.translate(78), "seachdad'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(79), "seachdad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(80), "ceithirfichead")
        XCTAssertEqual(scots gaelic.translate(81), "ceithirfichead'sah-aon")
        XCTAssertEqual(scots gaelic.translate(82), "ceithirficheadsadhà")
        XCTAssertEqual(scots gaelic.translate(83), "ceithirficheadsatrì")
        XCTAssertEqual(scots gaelic.translate(84), "ceithirficheadsaceithir")
        XCTAssertEqual(scots gaelic.translate(85), "ceithirficheadsacòig")
        XCTAssertEqual(scots gaelic.translate(86), "ceithirficheadsasia")
        XCTAssertEqual(scots gaelic.translate(87), "ceithirficheadsaseachd")
        XCTAssertEqual(scots gaelic.translate(88), "ceithirficheadsah-ochd")
        XCTAssertEqual(scots gaelic.translate(89), "ceithirficheadsanaoi")
        XCTAssertEqual(scots gaelic.translate(90), "naochad")
        XCTAssertEqual(scots gaelic.translate(91), "naochad'sah-aon")
        XCTAssertEqual(scots gaelic.translate(92), "naochad'sadhà")
        XCTAssertEqual(scots gaelic.translate(93), "naceithirficheadsatrì")
        XCTAssertEqual(scots gaelic.translate(94), "naochad'saceithir")
        XCTAssertEqual(scots gaelic.translate(95), "naochad'sacòig")
        XCTAssertEqual(scots gaelic.translate(96), "naochad'sasia")
        XCTAssertEqual(scots gaelic.translate(97), "naochad'saseachd")
        XCTAssertEqual(scots gaelic.translate(98), "naochad'sah-ochd")
        XCTAssertEqual(scots gaelic.translate(99), "naochad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(100), "ceud")
        XCTAssertEqual(scots gaelic.translate(101), "ceudfear")
        XCTAssertEqual(scots gaelic.translate(102), "ceuddhà")
        XCTAssertEqual(scots gaelic.translate(103), "ceudtrì")
        XCTAssertEqual(scots gaelic.translate(104), "ceudceithir")
        XCTAssertEqual(scots gaelic.translate(105), "ceudcòig")
        XCTAssertEqual(scots gaelic.translate(106), "ceudsia")
        XCTAssertEqual(scots gaelic.translate(107), "ceudseachd")
        XCTAssertEqual(scots gaelic.translate(108), "ceudochd")
        XCTAssertEqual(scots gaelic.translate(109), "ceudnaoi")
        XCTAssertEqual(scots gaelic.translate(110), "ceuddeich")
        XCTAssertEqual(scots gaelic.translate(111), "ceudaon-deug")
        XCTAssertEqual(scots gaelic.translate(112), "ceuddusandusan")
        XCTAssertEqual(scots gaelic.translate(113), "ceudtrì-deug")
        XCTAssertEqual(scots gaelic.translate(119), "ceudnaoibliadhnadeug")
        XCTAssertEqual(scots gaelic.translate(120), "ceudfichead")
        XCTAssertEqual(scots gaelic.translate(121), "ceudfichead'sah-aon")
        XCTAssertEqual(scots gaelic.translate(190), "ceudnaochad")
        XCTAssertEqual(scots gaelic.translate(444), "ceithircheudceathrad'saceithir")
        XCTAssertEqual(scots gaelic.translate(999), "naoiceudnaochad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(1_000), "mìle")
        XCTAssertEqual(scots gaelic.translate(1_001), "mìleaon")
        XCTAssertEqual(scots gaelic.translate(1_005), "mìlecòig")
        XCTAssertEqual(scots gaelic.translate(1_009), "mìlenaoi")
        XCTAssertEqual(scots gaelic.translate(1_010), "mìledeich")
        XCTAssertEqual(scots gaelic.translate(1_011), "mìleaon-deug")
        XCTAssertEqual(scots gaelic.translate(1_012), "mìleadhà-dheug")
        XCTAssertEqual(scots gaelic.translate(1_015), "mìlecòig-deug")
        XCTAssertEqual(scots gaelic.translate(1_035), "mìletrithead'sacòig")
        XCTAssertEqual(scots gaelic.translate(1_099), "mìleceithirfichead'sanaoi")
        XCTAssertEqual(scots gaelic.translate(1_100), "mìleceudceud")
        XCTAssertEqual(scots gaelic.translate(1_101), "mìleceudaon")
        XCTAssertEqual(scots gaelic.translate(1_105), "mìleceudcòig")
        XCTAssertEqual(scots gaelic.translate(1_110), "mìleceuddeich")
        XCTAssertEqual(scots gaelic.translate(1_111), "mìleceudaon-deug")
        XCTAssertEqual(scots gaelic.translate(1_115), "mìleceudcòig-deug")
        XCTAssertEqual(scots gaelic.translate(1_121), "mìleceudfichead'sah-aon")
        XCTAssertEqual(scots gaelic.translate(1_125), "mìleceudfichead'sacòig")
        XCTAssertEqual(scots gaelic.translate(10_000), "deichmìle")
        XCTAssertEqual(scots gaelic.translate(10_001), "deichmìlefear")
        XCTAssertEqual(scots gaelic.translate(20_001), "ficheadmìleah-aon")
        XCTAssertEqual(scots gaelic.translate(20_010), "ficheadmìledeich")
        XCTAssertEqual(scots gaelic.translate(20_101), "ficheadmìleceudfear")
        XCTAssertEqual(scots gaelic.translate(201_001), "dàcheudmìlefear")
        XCTAssertEqual(scots gaelic.translate(502_305), "còigceuddàmhìletrìcheudcòig")
        XCTAssertEqual(scots gaelic.translate(999_999), "naoiceudnaochad'sanaoimìlenaoiceudnaochad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(62_000_000), "seasgad'sadhàmillean")
        XCTAssertEqual(scots gaelic.translate(62_003_005), "seasgad'sadhàmilleantrìmìleacòig")
        XCTAssertEqual(scots gaelic.translate(62_003_105), "seasgad'sadhàmilleantrìmìleceudcòig")
        XCTAssertEqual(scots gaelic.translate(62_003_155), "seasgad'sadhàmilleantrìmìletrìmìleceudleth-cheud'sacòig")
        XCTAssertEqual(scots gaelic.translate(99_000_000_909), "naochad'sanaoibilleandenaoiceudnaoi")
        XCTAssertEqual(scots gaelic.translate(99_999_999_999), "naoibileag-sanaoiceudnaochad'sanaoiceudnaochad'sanaoiceudnaochad'sanaoi")
        XCTAssertEqual(scots gaelic.translate(-1), "minusaon")
        XCTAssertEqual(scots gaelic.translate(-1.5), "minusaonphuingcòig")
        XCTAssertEqual(scots gaelic.translate(1.5), "aonphuingcòig")
        XCTAssertEqual(scots gaelic.translate(3.1415926), "Thogtrìpuingaonceithiraoncòignaoidhà")
        XCTAssertEqual(scots gaelic.translate(-3.1415926), "minustrìpuingaonceithirceithiraoncòignaoidhà")
        XCTAssertEqual(scots gaelic.translate(3.4e13), "Trìpuingceithirtursandeichgucumhachdtrì-deug")
        }
}