//
//  Test_Automatic_Icelandic.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticIcelandic: XCTestCase {

    func test_automatic_icelandic() {
        let icelandic = TranslateIcelandic()
        icelandic.groupSeparator = ""
        icelandic.decimalSeparator = "."
        XCTAssertEqual(icelandic.translate(0), "núll")
        XCTAssertEqual(icelandic.translate(1), "einn")
        XCTAssertEqual(icelandic.translate(2), "tveir")
        XCTAssertEqual(icelandic.translate(3), "þrír")
        XCTAssertEqual(icelandic.translate(4), "fjórir")
        XCTAssertEqual(icelandic.translate(5), "fimm")
        XCTAssertEqual(icelandic.translate(6), "sex")
        XCTAssertEqual(icelandic.translate(7), "sjö")
        XCTAssertEqual(icelandic.translate(8), "átta")
        XCTAssertEqual(icelandic.translate(9), "níu")
        XCTAssertEqual(icelandic.translate(10), "tíu")
        XCTAssertEqual(icelandic.translate(11), "ellefu")
        XCTAssertEqual(icelandic.translate(12), "tólf")
        XCTAssertEqual(icelandic.translate(13), "þrettán")
        XCTAssertEqual(icelandic.translate(14), "fjórtán")
        XCTAssertEqual(icelandic.translate(15), "fimmtán")
        XCTAssertEqual(icelandic.translate(16), "sextán")
        XCTAssertEqual(icelandic.translate(17), "sautján")
        XCTAssertEqual(icelandic.translate(18), "átján")
        XCTAssertEqual(icelandic.translate(19), "nítján")
        XCTAssertEqual(icelandic.translate(20), "tuttugu")
        XCTAssertEqual(icelandic.translate(21), "tuttuguogeinn")
        XCTAssertEqual(icelandic.translate(22), "tuttuguogtveir")
        XCTAssertEqual(icelandic.translate(23), "tuttuguogþrír")
        XCTAssertEqual(icelandic.translate(24), "tuttuguogfjórir")
        XCTAssertEqual(icelandic.translate(25), "tuttuguogfimm")
        XCTAssertEqual(icelandic.translate(26), "tuttuguogsex")
        XCTAssertEqual(icelandic.translate(27), "tuttuguogsjö")
        XCTAssertEqual(icelandic.translate(28), "tuttuguogátta")
        XCTAssertEqual(icelandic.translate(29), "tuttuguogníu")
        XCTAssertEqual(icelandic.translate(20), "tuttugu")
        XCTAssertEqual(icelandic.translate(31), "þrjátíuogeinn")
        XCTAssertEqual(icelandic.translate(32), "þrjátíuogtveir")
        XCTAssertEqual(icelandic.translate(33), "þrjátíuogþrír")
        XCTAssertEqual(icelandic.translate(34), "þrjátíuogfjórir")
        XCTAssertEqual(icelandic.translate(35), "þrjátíuogfimm")
        XCTAssertEqual(icelandic.translate(36), "þrjátíuogsex")
        XCTAssertEqual(icelandic.translate(37), "þrjátíuogsjö")
        XCTAssertEqual(icelandic.translate(38), "þrjátíuogátta")
        XCTAssertEqual(icelandic.translate(39), "þrjátíuogníu")
        XCTAssertEqual(icelandic.translate(40), "fjörutíu")
        XCTAssertEqual(icelandic.translate(41), "fjörutíuogeinn")
        XCTAssertEqual(icelandic.translate(42), "fjörutíuogtveir")
        XCTAssertEqual(icelandic.translate(43), "fjörutíuogþrír")
        XCTAssertEqual(icelandic.translate(44), "fjörutíuogfjórir")
        XCTAssertEqual(icelandic.translate(45), "fjörutíuogfimm")
        XCTAssertEqual(icelandic.translate(46), "fjörutíuogsex")
        XCTAssertEqual(icelandic.translate(47), "fjörutíuogsjö")
        XCTAssertEqual(icelandic.translate(48), "fjörutíuogátta")
        XCTAssertEqual(icelandic.translate(49), "fjörutíuogníu")
        XCTAssertEqual(icelandic.translate(50), "fimmtíu")
        XCTAssertEqual(icelandic.translate(51), "fimmtíuogeinn")
        XCTAssertEqual(icelandic.translate(52), "fimmtíuogtveir")
        XCTAssertEqual(icelandic.translate(53), "fimmtíuogþrír")
        XCTAssertEqual(icelandic.translate(54), "fimmtíuogfjórir")
        XCTAssertEqual(icelandic.translate(55), "fimmtíuogfimm")
        XCTAssertEqual(icelandic.translate(56), "fimmtíuogsex")
        XCTAssertEqual(icelandic.translate(57), "fimmtíuogsjö")
        XCTAssertEqual(icelandic.translate(58), "fimmtíuogátta")
        XCTAssertEqual(icelandic.translate(59), "fimmtíuogníu")
        XCTAssertEqual(icelandic.translate(60), "sextíu")
        XCTAssertEqual(icelandic.translate(61), "sextíuogeinn")
        XCTAssertEqual(icelandic.translate(62), "sextíuogtveir")
        XCTAssertEqual(icelandic.translate(63), "sextíuogþrír")
        XCTAssertEqual(icelandic.translate(64), "sextíuogfjórir")
        XCTAssertEqual(icelandic.translate(65), "sextíuogfimm")
        XCTAssertEqual(icelandic.translate(66), "sextíuogsex")
        XCTAssertEqual(icelandic.translate(67), "sextíuogsjö")
        XCTAssertEqual(icelandic.translate(68), "sextíuogátta")
        XCTAssertEqual(icelandic.translate(69), "sextíuogníu")
        XCTAssertEqual(icelandic.translate(70), "sjötugur")
        XCTAssertEqual(icelandic.translate(71), "sjötíuogeinn")
        XCTAssertEqual(icelandic.translate(72), "sjötíuogtveir")
        XCTAssertEqual(icelandic.translate(73), "sjötíuogþrír")
        XCTAssertEqual(icelandic.translate(74), "sjötíuogfjórir")
        XCTAssertEqual(icelandic.translate(75), "sjötíuogfimm")
        XCTAssertEqual(icelandic.translate(76), "sjötíuogsex")
        XCTAssertEqual(icelandic.translate(77), "sjötíuogsjö")
        XCTAssertEqual(icelandic.translate(78), "sjötíuogátta")
        XCTAssertEqual(icelandic.translate(79), "sjötíuogníu")
        XCTAssertEqual(icelandic.translate(80), "áttatíu")
        XCTAssertEqual(icelandic.translate(81), "áttatíuogeinn")
        XCTAssertEqual(icelandic.translate(82), "áttatíuogtveir")
        XCTAssertEqual(icelandic.translate(83), "áttatíuogþrjú")
        XCTAssertEqual(icelandic.translate(84), "áttatíuogfjórir")
        XCTAssertEqual(icelandic.translate(85), "áttatíuogfimm")
        XCTAssertEqual(icelandic.translate(86), "áttatíuogsex")
        XCTAssertEqual(icelandic.translate(87), "áttatíuogsjö")
        XCTAssertEqual(icelandic.translate(88), "áttatíuogátta")
        XCTAssertEqual(icelandic.translate(89), "áttatíuogníu")
        XCTAssertEqual(icelandic.translate(90), "níutíu")
        XCTAssertEqual(icelandic.translate(91), "níutíuogeinn")
        XCTAssertEqual(icelandic.translate(92), "níutíuogtveir")
        XCTAssertEqual(icelandic.translate(93), "níutíuogþrír")
        XCTAssertEqual(icelandic.translate(94), "níutíuogfjórir")
        XCTAssertEqual(icelandic.translate(95), "níutíuogfimm")
        XCTAssertEqual(icelandic.translate(96), "níutíuogsex")
        XCTAssertEqual(icelandic.translate(97), "níutíuogsjö")
        XCTAssertEqual(icelandic.translate(98), "níutíuogátta")
        XCTAssertEqual(icelandic.translate(99), "níutíuogníu")
        XCTAssertEqual(icelandic.translate(100), "hundrað")
        XCTAssertEqual(icelandic.translate(101), "eitthundraðeitt")
        XCTAssertEqual(icelandic.translate(102), "eitthundraðtvö")
        XCTAssertEqual(icelandic.translate(103), "eitthundraðþrjú")
        XCTAssertEqual(icelandic.translate(104), "eitthundraðfjögur")
        XCTAssertEqual(icelandic.translate(105), "eitthundraðfimm")
        XCTAssertEqual(icelandic.translate(106), "hundraðsex")
        XCTAssertEqual(icelandic.translate(107), "hundraðsjö")
        XCTAssertEqual(icelandic.translate(108), "eitthundraðátta")
        XCTAssertEqual(icelandic.translate(109), "hundraðníu")
        XCTAssertEqual(icelandic.translate(110), "hundraðtíu")
        XCTAssertEqual(icelandic.translate(111), "hundraðellefu")
        XCTAssertEqual(icelandic.translate(112), "hundraðtólf")
        XCTAssertEqual(icelandic.translate(113), "hundraðþrettán")
        XCTAssertEqual(icelandic.translate(119), "hundraðnítján")
        XCTAssertEqual(icelandic.translate(120), "hundraðtuttugu")
        XCTAssertEqual(icelandic.translate(121), "hundraðtuttuguogeinn")
        XCTAssertEqual(icelandic.translate(190), "hundraðníutíu")
        XCTAssertEqual(icelandic.translate(444), "fjögurhundruðfjörutíuogfjórir")
        XCTAssertEqual(icelandic.translate(999), "níuhundruðníutíuogníu")
        XCTAssertEqual(icelandic.translate(1_000), "eittþúsund")
        XCTAssertEqual(icelandic.translate(1_001), "eittþúsund")
        XCTAssertEqual(icelandic.translate(1_005), "eittþúsundfimm")
        XCTAssertEqual(icelandic.translate(1_009), "eittþúsundníu")
        XCTAssertEqual(icelandic.translate(1_010), "eittþúsundtíu")
        XCTAssertEqual(icelandic.translate(1_011), "eittþúsundellefu")
        XCTAssertEqual(icelandic.translate(1_012), "eittþúsundtólf")
        XCTAssertEqual(icelandic.translate(1_015), "eittþúsundfimmtán")
        XCTAssertEqual(icelandic.translate(1_035), "eittþúsundþrjátíuogfimm")
        XCTAssertEqual(icelandic.translate(1_099), "eittþúsundníutíuogníu")
        XCTAssertEqual(icelandic.translate(1_100), "eittþúsundeitthundrað")
        XCTAssertEqual(icelandic.translate(1_101), "eittþúsundeitthundraðeitt")
        XCTAssertEqual(icelandic.translate(1_105), "eittþúsundeitthundraðfimm")
        XCTAssertEqual(icelandic.translate(1_110), "eittþúsundhundraðtíu")
        XCTAssertEqual(icelandic.translate(1_111), "eittþúsundhundraðellefu")
        XCTAssertEqual(icelandic.translate(1_115), "eittþúsundhundraðfimmtán")
        XCTAssertEqual(icelandic.translate(1_121), "eittþúsundhundraðtuttuguogeinn")
        XCTAssertEqual(icelandic.translate(1_125), "eittþúsundhundraðtuttuguogfimm")
        XCTAssertEqual(icelandic.translate(10_000), "tíuþúsund")
        XCTAssertEqual(icelandic.translate(10_001), "tíuþúsundeitt")
        XCTAssertEqual(icelandic.translate(20_001), "tuttuguþúsund")
        XCTAssertEqual(icelandic.translate(20_010), "tuttuguþúsundtíu")
        XCTAssertEqual(icelandic.translate(20_101), "tuttuguþúsundeitthundraðeitt")
        XCTAssertEqual(icelandic.translate(201_001), "tvöhundruðeittþúsundeitt")
        XCTAssertEqual(icelandic.translate(502_305), "fimmhundruðtvöþúsundþrjúhundruðfimm")
        XCTAssertEqual(icelandic.translate(999_999), "níuhundruðníutíuogníuþúsundníuhundruðníutíuogníu")
        XCTAssertEqual(icelandic.translate(62_000_000), "sextíuogtværmilljónir")
        XCTAssertEqual(icelandic.translate(62_003_005), "sextíuogtværmilljónirþriggjaþúsundfimm")
        XCTAssertEqual(icelandic.translate(62_003_105), "sextíuogtværmilljónirþrjúþúsundeitthundraðfimm")
        XCTAssertEqual(icelandic.translate(62_003_155), "sextíuogtvömilljónirþrjúþúsundhundraðfimmtíuogfimm")
        XCTAssertEqual(icelandic.translate(99_000_000_909), "níutíuogníumilljarðarníuhundruðníu")
        XCTAssertEqual(icelandic.translate(99_999_999_999), "níutíuogníumilljarðarníuhundruðníutíuogníumilljónirníuhundruðníutíuogníuþúsundníuhundruðníutíuogníu")
        XCTAssertEqual(icelandic.translate(-1), "mínuseinn")
        XCTAssertEqual(icelandic.translate(-1.5), "mínuseittstigfimm")
        XCTAssertEqual(icelandic.translate(1.5), "eittstigfimm")
        XCTAssertEqual(icelandic.translate(3.1415926), "þrjústigeittfjögureittfimmníutveirsex")
        XCTAssertEqual(icelandic.translate(-3.1415926), "mínusþriggjapunktaeittfjögureittfimmníutveirsex")
        XCTAssertEqual(icelandic.translate(3.4E13), "þrisvarsinnumfjórumsinnumtíutilkraftsþrettán")
        }
}