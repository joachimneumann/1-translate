//
//  Test_Polish.swift
//
//  Created by automatic.py
//

import XCTest

final class TestPolish: XCTestCase {
    
    let polish = Polish()

    override func setUpWithError() throws {
        polish.groupSeparator = ""
        polish.decimalSeparator = "."
    }
    
    func test_polish() {
        XCTAssertEqual(polish.read(0), "zero")
        XCTAssertEqual(polish.read(1), "jeden")
        XCTAssertEqual(polish.read(2), "dwa")
        XCTAssertEqual(polish.read(3), "trzy")
        XCTAssertEqual(polish.read(4), "cztery")
        XCTAssertEqual(polish.read(5), "pięć")
        XCTAssertEqual(polish.read(6), "sześć")
        XCTAssertEqual(polish.read(7), "siedem")
        XCTAssertEqual(polish.read(8), "osiem")
        XCTAssertEqual(polish.read(9), "dziewięć")
        XCTAssertEqual(polish.read(10), "dziesięć")
        XCTAssertEqual(polish.read(11), "jedenaście")
        XCTAssertEqual(polish.read(12), "dwanaście")
        XCTAssertEqual(polish.read(13), "trzynaście")
        XCTAssertEqual(polish.read(14), "czternaście")
        XCTAssertEqual(polish.read(15), "piętnaście")
        XCTAssertEqual(polish.read(16), "szesnaście")
        XCTAssertEqual(polish.read(17), "siedemnaście")
        XCTAssertEqual(polish.read(18), "osiemnaście")
        XCTAssertEqual(polish.read(19), "dziewiętnaście")
        XCTAssertEqual(polish.read(20), "dwadzieścia")
        XCTAssertEqual(polish.read(21), "dwadzieścia jeden")
        XCTAssertEqual(polish.read(22), "dwadzieścia dwa")
        XCTAssertEqual(polish.read(23), "dwadzieścia trzy")
        XCTAssertEqual(polish.read(24), "dwadzieścia cztery")
        XCTAssertEqual(polish.read(25), "dwadzieścia pięć")
        XCTAssertEqual(polish.read(26), "dwadzieścia sześć")
        XCTAssertEqual(polish.read(27), "dwadzieścia siedem")
        XCTAssertEqual(polish.read(28), "dwadzieścia osiem")
        XCTAssertEqual(polish.read(29), "dwadzieścia dziewięć")
        XCTAssertEqual(polish.read(30), "trzydzieści")
        XCTAssertEqual(polish.read(31), "trzydzieści jeden")
        XCTAssertEqual(polish.read(32), "trzydzieści dwa")
        XCTAssertEqual(polish.read(33), "trzydzieści trzy")
        XCTAssertEqual(polish.read(34), "trzydzieści cztery")
        XCTAssertEqual(polish.read(35), "trzydzieści pięć")
        XCTAssertEqual(polish.read(36), "trzydzieści sześć")
        XCTAssertEqual(polish.read(37), "trzydzieści siedem")
        XCTAssertEqual(polish.read(38), "trzydzieści osiem")
        XCTAssertEqual(polish.read(39), "trzydzieści dziewięć")
        XCTAssertEqual(polish.read(40), "czterdzieści")
        XCTAssertEqual(polish.read(41), "czterdzieści jeden")
        XCTAssertEqual(polish.read(42), "czterdzieści dwa")
        XCTAssertEqual(polish.read(43), "czterdzieści trzy")
        XCTAssertEqual(polish.read(44), "czterdzieści cztery")
        XCTAssertEqual(polish.read(45), "czterdzieści pięć")
        XCTAssertEqual(polish.read(46), "czterdzieści sześć")
        XCTAssertEqual(polish.read(47), "czterdzieści siedem")
        XCTAssertEqual(polish.read(48), "czterdzieści osiem")
        XCTAssertEqual(polish.read(49), "czterdzieści dziewięć")
        XCTAssertEqual(polish.read(50), "pięćdziesiąt")
        XCTAssertEqual(polish.read(51), "pięćdziesiąt jeden")
        XCTAssertEqual(polish.read(52), "pięćdziesiąt dwa")
        XCTAssertEqual(polish.read(53), "pięćdziesiąt trzy")
        XCTAssertEqual(polish.read(54), "pięćdziesiąt cztery")
        XCTAssertEqual(polish.read(55), "pięćdziesiąt pięć")
        XCTAssertEqual(polish.read(56), "pięćdziesiąt sześć")
        XCTAssertEqual(polish.read(57), "pięćdziesiąt siedem")
        XCTAssertEqual(polish.read(58), "pięćdziesiąt osiem")
        XCTAssertEqual(polish.read(59), "pięćdziesiąt dziewięć")
        XCTAssertEqual(polish.read(60), "sześćdziesiąt")
        XCTAssertEqual(polish.read(61), "sześćdziesiąt jeden")
        XCTAssertEqual(polish.read(62), "sześćdziesiąt dwa")
        XCTAssertEqual(polish.read(63), "sześćdziesiąt trzy")
        XCTAssertEqual(polish.read(64), "sześćdziesiąt cztery")
        XCTAssertEqual(polish.read(65), "sześćdziesiąt pięć")
        XCTAssertEqual(polish.read(66), "sześćdziesiąt sześć")
        XCTAssertEqual(polish.read(67), "sześćdziesiąt siedem")
        XCTAssertEqual(polish.read(68), "sześćdziesiąt osiem")
        XCTAssertEqual(polish.read(69), "sześćdziesiąt dziewięć")
        XCTAssertEqual(polish.read(70), "siedemdziesiąt")
        XCTAssertEqual(polish.read(71), "siedemdziesiąt jeden")
        XCTAssertEqual(polish.read(72), "siedemdziesiąt dwa")
        XCTAssertEqual(polish.read(73), "siedemdziesiąt trzy")
        XCTAssertEqual(polish.read(74), "siedemdziesiąt cztery")
        XCTAssertEqual(polish.read(75), "siedemdziesiąt pięć")
        XCTAssertEqual(polish.read(76), "siedemdziesiąt sześć")
        XCTAssertEqual(polish.read(77), "siedemdziesiąt siedem")
        XCTAssertEqual(polish.read(78), "siedemdziesiąt osiem")
        XCTAssertEqual(polish.read(79), "siedemdziesiąt dziewięć")
        XCTAssertEqual(polish.read(80), "osiemdziesiąt")
        XCTAssertEqual(polish.read(81), "osiemdziesiąt jeden")
        XCTAssertEqual(polish.read(82), "osiemdziesiąt dwa")
        XCTAssertEqual(polish.read(83), "osiemdziesiąt trzy")
        XCTAssertEqual(polish.read(84), "osiemdziesiąt cztery")
        XCTAssertEqual(polish.read(85), "osiemdziesiąt pięć")
        XCTAssertEqual(polish.read(86), "osiemdziesiąt sześć")
        XCTAssertEqual(polish.read(87), "osiemdziesiąt siedem")
        XCTAssertEqual(polish.read(88), "osiemdziesiąt osiem")
        XCTAssertEqual(polish.read(89), "osiemdziesiąt dziewięć")
        XCTAssertEqual(polish.read(90), "dziewięćdziesiąt")
        XCTAssertEqual(polish.read(91), "dziewięćdziesiąt jeden")
        XCTAssertEqual(polish.read(92), "dziewięćdziesiąt dwa")
        XCTAssertEqual(polish.read(93), "dziewięćdziesiąt trzy")
        XCTAssertEqual(polish.read(94), "dziewięćdziesiąt cztery")
        XCTAssertEqual(polish.read(95), "dziewięćdziesiąt pięć")
        XCTAssertEqual(polish.read(96), "dziewięćdziesiąt sześć")
        XCTAssertEqual(polish.read(97), "dziewięćdziesiąt siedem")
        XCTAssertEqual(polish.read(98), "dziewięćdziesiąt osiem")
        XCTAssertEqual(polish.read(99), "dziewięćdziesiąt dziewięć")
        XCTAssertEqual(polish.read(100), "sto")
        XCTAssertEqual(polish.read(101), "sto jeden")
        XCTAssertEqual(polish.read(102), "sto dwa")
        XCTAssertEqual(polish.read(103), "sto trzy")
        XCTAssertEqual(polish.read(104), "sto cztery")
        XCTAssertEqual(polish.read(105), "sto pięć")
        XCTAssertEqual(polish.read(106), "sto sześć")
        XCTAssertEqual(polish.read(107), "sto siedem")
        XCTAssertEqual(polish.read(108), "sto osiem")
        XCTAssertEqual(polish.read(109), "sto dziewięć")
        XCTAssertEqual(polish.read(110), "sto dziesięć")
        XCTAssertEqual(polish.read(111), "sto jedenaście")
        XCTAssertEqual(polish.read(112), "sto dwanaście")
        XCTAssertEqual(polish.read(113), "sto trzynaście")
        XCTAssertEqual(polish.read(114), "sto czternaście")
        XCTAssertEqual(polish.read(115), "sto piętnaście")
        XCTAssertEqual(polish.read(116), "sto szesnaście")
        XCTAssertEqual(polish.read(117), "sto siedemnaście")
        XCTAssertEqual(polish.read(118), "sto osiemnaście")
        XCTAssertEqual(polish.read(119), "sto dziewiętnaście")
        XCTAssertEqual(polish.read(120), "sto dwadzieścia")
        XCTAssertEqual(polish.read(121), "sto dwadzieścia jeden")
        XCTAssertEqual(polish.read(190), "sto dziewięćdziesiąt")
        XCTAssertEqual(polish.read(200), "dwieście")
        XCTAssertEqual(polish.read(221), "dwieście dwadzieścia jeden")
        XCTAssertEqual(polish.read(300), "trzysta")
        XCTAssertEqual(polish.read(321), "trzysta dwadzieścia jeden")
        XCTAssertEqual(polish.read(400), "czterysta")
        XCTAssertEqual(polish.read(444), "czterysta czterdzieści cztery")
        XCTAssertEqual(polish.read(500), "pięćset")
        XCTAssertEqual(polish.read(544), "pięćset czterdzieści cztery")
        XCTAssertEqual(polish.read(600), "sześćset")
        XCTAssertEqual(polish.read(644), "sześćset czterdzieści cztery")
        XCTAssertEqual(polish.read(700), "siedemset")
        XCTAssertEqual(polish.read(744), "siedemset czterdzieści cztery")
        XCTAssertEqual(polish.read(800), "osiemset")
        XCTAssertEqual(polish.read(844), "osiemset czterdzieści cztery")
        XCTAssertEqual(polish.read(900), "dziewięćset")
        XCTAssertEqual(polish.read(944), "dziewięćset czterdzieści cztery")
        XCTAssertEqual(polish.read(999), "dziewięćset dziewięćdziesiąt dziewięć")
        
        XCTAssertEqual(polish.read(1_000), "tysiąc")
        XCTAssertEqual(polish.read(1_001), "tysiąc jeden")
        XCTAssertEqual(polish.read(1_005), "tysiąc pięć")
        XCTAssertEqual(polish.read(1_009), "tysiąc dziewięć")
        XCTAssertEqual(polish.read(1_010), "tysiąc dziesięć")
        XCTAssertEqual(polish.read(1_011), "tysiąc jedenaście")
        XCTAssertEqual(polish.read(1_012), "tysiąc dwanaście")
        XCTAssertEqual(polish.read(1_015), "tysiąc piętnaście")
        XCTAssertEqual(polish.read(1_035), "tysiąc trzydzieści pięć")
        XCTAssertEqual(polish.read(1_099), "tysiąc dziewięćdziesiąt dziewięć")
        XCTAssertEqual(polish.read(1_100), "tysiąc sto")
        XCTAssertEqual(polish.read(1_101), "tysiąc sto jeden")
        XCTAssertEqual(polish.read(1_105), "tysiąc sto pięć")
        XCTAssertEqual(polish.read(1_110), "tysiąc sto dziesięć")
        XCTAssertEqual(polish.read(1_111), "tysiąc sto jedenaście")
        XCTAssertEqual(polish.read(1_115), "tysiąc sto piętnaście")
        XCTAssertEqual(polish.read(1_121), "tysiąc sto dwadzieścia jeden")
        XCTAssertEqual(polish.read(1_125), "tysiąc sto dwadzieścia pięć")
        XCTAssertEqual(polish.read(2_000), "dwa tysiące")
        XCTAssertEqual(polish.read(2_600), "dwa tysiące sześćset")
        XCTAssertEqual(polish.read(3_000), "trzy tysiące")
        XCTAssertEqual(polish.read(4_000), "cztery tysiące")
        XCTAssertEqual(polish.read(5_000), "pięć tysięcy")
        XCTAssertEqual(polish.read(6_000), "sześć tysięcy")
        XCTAssertEqual(polish.read(7_000), "siedem tysięcy")
        XCTAssertEqual(polish.read(8_000), "osiem tysięcy")
        XCTAssertEqual(polish.read(9_000), "dziewięć tysięcy")
        XCTAssertEqual(polish.read(10_000), "dziesięć tysięcy")
        XCTAssertEqual(polish.read(10_001), "dziesięć tysięcy jeden")
        XCTAssertEqual(polish.read(11_000), "jedenaście tysięcy")
        XCTAssertEqual(polish.read(12_000), "dwanaście tysięcy")
        XCTAssertEqual(polish.read(13_000), "trzynaście tysięcy")
        XCTAssertEqual(polish.read(14_000), "czternaście tysięcy")
        XCTAssertEqual(polish.read(15_000), "piętnaście tysięcy")
        XCTAssertEqual(polish.read(16_000), "szesnaście tysięcy")
        XCTAssertEqual(polish.read(17_000), "siedemnaście tysięcy")
        XCTAssertEqual(polish.read(18_000), "osiemnaście tysięcy")
        XCTAssertEqual(polish.read(19_000), "dziewiętnaście tysięcy")
        XCTAssertEqual(polish.read(20_000), "dwadzieścia tysięcy")
        XCTAssertEqual(polish.read(20_001), "dwadzieścia tysięcy jeden")
        XCTAssertEqual(polish.read(20_010), "dwadzieścia tysięcy dziesięć")
        XCTAssertEqual(polish.read(20_101), "dwadzieścia tysięcy sto jeden")
        XCTAssertEqual(polish.read(21_000), "dwadzieścia jeden tysięcy")
        XCTAssertEqual(polish.read(22_000), "dwadzieścia dwa tysiące")
        XCTAssertEqual(polish.read(23_000), "dwadzieścia trzy tysiące")
        XCTAssertEqual(polish.read(24_000), "dwadzieścia cztery tysiące")
        XCTAssertEqual(polish.read(100_000), "sto tysięcy")
        XCTAssertEqual(polish.read(101_000), "sto jeden tysięcy")
        XCTAssertEqual(polish.read(102_000), "sto dwa tysiące")
        XCTAssertEqual(polish.read(103_000), "sto trzy tysiące")
        XCTAssertEqual(polish.read(104_000), "sto cztery tysiące")
        XCTAssertEqual(polish.read(105_000), "sto pięć tysięcy")
        XCTAssertEqual(polish.read(106_000), "sto sześć tysięcy")
        XCTAssertEqual(polish.read(107_000), "sto siedem tysięcy")
        XCTAssertEqual(polish.read(108_000), "sto osiem tysięcy")
        XCTAssertEqual(polish.read(109_000), "sto dziewięć tysięcy")
        XCTAssertEqual(polish.read(110_000), "sto dziesięć tysięcy")
        XCTAssertEqual(polish.read(111_000), "sto jedenaście tysięcy")
        XCTAssertEqual(polish.read(112_000), "sto dwanaście tysięcy")
        XCTAssertEqual(polish.read(113_000), "sto trzynaście tysięcy")
        XCTAssertEqual(polish.read(114_000), "sto czternaście tysięcy")
        XCTAssertEqual(polish.read(115_000), "sto piętnaście tysięcy")
        XCTAssertEqual(polish.read(116_000), "sto szesnaście tysięcy")
        XCTAssertEqual(polish.read(117_000), "sto siedemnaście tysięcy")
        XCTAssertEqual(polish.read(118_000), "sto osiemnaście tysięcy")
        XCTAssertEqual(polish.read(119_000), "sto dziewiętnaście tysięcy")
        XCTAssertEqual(polish.read(120_000), "sto dwadzieścia tysięcy")
        XCTAssertEqual(polish.read(201_000), "dwieście jeden tysięcy")
        XCTAssertEqual(polish.read(201_001), "dwieście jeden tysięcy jeden")
        XCTAssertEqual(polish.read(202_000), "dwieście dwa tysiące")
        XCTAssertEqual(polish.read(203_000), "dwieście trzy tysiące")
        XCTAssertEqual(polish.read(204_000), "dwieście cztery tysiące")
        XCTAssertEqual(polish.read(205_000), "dwieście pięć tysięcy")
        XCTAssertEqual(polish.read(206_000), "dwieście sześć tysięcy")
        XCTAssertEqual(polish.read(207_000), "dwieście siedem tysięcy")
        XCTAssertEqual(polish.read(208_000), "dwieście osiem tysięcy")
        XCTAssertEqual(polish.read(209_000), "dwieście dziewięć tysięcy")
        XCTAssertEqual(polish.read(212_000), "dwieście dwanaście tysięcy")
        XCTAssertEqual(polish.read(502_305), "pięćset dwa tysiące trzysta pięć")
        XCTAssertEqual(polish.read(999_999), "dziewięćset dziewięćdziesiąt dziewięć tysięcy dziewięćset dziewięćdziesiąt dziewięć")

        XCTAssertEqual(polish.read(1_000_000), "jeden milion")
        XCTAssertEqual(polish.read(2_000_000), "dwa miliony")
        XCTAssertEqual(polish.read(6_000_000), "sześć milionów")
        XCTAssertEqual(polish.read(11_000_000), "jedenaście milionów")  //?
        XCTAssertEqual(polish.read(12_000_000), "dwanaście milionów")  //?
        XCTAssertEqual(polish.read(13_000_000), "trzynaście milionów")  //?
        XCTAssertEqual(polish.read(14_000_000), "czternaście milionów")  //?
        XCTAssertEqual(polish.read(15_000_000), "piętnaście milionów")  //?
        XCTAssertEqual(polish.read(16_000_000), "szesnaście milionów")  //?
        XCTAssertEqual(polish.read(17_000_000), "siedemnaście milionów")  //?
        XCTAssertEqual(polish.read(61_000_000), "sześćdziesiąt jeden milionów")
        XCTAssertEqual(polish.read(62_000_000), "sześćdziesiąt dwa miliony")
        XCTAssertEqual(polish.read(62_003_005), "sześćdziesiąt dwa miliony trzy tysiące pięć")
        XCTAssertEqual(polish.read(62_003_105), "sześćdziesiąt dwa miliony trzy tysiące sto pięć")
        XCTAssertEqual(polish.read(62_003_155), "sześćdziesiąt dwa miliony trzy tysiące sto pięćdziesiąt pięć")
        XCTAssertEqual(polish.read(63_000_000), "sześćdziesiąt trzy miliony")
        XCTAssertEqual(polish.read(62_003_005), "sześćdziesiąt dwa miliony trzy tysiące pięć")
        XCTAssertEqual(polish.read(64_000_000), "sześćdziesiąt cztery miliony")
        XCTAssertEqual(polish.read(65_000_000), "sześćdziesiąt pięć milionów")
        XCTAssertEqual(polish.read(66_000_000), "sześćdziesiąt sześć milionów")
        XCTAssertEqual(polish.read(67_000_000), "sześćdziesiąt siedem milionów")
        XCTAssertEqual(polish.read(68_000_000), "sześćdziesiąt osiem milionów")
        XCTAssertEqual(polish.read(69_000_000), "sześćdziesiąt dziewięć milionów")
        XCTAssertEqual(polish.read(304_000_000), "trzysta cztery miliony")
        XCTAssertEqual(polish.read(306_000_000), "trzysta sześć milionów")
        XCTAssertEqual(polish.read(312_000_000), "trzysta dwanaście milionów") //?
        XCTAssertEqual(polish.read(316_000_000), "trzysta szesnaście milionów")
        XCTAssertEqual(polish.read(362_000_000), "trzysta sześćdziesiąt dwa miliony")
        XCTAssertEqual(polish.read(366_000_000), "trzysta sześćdziesiąt sześć milionów")

        XCTAssertEqual(polish.read(1_000_000_000), "jeden miliard") //?
        XCTAssertEqual(polish.read(2_000_000_000), "dwa miliardy") //?
        XCTAssertEqual(polish.read(6_000_000_000), "sześć miliardów") //?
        XCTAssertEqual(polish.read(12_000_000_000), "dwanaście miliardów") //?
        XCTAssertEqual(polish.read(16_000_000_000), "szesnaście miliardów") //?
        XCTAssertEqual(polish.read(62_000_000_000), "sześćdziesiąt dwa miliardy") //?
        XCTAssertEqual(polish.read(66_000_000_000), "sześćdziesiąt sześć miliardów") //?
        XCTAssertEqual(polish.read(99_000_000_909), "dziewięćdziesiąt dziewięć miliardów dziewięćset dziewięć") //?
        XCTAssertEqual(polish.read(99_000_900_909), "dziewięćdziesiąt dziewięć miliardów dziewięćset tysięcy dziewięćset dziewięć")
        XCTAssertEqual(polish.read(302_000_000_000), "trzysta dwa miliardy") //?
        XCTAssertEqual(polish.read(312_000_000_000), "trzysta dwanaście miliardów")
        XCTAssertEqual(polish.read(362_000_000_000), "trzysta sześćdziesiąt dwa miliardy")
        XCTAssertEqual(polish.read(366_000_000_000), "trzysta sześćdziesiąt sześć miliardów")

        XCTAssertEqual(polish.read(1_000_000_000_000), "jeden bilion") //?
        XCTAssertEqual(polish.read(2_000_000_000_000), "dwa biliony") //?
        XCTAssertEqual(polish.read(6_000_000_000_000), "sześć bilionów") //?

        XCTAssertEqual(polish.read(-1), "minus jeden")
        XCTAssertEqual(polish.read(-15), "minus piętnaście")
        XCTAssertEqual(polish.read("3.1415926"), "trzy przecinek jeden cztery jeden pięć dziewięć dwa sześć")
        XCTAssertEqual(polish.read("-3.1415926"), "minus trzy przecinek jeden cztery jeden pięć dziewięć dwa sześć")
        
        // ...and so on
        XCTAssertEqual(polish.read("3.14159265258979323846"), "trzy przecinek jeden cztery jeden pięć dziewięć dwa sześć pięć dwa pięć...")

        // scientific notation
        XCTAssertEqual(polish.read("3.4e22"), "trzy przecinek cztery razy dziesięć do potęgi dwadzieścia dwa")
    }
}
