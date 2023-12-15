//
//  Test_Automatic_Malay.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticMalay: XCTestCase {

    func test_automatic_malay() {
        let malay = TranslateMalay()
        malay.groupSeparator = ""
        malay.decimalSeparator = "."
        XCTAssertEqual(malay.translate(0), "sifar")
        XCTAssertEqual(malay.translate(1), "satu")
        XCTAssertEqual(malay.translate(2), "dua")
        XCTAssertEqual(malay.translate(3), "tiga")
        XCTAssertEqual(malay.translate(4), "empat")
        XCTAssertEqual(malay.translate(5), "lima")
        XCTAssertEqual(malay.translate(6), "enam")
        XCTAssertEqual(malay.translate(7), "tujuh")
        XCTAssertEqual(malay.translate(8), "lapan")
        XCTAssertEqual(malay.translate(9), "sembilan")
        XCTAssertEqual(malay.translate(10), "Sepuluh")
        XCTAssertEqual(malay.translate(11), "sebelas")
        XCTAssertEqual(malay.translate(12), "duabelas")
        XCTAssertEqual(malay.translate(13), "tigabelas")
        XCTAssertEqual(malay.translate(14), "empatbelas")
        XCTAssertEqual(malay.translate(15), "limabelas")
        XCTAssertEqual(malay.translate(16), "enambelas")
        XCTAssertEqual(malay.translate(17), "tujuhbelas")
        XCTAssertEqual(malay.translate(18), "lapanbelas")
        XCTAssertEqual(malay.translate(19), "sembilanbelas")
        XCTAssertEqual(malay.translate(20), "duapuluh")
        XCTAssertEqual(malay.translate(21), "duapuluhsatu")
        XCTAssertEqual(malay.translate(22), "duapuluhdua")
        XCTAssertEqual(malay.translate(23), "duapuluhtiga")
        XCTAssertEqual(malay.translate(24), "duapuluhempat")
        XCTAssertEqual(malay.translate(25), "duapuluhlima")
        XCTAssertEqual(malay.translate(26), "duapuluhenam")
        XCTAssertEqual(malay.translate(27), "duapuluhtujuh")
        XCTAssertEqual(malay.translate(28), "duapuluhlapan")
        XCTAssertEqual(malay.translate(29), "duapuluhsembilan")
        XCTAssertEqual(malay.translate(20), "duapuluh")
        XCTAssertEqual(malay.translate(31), "tigapuluhsatu")
        XCTAssertEqual(malay.translate(32), "tigapuluhdua")
        XCTAssertEqual(malay.translate(33), "tigapuluhtiga")
        XCTAssertEqual(malay.translate(34), "tigapuluhempat")
        XCTAssertEqual(malay.translate(35), "tigapuluhlima")
        XCTAssertEqual(malay.translate(36), "tigapuluhenam")
        XCTAssertEqual(malay.translate(37), "tigapuluhtujuh")
        XCTAssertEqual(malay.translate(38), "tigapuluhlapan")
        XCTAssertEqual(malay.translate(39), "tigapuluhsembilan")
        XCTAssertEqual(malay.translate(40), "empatpuluh")
        XCTAssertEqual(malay.translate(41), "empatpuluhsatu")
        XCTAssertEqual(malay.translate(42), "empatpuluhdua")
        XCTAssertEqual(malay.translate(43), "empatpuluhtiga")
        XCTAssertEqual(malay.translate(44), "empatpuluhempat")
        XCTAssertEqual(malay.translate(45), "empatpuluhlima")
        XCTAssertEqual(malay.translate(46), "empatpuluhenam")
        XCTAssertEqual(malay.translate(47), "empatpuluhtujuh")
        XCTAssertEqual(malay.translate(48), "empatpuluhlapan")
        XCTAssertEqual(malay.translate(49), "empatpuluhsembilan")
        XCTAssertEqual(malay.translate(50), "limapuluh")
        XCTAssertEqual(malay.translate(51), "limapuluhsatu")
        XCTAssertEqual(malay.translate(52), "limapuluhdua")
        XCTAssertEqual(malay.translate(53), "limapuluhtiga")
        XCTAssertEqual(malay.translate(54), "limapuluhempat")
        XCTAssertEqual(malay.translate(55), "limapuluhlima")
        XCTAssertEqual(malay.translate(56), "limapuluhenam")
        XCTAssertEqual(malay.translate(57), "limapuluhtujuh")
        XCTAssertEqual(malay.translate(58), "limapuluhlapan")
        XCTAssertEqual(malay.translate(59), "limapuluhsembilan")
        XCTAssertEqual(malay.translate(60), "enampuluh")
        XCTAssertEqual(malay.translate(61), "enampuluhsatu")
        XCTAssertEqual(malay.translate(62), "enampuluhdua")
        XCTAssertEqual(malay.translate(63), "enampuluhtiga")
        XCTAssertEqual(malay.translate(64), "enampuluhempat")
        XCTAssertEqual(malay.translate(65), "enampuluhlima")
        XCTAssertEqual(malay.translate(66), "enampuluhenam")
        XCTAssertEqual(malay.translate(67), "enampuluhtujuh")
        XCTAssertEqual(malay.translate(68), "enampuluhlapan")
        XCTAssertEqual(malay.translate(69), "enampuluhsembilan")
        XCTAssertEqual(malay.translate(70), "tujuhpuluh")
        XCTAssertEqual(malay.translate(71), "tujuhpuluhsatu")
        XCTAssertEqual(malay.translate(72), "tujuhpuluhdua")
        XCTAssertEqual(malay.translate(73), "tujuhpuluhtiga")
        XCTAssertEqual(malay.translate(74), "tujuhpuluhempat")
        XCTAssertEqual(malay.translate(75), "tujuhpuluhlima")
        XCTAssertEqual(malay.translate(76), "tujuhpuluhenam")
        XCTAssertEqual(malay.translate(77), "tujuhpuluhtujuh")
        XCTAssertEqual(malay.translate(78), "tujuhpuluhlapan")
        XCTAssertEqual(malay.translate(79), "tujuhpuluhsembilan")
        XCTAssertEqual(malay.translate(80), "lapanpuluh")
        XCTAssertEqual(malay.translate(81), "lapanpuluhsatu")
        XCTAssertEqual(malay.translate(82), "lapanpuluhdua")
        XCTAssertEqual(malay.translate(83), "lapanpuluhtiga")
        XCTAssertEqual(malay.translate(84), "lapanpuluhempat")
        XCTAssertEqual(malay.translate(85), "lapanpuluhlima")
        XCTAssertEqual(malay.translate(86), "lapanpuluhenam")
        XCTAssertEqual(malay.translate(87), "lapanpuluhtujuh")
        XCTAssertEqual(malay.translate(88), "lapanpuluhlapan")
        XCTAssertEqual(malay.translate(89), "lapanpuluhsembilan")
        XCTAssertEqual(malay.translate(90), "sembilanpuluh")
        XCTAssertEqual(malay.translate(91), "sembilanpuluhsatu")
        XCTAssertEqual(malay.translate(92), "sembilanpuluhdua")
        XCTAssertEqual(malay.translate(93), "sembilanpuluhtiga")
        XCTAssertEqual(malay.translate(94), "sembilanpuluhempat")
        XCTAssertEqual(malay.translate(95), "sembilanpuluhlima")
        XCTAssertEqual(malay.translate(96), "sembilanpuluhenam")
        XCTAssertEqual(malay.translate(97), "sembilanpuluhtujuh")
        XCTAssertEqual(malay.translate(98), "sembilanpuluhlapan")
        XCTAssertEqual(malay.translate(99), "sembilanpuluhsembilan")
        XCTAssertEqual(malay.translate(100), "seratus")
        XCTAssertEqual(malay.translate(101), "seratussatu")
        XCTAssertEqual(malay.translate(102), "seratusdua")
        XCTAssertEqual(malay.translate(103), "seratustiga")
        XCTAssertEqual(malay.translate(104), "seratusempat")
        XCTAssertEqual(malay.translate(105), "seratuslima")
        XCTAssertEqual(malay.translate(106), "seratusenam")
        XCTAssertEqual(malay.translate(107), "seratustujuh")
        XCTAssertEqual(malay.translate(108), "seratuslapan")
        XCTAssertEqual(malay.translate(109), "seratussembilan")
        XCTAssertEqual(malay.translate(110), "seratussepuluh")
        XCTAssertEqual(malay.translate(111), "seratussebelas")
        XCTAssertEqual(malay.translate(112), "seratusduabelas")
        XCTAssertEqual(malay.translate(113), "seratustigabelas")
        XCTAssertEqual(malay.translate(119), "seratussembilanbelas")
        XCTAssertEqual(malay.translate(120), "seratusduapuluh")
        XCTAssertEqual(malay.translate(121), "seratusduapuluhsatu")
        XCTAssertEqual(malay.translate(190), "seratussembilanpuluh")
        XCTAssertEqual(malay.translate(444), "empatratusempatpuluhempat")
        XCTAssertEqual(malay.translate(999), "sembilanratussembilanpuluhsembilan")
        XCTAssertEqual(malay.translate(1_000), "seribu")
        XCTAssertEqual(malay.translate(1_001), "seribusatu")
        XCTAssertEqual(malay.translate(1_005), "seribulima")
        XCTAssertEqual(malay.translate(1_009), "seribusembilan")
        XCTAssertEqual(malay.translate(1_010), "seribusepuluh")
        XCTAssertEqual(malay.translate(1_011), "seribusebelas")
        XCTAssertEqual(malay.translate(1_012), "seribuduabelas")
        XCTAssertEqual(malay.translate(1_015), "seribulimabelas")
        XCTAssertEqual(malay.translate(1_035), "seributigapuluhlima")
        XCTAssertEqual(malay.translate(1_099), "seribusembilanpuluhsembilan")
        XCTAssertEqual(malay.translate(1_100), "seribuseratus")
        XCTAssertEqual(malay.translate(1_101), "seribuseratussatu")
        XCTAssertEqual(malay.translate(1_105), "seribuseribulima")
        XCTAssertEqual(malay.translate(1_110), "seribuseribusepuluh")
        XCTAssertEqual(malay.translate(1_111), "seribuseratussebelas")
        XCTAssertEqual(malay.translate(1_115), "seribuseratuslimabelas")
        XCTAssertEqual(malay.translate(1_121), "seribuseratusduapuluhsatu")
        XCTAssertEqual(malay.translate(1_125), "seribuseratusduapuluhlima")
        XCTAssertEqual(malay.translate(10_000), "sepuluhribu")
        XCTAssertEqual(malay.translate(10_001), "sepuluhribu")
        XCTAssertEqual(malay.translate(20_001), "duapuluhribu")
        XCTAssertEqual(malay.translate(20_010), "duapuluhribusepuluh")
        XCTAssertEqual(malay.translate(20_101), "duapuluhribuseratussatu")
        XCTAssertEqual(malay.translate(201_001), "duaratusseribusatu")
        XCTAssertEqual(malay.translate(502_305), "limaratusduaributigaratuslima")
        XCTAssertEqual(malay.translate(999_999), "sembilanratussembilanpuluhsembilanribusembilanratussembilanpuluhsembilan")
        XCTAssertEqual(malay.translate(62_000_000), "enampuluhduajuta")
        XCTAssertEqual(malay.translate(62_003_005), "enampuluhduajutatigaribulima")
        XCTAssertEqual(malay.translate(62_003_105), "enampuluhduajutatigaribuseratuslima")
        XCTAssertEqual(malay.translate(62_003_155), "enampuluhduajutatigaribuseratuslimapuluhlima")
        XCTAssertEqual(malay.translate(99_000_000_909), "sembilanpuluhsembilanbilionsembilanratussembilan")
        XCTAssertEqual(malay.translate(99_999_999_999), "sembilanpuluhsembilanbilionsembilanratussembilanpuluhsembilanjutasembilanratussembilanpuluhsembilanribusembilanratussembilanpuluhsembilan")
        XCTAssertEqual(malay.translate(-1), "tolaksatu")
        XCTAssertEqual(malay.translate(-1.5), "tolaksatutitiklima")
        XCTAssertEqual(malay.translate(1.5), "satutitiklima")
        XCTAssertEqual(malay.translate(3.1415926), "tigamatasatuempatlimasembilanduaenamenam")
        XCTAssertEqual(malay.translate(-3.1415926), "tolaktigamatasatuempatsatulimasembilanduaenam")
        XCTAssertEqual(malay.translate(3.4e13), "tigamataempatkalisepuluhhinggakuasatigabelas")
        }
}