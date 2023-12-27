//
//  Test_Danish.swift
//
//  Created by automatic.py
//

import XCTest

final class TestDanish: XCTestCase {

    func test_danish() {
        let danish = TranslateNumber().danish
        
        XCTAssertEqual(danish.read(1_100), "ettusind og hundred")
        XCTAssertEqual(danish.read(2_500), "to tusinde og fem hundrede")
        XCTAssertEqual(danish.read(220_000), "to hundrede og tyve tusinde")

        XCTAssertEqual(danish.read(0), "nul")
        XCTAssertEqual(danish.read(1), "en")
        XCTAssertEqual(danish.read(2), "to")
        XCTAssertEqual(danish.read(3), "tre")
        XCTAssertEqual(danish.read(4), "fire")
        XCTAssertEqual(danish.read(5), "fem")
        XCTAssertEqual(danish.read(6), "seks")
        XCTAssertEqual(danish.read(7), "syv")
        XCTAssertEqual(danish.read(8), "otte")
        XCTAssertEqual(danish.read(9), "ni")
        XCTAssertEqual(danish.read(10), "ti")
        XCTAssertEqual(danish.read(11), "elleve")
        XCTAssertEqual(danish.read(12), "tolv")
        XCTAssertEqual(danish.read(13), "tretten")
        XCTAssertEqual(danish.read(14), "fjorten")
        XCTAssertEqual(danish.read(15), "femten")
        XCTAssertEqual(danish.read(16), "seksten")
        XCTAssertEqual(danish.read(17), "sytten")
        XCTAssertEqual(danish.read(18), "atten")
        XCTAssertEqual(danish.read(19), "nitten")
        XCTAssertEqual(danish.read(20), "tyve")
        XCTAssertEqual(danish.read(21), "enogtyve")
        XCTAssertEqual(danish.read(22), "toogtyve")
        XCTAssertEqual(danish.read(23), "treogtyve")
        XCTAssertEqual(danish.read(24), "fireogtyve")
        XCTAssertEqual(danish.read(25), "femogtyve")
        XCTAssertEqual(danish.read(26), "seksogtyve")
        XCTAssertEqual(danish.read(27), "syvogtyve")
        XCTAssertEqual(danish.read(28), "otteogtyve")
        XCTAssertEqual(danish.read(29), "niogtyve")
        XCTAssertEqual(danish.read(30), "tredive")
        XCTAssertEqual(danish.read(31), "enogtredive")
        XCTAssertEqual(danish.read(32), "toogtredive")
        XCTAssertEqual(danish.read(33), "treogtredive")
        XCTAssertEqual(danish.read(34), "fireogtredive")
        XCTAssertEqual(danish.read(35), "femogtredive")
        XCTAssertEqual(danish.read(36), "seksogtredive")
        XCTAssertEqual(danish.read(37), "syvogtredive")
        XCTAssertEqual(danish.read(38), "otteogtredive")
        XCTAssertEqual(danish.read(39), "niogtredive")
        XCTAssertEqual(danish.read(40), "fyrre")
        XCTAssertEqual(danish.read(41), "enogfyrre")
        XCTAssertEqual(danish.read(42), "toogfyrre")
        XCTAssertEqual(danish.read(43), "treogfyrre")
        XCTAssertEqual(danish.read(44), "fireogfyrre")
        XCTAssertEqual(danish.read(45), "femogfyrre")
        XCTAssertEqual(danish.read(46), "seksogfyrre")
        XCTAssertEqual(danish.read(47), "syvogfyrre")
        XCTAssertEqual(danish.read(48), "otteogfyrre")
        XCTAssertEqual(danish.read(49), "niogfyrre")
        XCTAssertEqual(danish.read(50), "halvtreds")
        XCTAssertEqual(danish.read(51), "enoghalvtreds")
        XCTAssertEqual(danish.read(52), "tooghalvtreds")
        XCTAssertEqual(danish.read(53), "treoghalvtreds")
        XCTAssertEqual(danish.read(54), "fireoghalvtreds")
        XCTAssertEqual(danish.read(55), "femoghalvtreds")
        XCTAssertEqual(danish.read(56), "seksoghalvtreds")
        XCTAssertEqual(danish.read(57), "syvoghalvtreds")
        XCTAssertEqual(danish.read(58), "otteoghalvtreds")
        XCTAssertEqual(danish.read(59), "nioghalvtreds")
        XCTAssertEqual(danish.read(60), "tres")
        XCTAssertEqual(danish.read(61), "enogtres")
        XCTAssertEqual(danish.read(62), "toogtres")
        XCTAssertEqual(danish.read(63), "treogtres")
        XCTAssertEqual(danish.read(64), "fireogtres")
        XCTAssertEqual(danish.read(65), "femogtres")
        XCTAssertEqual(danish.read(66), "seksogtres")
        XCTAssertEqual(danish.read(67), "syvogtres")
        XCTAssertEqual(danish.read(68), "otteogtres")
        XCTAssertEqual(danish.read(69), "niogtres")
        XCTAssertEqual(danish.read(70), "halvfjerds")
        XCTAssertEqual(danish.read(71), "enoghalvfjerds")
        XCTAssertEqual(danish.read(72), "tooghalvfjerds")
        XCTAssertEqual(danish.read(73), "treoghalvfjerds")
        XCTAssertEqual(danish.read(74), "fireoghalvfjerds")
        XCTAssertEqual(danish.read(75), "femoghalvfjerds")
        XCTAssertEqual(danish.read(76), "seksoghalvfjerds")
        XCTAssertEqual(danish.read(77), "syvoghalvfjerds")
        XCTAssertEqual(danish.read(78), "otteoghalvfjerds")
        XCTAssertEqual(danish.read(79), "nioghalvfjerds")
        XCTAssertEqual(danish.read(80), "firs")
        XCTAssertEqual(danish.read(81), "enogfirs")
        XCTAssertEqual(danish.read(82), "toogfirs")
        XCTAssertEqual(danish.read(83), "treogfirs")
        XCTAssertEqual(danish.read(84), "fireogfirs")
        XCTAssertEqual(danish.read(85), "femogfirs")
        XCTAssertEqual(danish.read(86), "seksogfirs")
        XCTAssertEqual(danish.read(87), "syvogfirs")
        XCTAssertEqual(danish.read(88), "otteogfirs")
        XCTAssertEqual(danish.read(89), "niogfirs")
        XCTAssertEqual(danish.read(90), "halvfems")
        XCTAssertEqual(danish.read(91), "enoghalvfems")
        XCTAssertEqual(danish.read(92), "tooghalvfems")
        XCTAssertEqual(danish.read(93), "treoghalvfems")
        XCTAssertEqual(danish.read(94), "fireoghalvfems")
        XCTAssertEqual(danish.read(95), "femoghalvfems")
        XCTAssertEqual(danish.read(96), "seksoghalvfems")
        XCTAssertEqual(danish.read(97), "syvoghalvfems")
        XCTAssertEqual(danish.read(98), "otteoghalvfems")
        XCTAssertEqual(danish.read(99), "nioghalvfems")
        XCTAssertEqual(danish.read(100), "hundred")
        XCTAssertEqual(danish.read(101), "hundred og en")
        XCTAssertEqual(danish.read(102), "hundred og to")
        XCTAssertEqual(danish.read(103), "hundred og tre")
        XCTAssertEqual(danish.read(104), "hundred og fire")
        XCTAssertEqual(danish.read(105), "hundred og fem")
        XCTAssertEqual(danish.read(106), "hundred og seks")
        XCTAssertEqual(danish.read(107), "hundred og syv")
        XCTAssertEqual(danish.read(108), "hundred og otte")
        XCTAssertEqual(danish.read(109), "hundred og ni")
        XCTAssertEqual(danish.read(110), "hundred og ti")
        XCTAssertEqual(danish.read(111), "hundred og elleve")
        XCTAssertEqual(danish.read(112), "hundred og tolv")
        XCTAssertEqual(danish.read(113), "hundred og tretten")
        XCTAssertEqual(danish.read(119), "hundred og nitten")
        XCTAssertEqual(danish.read(120), "hundred og tyve")
        XCTAssertEqual(danish.read(121), "hundred og enogtyve")
        XCTAssertEqual(danish.read(142), "hundred og toogfyrre")
        XCTAssertEqual(danish.read(190), "hundred og halvfems")
        XCTAssertEqual(danish.read(444), "fire hundrede og fireogfyrre")
        XCTAssertEqual(danish.read(999), "ni hundrede og nioghalvfems")
        XCTAssertEqual(danish.read(1_000), "ettusind")
        XCTAssertEqual(danish.read(1_001), "ettusind og en")
        XCTAssertEqual(danish.read(1_005), "ettusind og fem")
        XCTAssertEqual(danish.read(1_009), "ettusind og ni")
        XCTAssertEqual(danish.read(1_010), "ettusind og ti")
        XCTAssertEqual(danish.read(1_011), "ettusind og elleve")
        XCTAssertEqual(danish.read(1_012), "ettusind og tolv")
        XCTAssertEqual(danish.read(1_015), "ettusind og femten")
        XCTAssertEqual(danish.read(1_035), "ettusind og femogtredive")
        XCTAssertEqual(danish.read(1_099), "ettusind og nioghalvfems")
        XCTAssertEqual(danish.read(1_100), "ettusind og hundred")
        XCTAssertEqual(danish.read(1_101), "ettusind og hundred og en")
        XCTAssertEqual(danish.read(1_105), "ettusind og hundred og fem")
        XCTAssertEqual(danish.read(1_110), "ettusind og hundred og ti")
        XCTAssertEqual(danish.read(1_111), "ettusind og hundred og elleve")
        XCTAssertEqual(danish.read(1_115), "ettusind og hundred og femten")
        XCTAssertEqual(danish.read(1_121), "ettusind og hundred og enogtyve")
        XCTAssertEqual(danish.read(1_125), "ettusind og hundred og femogtyve")
        XCTAssertEqual(danish.read(3_000), "tre tusinde")
        XCTAssertEqual(danish.read(3_142), "tre tusinde og hundred og toogfyrre")
        XCTAssertEqual(danish.read(9_999), "ni tusinde og ni hundrede og nioghalvfems")
        XCTAssertEqual(danish.read(10_000), "ti tusinde")
        XCTAssertEqual(danish.read(10_001), "ti tusinde og en")
        XCTAssertEqual(danish.read(10_002), "ti tusinde og to")
        XCTAssertEqual(danish.read(20_001), "tyve tusinde og en")
        XCTAssertEqual(danish.read(20_010), "tyve tusinde og ti")
        XCTAssertEqual(danish.read(20_101), "tyve tusinde og hundred og en")
        XCTAssertEqual(danish.read(100_000), "hundrede tusinde")
        XCTAssertEqual(danish.read(201_001), "to hundrede og en tusinde og en")
        XCTAssertEqual(danish.read(502_305), "fem hundrede og to tusinde og tre hundrede og fem")
        XCTAssertEqual(danish.read(999_999), "ni hundrede og nioghalvfems tusinde og ni hundrede og nioghalvfems")
        XCTAssertEqual(danish.read(1_000_000), "en million")
        XCTAssertEqual(danish.read(62_000_000), "toogtres millioner")
        XCTAssertEqual(danish.read(62_003_005), "toogtres millioner og tre tusinde og fem")
        XCTAssertEqual(danish.read(62_003_105), "toogtres millioner og tre tusinde og hundred og fem")
        XCTAssertEqual(danish.read(62_003_155), "toogtres millioner og tre tusinde og hundred og femoghalvtreds")
        XCTAssertEqual(danish.read(99_999_999), "nioghalvfems millioner og ni hundrede og nioghalvfems tusinde og ni hundrede og nioghalvfems")
        XCTAssertEqual(danish.read(100_000_000), "hundrede millioner")
        XCTAssertEqual(danish.read(99_000_000_909), "nioghalvfems milliarder og ni hundrede og ni")
        XCTAssertEqual(danish.read(1_000_000_000_000), "en billion")
        XCTAssertEqual(danish.read(1_000_000_000_909), "en billion og ni hundrede og ni")
        XCTAssertEqual(danish.read(100_000_000_000_000), "hundrede billioner")
        XCTAssertEqual(danish.read(-1), "minus en")
        XCTAssertEqual(danish.read("-1.5"), "minus en komma fem")
        XCTAssertEqual(danish.read("1.5"), "en komma fem")
        XCTAssertEqual(danish.read("3.1415926"), "tre komma en fire en fem ni to seks")
        XCTAssertEqual(danish.read("-3.1415926"), "minus tre komma en fire en fem ni to seks")
        XCTAssertEqual(danish.read("3.4e22"), "tre komma fire gange ti i toogtyve")
    }
}
