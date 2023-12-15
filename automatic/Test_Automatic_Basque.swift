//
//  Test_Automatic_Basque.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticBasque: XCTestCase {

    func test_automatic_basque() {
        let basque = TranslateBasque()
        basque.groupSeparator = ""
        basque.decimalSeparator = "."
        XCTAssertEqual(basque.translate(0), "zero")
        XCTAssertEqual(basque.translate(1), "bat")
        XCTAssertEqual(basque.translate(2), "bi")
        XCTAssertEqual(basque.translate(3), "hiru")
        XCTAssertEqual(basque.translate(4), "lau")
        XCTAssertEqual(basque.translate(5), "bost")
        XCTAssertEqual(basque.translate(6), "sei")
        XCTAssertEqual(basque.translate(7), "zazpi")
        XCTAssertEqual(basque.translate(8), "zortzi")
        XCTAssertEqual(basque.translate(9), "bederatzi")
        XCTAssertEqual(basque.translate(10), "hamar")
        XCTAssertEqual(basque.translate(11), "hamaika")
        XCTAssertEqual(basque.translate(12), "hamabi")
        XCTAssertEqual(basque.translate(13), "hamahiru")
        XCTAssertEqual(basque.translate(14), "hamalau")
        XCTAssertEqual(basque.translate(15), "hamabost")
        XCTAssertEqual(basque.translate(16), "hamasei")
        XCTAssertEqual(basque.translate(17), "hamazazpi")
        XCTAssertEqual(basque.translate(18), "hemezortzi")
        XCTAssertEqual(basque.translate(19), "hemeretzi")
        XCTAssertEqual(basque.translate(20), "hogei")
        XCTAssertEqual(basque.translate(21), "hogeitabat")
        XCTAssertEqual(basque.translate(22), "hogeitabi")
        XCTAssertEqual(basque.translate(23), "hogeitahiru")
        XCTAssertEqual(basque.translate(24), "hogeitalau")
        XCTAssertEqual(basque.translate(25), "hogeitabost")
        XCTAssertEqual(basque.translate(26), "hogeitasei")
        XCTAssertEqual(basque.translate(27), "hogeitazazpi")
        XCTAssertEqual(basque.translate(28), "hogeitazortzi")
        XCTAssertEqual(basque.translate(29), "hogeitabederatzi")
        XCTAssertEqual(basque.translate(20), "hogei")
        XCTAssertEqual(basque.translate(31), "hogeitahamaika")
        XCTAssertEqual(basque.translate(32), "hogeitahamabi")
        XCTAssertEqual(basque.translate(33), "hogeitahiru")
        XCTAssertEqual(basque.translate(34), "hogeitahamalau")
        XCTAssertEqual(basque.translate(35), "hogeitahamabost")
        XCTAssertEqual(basque.translate(36), "hogeitahamasei")
        XCTAssertEqual(basque.translate(37), "hogeitahamazazpi")
        XCTAssertEqual(basque.translate(38), "hogeitazortzi")
        XCTAssertEqual(basque.translate(39), "hogeitahemeretzi")
        XCTAssertEqual(basque.translate(40), "berrogei")
        XCTAssertEqual(basque.translate(41), "berrogeitabat")
        XCTAssertEqual(basque.translate(42), "berrogeitabi")
        XCTAssertEqual(basque.translate(43), "berrogeitahiru")
        XCTAssertEqual(basque.translate(44), "berrogeitalau")
        XCTAssertEqual(basque.translate(45), "berrogeitabost")
        XCTAssertEqual(basque.translate(46), "berrogeitasei")
        XCTAssertEqual(basque.translate(47), "berrogeitazazpi")
        XCTAssertEqual(basque.translate(48), "berrogeitazortzi")
        XCTAssertEqual(basque.translate(49), "berrogeitabederatzi")
        XCTAssertEqual(basque.translate(50), "berrogeitahamar")
        XCTAssertEqual(basque.translate(51), "berrogeitabat")
        XCTAssertEqual(basque.translate(52), "berrogeitabi")
        XCTAssertEqual(basque.translate(53), "berrogeitahiru")
        XCTAssertEqual(basque.translate(54), "berrogeitahamalau")
        XCTAssertEqual(basque.translate(55), "berrogeitabost")
        XCTAssertEqual(basque.translate(56), "berrogeitasei")
        XCTAssertEqual(basque.translate(57), "berrogeitazazpi")
        XCTAssertEqual(basque.translate(58), "berrogeitazortzi")
        XCTAssertEqual(basque.translate(59), "berrogeitahemeretzi")
        XCTAssertEqual(basque.translate(60), "hirurogei")
        XCTAssertEqual(basque.translate(61), "hirurogeitabat")
        XCTAssertEqual(basque.translate(62), "hirurogeitabi")
        XCTAssertEqual(basque.translate(63), "hirurogeitahiru")
        XCTAssertEqual(basque.translate(64), "hirurogeitalau")
        XCTAssertEqual(basque.translate(65), "hirurogeitabost")
        XCTAssertEqual(basque.translate(66), "hirurogeitasei")
        XCTAssertEqual(basque.translate(67), "hirurogeitazazpi")
        XCTAssertEqual(basque.translate(68), "hirurogeitazortzi")
        XCTAssertEqual(basque.translate(69), "hirurogeitabederatzi")
        XCTAssertEqual(basque.translate(70), "hirurogeitahamar")
        XCTAssertEqual(basque.translate(71), "hirurogeitabat")
        XCTAssertEqual(basque.translate(72), "hirurogeitabi")
        XCTAssertEqual(basque.translate(73), "hirurogeitahiru")
        XCTAssertEqual(basque.translate(74), "hirurogeitalau")
        XCTAssertEqual(basque.translate(75), "hirurogeitabost")
        XCTAssertEqual(basque.translate(76), "hirurogeitasei")
        XCTAssertEqual(basque.translate(77), "hirurogeitazazpi")
        XCTAssertEqual(basque.translate(78), "hirurogeitazortzi")
        XCTAssertEqual(basque.translate(79), "hirurogeitabederatzi")
        XCTAssertEqual(basque.translate(80), "laurogei")
        XCTAssertEqual(basque.translate(81), "laurogeitabat")
        XCTAssertEqual(basque.translate(82), "laurogeitabi")
        XCTAssertEqual(basque.translate(83), "laurogeitahiru")
        XCTAssertEqual(basque.translate(84), "laurogeitalau")
        XCTAssertEqual(basque.translate(85), "laurogeitabost")
        XCTAssertEqual(basque.translate(86), "laurogeitasei")
        XCTAssertEqual(basque.translate(87), "laurogeitazazpi")
        XCTAssertEqual(basque.translate(88), "laurogeitazortzi")
        XCTAssertEqual(basque.translate(89), "laurogeitabederatzi")
        XCTAssertEqual(basque.translate(90), "laurogeitahamar")
        XCTAssertEqual(basque.translate(91), "laurogeitabat")
        XCTAssertEqual(basque.translate(92), "laurogeitabi")
        XCTAssertEqual(basque.translate(93), "laurogeitahiru")
        XCTAssertEqual(basque.translate(94), "laurogeitalau")
        XCTAssertEqual(basque.translate(95), "laurogeitabost")
        XCTAssertEqual(basque.translate(96), "laurogeitasei")
        XCTAssertEqual(basque.translate(97), "laurogeitazazpi")
        XCTAssertEqual(basque.translate(98), "laurogeitazortzi")
        XCTAssertEqual(basque.translate(99), "laurogeitabederatzi")
        XCTAssertEqual(basque.translate(100), "ehun")
        XCTAssertEqual(basque.translate(101), "ehunbat")
        XCTAssertEqual(basque.translate(102), "ehunbi")
        XCTAssertEqual(basque.translate(103), "ehunhiru")
        XCTAssertEqual(basque.translate(104), "ehunlau")
        XCTAssertEqual(basque.translate(105), "ehunbost")
        XCTAssertEqual(basque.translate(106), "ehunsei")
        XCTAssertEqual(basque.translate(107), "ehunzazpi")
        XCTAssertEqual(basque.translate(108), "ehunzortzi")
        XCTAssertEqual(basque.translate(109), "ehunbederatzi")
        XCTAssertEqual(basque.translate(110), "ehunhamar")
        XCTAssertEqual(basque.translate(111), "ehunhamaika")
        XCTAssertEqual(basque.translate(112), "ehunhamabi")
        XCTAssertEqual(basque.translate(113), "ehunhamahiru")
        XCTAssertEqual(basque.translate(119), "ehunhemeretzi")
        XCTAssertEqual(basque.translate(120), "ehunhogei")
        XCTAssertEqual(basque.translate(121), "ehunhogeitabat")
        XCTAssertEqual(basque.translate(190), "ehunlaurogeitahamar")
        XCTAssertEqual(basque.translate(444), "laurehunberrogeitalau")
        XCTAssertEqual(basque.translate(999), "bederatziehunetalaurogeitabederatzi")
        XCTAssertEqual(basque.translate(1_000), "mila")
        XCTAssertEqual(basque.translate(1_001), "milabat")
        XCTAssertEqual(basque.translate(1_005), "milabost")
        XCTAssertEqual(basque.translate(1_009), "milabederatzi")
        XCTAssertEqual(basque.translate(1_010), "milahamar")
        XCTAssertEqual(basque.translate(1_011), "milahamaika")
        XCTAssertEqual(basque.translate(1_012), "milahamabi")
        XCTAssertEqual(basque.translate(1_015), "milahamabost")
        XCTAssertEqual(basque.translate(1_035), "milahogeitahamabost")
        XCTAssertEqual(basque.translate(1_099), "milalaurogeitabederatzi")
        XCTAssertEqual(basque.translate(1_100), "milaehunehun")
        XCTAssertEqual(basque.translate(1_101), "milaehunbat")
        XCTAssertEqual(basque.translate(1_105), "milaehunbost")
        XCTAssertEqual(basque.translate(1_110), "milaehunhamar")
        XCTAssertEqual(basque.translate(1_111), "milaehunhamaika")
        XCTAssertEqual(basque.translate(1_115), "milaehunhamabost")
        XCTAssertEqual(basque.translate(1_121), "milaehunhogeitabat")
        XCTAssertEqual(basque.translate(1_125), "milaehunhogeitabost")
        XCTAssertEqual(basque.translate(10_000), "hamarmila")
        XCTAssertEqual(basque.translate(10_001), "hamarmilabat")
        XCTAssertEqual(basque.translate(20_001), "hogeimilabat")
        XCTAssertEqual(basque.translate(20_010), "hogeimilahamar")
        XCTAssertEqual(basque.translate(20_101), "hogeimilaehunbat")
        XCTAssertEqual(basque.translate(201_001), "berrehunetamilabat")
        XCTAssertEqual(basque.translate(502_305), "bostehunetabimilahirurehunbost")
        XCTAssertEqual(basque.translate(999_999), "bederatziehunetalaurogeitabederatzimilabederatziehunetalaurogeitabederatzi")
        XCTAssertEqual(basque.translate(62_000_000), "hirurogeitahamabimilioi")
        XCTAssertEqual(basque.translate(62_003_005), "hirurogeitabimilioihirumilabost")
        XCTAssertEqual(basque.translate(62_003_105), "hirurogeitabimilioihirumilaehunbost")
        XCTAssertEqual(basque.translate(62_003_155), "hirurogeitahamabimilioihirumilaetaehunberrogeitabost")
        XCTAssertEqual(basque.translate(99_000_000_909), "laurogeitabederatzimilamilioibederatziehunbederatzi")
        XCTAssertEqual(basque.translate(99_999_999_999), "laurogeitabederatzimilamilioibederatziehunetalaurogeitabederatzimilioibederatziehunetalaurogeitabederatzimilabederatziehunetalaurogeitabederatzi")
        XCTAssertEqual(basque.translate(-1), "ken")
        XCTAssertEqual(basque.translate(-1.5), "kenpuntubatbost")
        XCTAssertEqual(basque.translate(1.5), "bostpuntu")
        XCTAssertEqual(basque.translate(3.1415926), "hirupuntulaubatbostbederatziseisei")
        XCTAssertEqual(basque.translate(-3.1415926), "kenhirupuntubatlaubatbostbederatziseisei")
        XCTAssertEqual(basque.translate(3.4E13), "hirupuntulaualdizhamahiru")
        }
}