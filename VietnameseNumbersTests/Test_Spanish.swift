//
//  Test_Spanish.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/14/23.
//

import XCTest

final class Test_Spanish: XCTestCase {
    func test_spanish() {
        let spanish = TranslateSpanish()
        spanish.decimalSeparator = "."
        spanish.groupSeparator = ""
        
        XCTAssertEqual(spanish.translate(-1), "menos uno")
        XCTAssertEqual(spanish.translate("-1"), "menos uno")
        XCTAssertEqual(spanish.translate(-1.5), "menos uno coma cinco")
        XCTAssertEqual(spanish.translate(-1.51), "menos uno coma cinco uno")
        XCTAssertEqual(spanish.translate(-0.7), "menos cero coma siete")
        XCTAssertEqual(spanish.translate("-0.7"), "menos cero coma siete")
        XCTAssertEqual(spanish.translate("-1.5"), "menos uno coma cinco")
        XCTAssertEqual(spanish.translate(1.5), "uno coma cinco")
        XCTAssertEqual(spanish.translate("1.5"), "uno coma cinco")
        XCTAssertEqual(spanish.translate(0), "cero")
        XCTAssertEqual(spanish.translate(1), "uno")
        XCTAssertEqual(spanish.translate(2), "dos")
        XCTAssertEqual(spanish.translate(3), "tres")
        XCTAssertEqual(spanish.translate(4), "cuatro")
        XCTAssertEqual(spanish.translate(5), "cinco")
        XCTAssertEqual(spanish.translate(6), "seis")
        XCTAssertEqual(spanish.translate(7), "siete")
        XCTAssertEqual(spanish.translate(8), "ocho")
        XCTAssertEqual(spanish.translate(9), "nueve")
        XCTAssertEqual(spanish.translate(10), "diez")
        XCTAssertEqual(spanish.translate(11), "once")
        XCTAssertEqual(spanish.translate(12), "doce")
        XCTAssertEqual(spanish.translate(13), "trece")
        XCTAssertEqual(spanish.translate(14), "catorce")
        XCTAssertEqual(spanish.translate(15), "quince")
        XCTAssertEqual(spanish.translate(16), "dieciséis")
        XCTAssertEqual(spanish.translate(17), "diecisiete")
        XCTAssertEqual(spanish.translate(18), "dieciocho")
        XCTAssertEqual(spanish.translate(19), "diecinueve")
        XCTAssertEqual(spanish.translate(20), "veinte")
        XCTAssertEqual(spanish.translate(21), "veintiuno")
        XCTAssertEqual(spanish.translate(22), "veintidós")
        XCTAssertEqual(spanish.translate(23), "veintitrés")
        XCTAssertEqual(spanish.translate(24), "veinticuatro")
        XCTAssertEqual(spanish.translate(25), "veinticinco")
        XCTAssertEqual(spanish.translate(26), "veintiséis")
        XCTAssertEqual(spanish.translate(27), "veintisiete")
        XCTAssertEqual(spanish.translate(28), "veintiocho")
        XCTAssertEqual(spanish.translate(29), "veintinueve")
        XCTAssertEqual(spanish.translate(20), "veinte")
        XCTAssertEqual(spanish.translate(31), "treinta y uno")
        XCTAssertEqual(spanish.translate(32), "treinta y dos")
        XCTAssertEqual(spanish.translate(33), "treinta y tres")
        XCTAssertEqual(spanish.translate(34), "treinta y cuatro")
        XCTAssertEqual(spanish.translate(35), "treinta y cinco")
        XCTAssertEqual(spanish.translate(36), "treinta y seis")
        XCTAssertEqual(spanish.translate(37), "treinta y siete")
        XCTAssertEqual(spanish.translate(38), "treinta y ocho")
        XCTAssertEqual(spanish.translate(39), "treinta y nueve")
        XCTAssertEqual(spanish.translate(40), "cuarenta")
        XCTAssertEqual(spanish.translate(41), "cuarenta y uno")
        XCTAssertEqual(spanish.translate(42), "cuarenta y dos")
        XCTAssertEqual(spanish.translate(43), "cuarenta y tres")
        XCTAssertEqual(spanish.translate(44), "cuarenta y cuatro")
        XCTAssertEqual(spanish.translate(45), "cuarenta y cinco")
        XCTAssertEqual(spanish.translate(46), "cuarenta y seis")
        XCTAssertEqual(spanish.translate(47), "cuarenta y siete")
        XCTAssertEqual(spanish.translate(48), "cuarenta y ocho")
        XCTAssertEqual(spanish.translate(49), "cuarenta y nueve")
        XCTAssertEqual(spanish.translate(50), "cincuenta")
        XCTAssertEqual(spanish.translate(51), "cincuenta y uno")
        XCTAssertEqual(spanish.translate(52), "cincuenta y dos")
        XCTAssertEqual(spanish.translate(53), "cincuenta y tres")
        XCTAssertEqual(spanish.translate(54), "cincuenta y cuatro")
        XCTAssertEqual(spanish.translate(55), "cincuenta y cinco")
        XCTAssertEqual(spanish.translate(56), "cincuenta y seis")
        XCTAssertEqual(spanish.translate(57), "cincuenta y siete")
        XCTAssertEqual(spanish.translate(58), "cincuenta y ocho")
        XCTAssertEqual(spanish.translate(59), "cincuenta y nueve")
        XCTAssertEqual(spanish.translate(60), "sesenta")
        XCTAssertEqual(spanish.translate(61), "sesenta y uno")
        XCTAssertEqual(spanish.translate(62), "sesenta y dos")
        XCTAssertEqual(spanish.translate(63), "sesenta y tres")
        XCTAssertEqual(spanish.translate(64), "sesenta y cuatro")
        XCTAssertEqual(spanish.translate(65), "sesenta y cinco")
        XCTAssertEqual(spanish.translate(66), "sesenta y seis")
        XCTAssertEqual(spanish.translate(67), "sesenta y siete")
        XCTAssertEqual(spanish.translate(68), "sesenta y ocho")
        XCTAssertEqual(spanish.translate(69), "sesenta y nueve")
        XCTAssertEqual(spanish.translate(70), "setenta")
        XCTAssertEqual(spanish.translate(71), "setenta y uno")
        XCTAssertEqual(spanish.translate(72), "setenta y dos")
        XCTAssertEqual(spanish.translate(73), "setenta y tres")
        XCTAssertEqual(spanish.translate(74), "setenta y cuatro")
        XCTAssertEqual(spanish.translate(75), "setenta y cinco")
        XCTAssertEqual(spanish.translate(76), "setenta y seis")
        XCTAssertEqual(spanish.translate(77), "setenta y siete")
        XCTAssertEqual(spanish.translate(78), "setenta y ocho")
        XCTAssertEqual(spanish.translate(79), "setenta y nueve")
        XCTAssertEqual(spanish.translate(80), "ochenta")
        XCTAssertEqual(spanish.translate(81), "ochenta y uno")
        XCTAssertEqual(spanish.translate(82), "ochenta y dos")
        XCTAssertEqual(spanish.translate(83), "ochenta y tres")
        XCTAssertEqual(spanish.translate(84), "ochenta y cuatro")
        XCTAssertEqual(spanish.translate(85), "ochenta y cinco")
        XCTAssertEqual(spanish.translate(86), "ochenta y seis")
        XCTAssertEqual(spanish.translate(87), "ochenta y siete")
        XCTAssertEqual(spanish.translate(88), "ochenta y ocho")
        XCTAssertEqual(spanish.translate(89), "ochenta y nueve")
        XCTAssertEqual(spanish.translate(90), "noventa")
        XCTAssertEqual(spanish.translate(91), "noventa y uno")
        XCTAssertEqual(spanish.translate(92), "noventa y dos")
        XCTAssertEqual(spanish.translate(93), "noventa y tres")
        XCTAssertEqual(spanish.translate(94), "noventa y cuatro")
        XCTAssertEqual(spanish.translate(95), "noventa y cinco")
        XCTAssertEqual(spanish.translate(96), "noventa y seis")
        XCTAssertEqual(spanish.translate(97), "noventa y siete")
        XCTAssertEqual(spanish.translate(98), "noventa y ocho")
        XCTAssertEqual(spanish.translate(99), "noventa y nueve")
        XCTAssertEqual(spanish.translate(100), "cien")
        XCTAssertEqual(spanish.translate(101), "ciento uno")
        XCTAssertEqual(spanish.translate(102), "ciento dos")
        XCTAssertEqual(spanish.translate(103), "ciento tres")
        XCTAssertEqual(spanish.translate(104), "ciento cuatro")
        XCTAssertEqual(spanish.translate(105), "ciento cinco")
        XCTAssertEqual(spanish.translate(106), "ciento seis")
        XCTAssertEqual(spanish.translate(107), "ciento siete")
        XCTAssertEqual(spanish.translate(108), "ciento ocho")
        XCTAssertEqual(spanish.translate(109), "ciento nueve")
        XCTAssertEqual(spanish.translate(110), "ciento diez")
        XCTAssertEqual(spanish.translate(111), "ciento once")
        XCTAssertEqual(spanish.translate(112), "ciento doce")
        XCTAssertEqual(spanish.translate(113), "ciento trece")
        XCTAssertEqual(spanish.translate(119), "ciento diecinueve")
        XCTAssertEqual(spanish.translate(120), "ciento veinte")
        XCTAssertEqual(spanish.translate(121), "ciento veintiuno")
        XCTAssertEqual(spanish.translate(122), "ciento veintidós")
        XCTAssertEqual(spanish.translate(190), "ciento noventa")
        XCTAssertEqual(spanish.translate(144), "ciento cuarenta y cuatro")
        XCTAssertEqual(spanish.translate(200), "doscientos")
        XCTAssertEqual(spanish.translate(211), "doscientos once")
        XCTAssertEqual(spanish.translate(300), "trescientos")
        XCTAssertEqual(spanish.translate(400), "cuatrocientos")
        XCTAssertEqual(spanish.translate(500), "quinientos")
        XCTAssertEqual(spanish.translate(600), "seiscientos")
        XCTAssertEqual(spanish.translate(700), "setecientos")
        XCTAssertEqual(spanish.translate(706), "setecientos seis")
        XCTAssertEqual(spanish.translate(726), "setecientos veintiséis")
        XCTAssertEqual(spanish.translate(800), "ochocientos")
        XCTAssertEqual(spanish.translate(900), "novecientos")
        XCTAssertEqual(spanish.translate(1_000), "mil")
        XCTAssertEqual(spanish.translate(2_000), "dos mil")
        XCTAssertEqual(spanish.translate(3_000), "tres mil")
        XCTAssertEqual(spanish.translate(3_001), "tres mil uno")
        XCTAssertEqual(spanish.translate(6_000), "seis mil")
        XCTAssertEqual(spanish.translate(6_001), "seis mil uno")
        XCTAssertEqual(spanish.translate(10_000), "diez mil")
        XCTAssertEqual(spanish.translate(11_001), "once mil uno")
        XCTAssertEqual(spanish.translate(12_895), "doce mil ochocientos noventa y cinco")
        XCTAssertEqual(spanish.translate(12_786), "doce mil setecientos ochenta y seis")
        XCTAssertEqual(spanish.translate(70_000), "setenta mil")
        XCTAssertEqual(spanish.translate(187_372), "ciento ochenta y siete mil trescientos setenta y dos")
        XCTAssertEqual(spanish.translate(200_000), "doscientos mil")
        XCTAssertEqual(spanish.translate(280_065), "doscientos ochenta mil sesenta y cinco")
        XCTAssertEqual(spanish.translate(706_210), "setecientos seis mil doscientos diez")
        XCTAssertEqual(spanish.translate(100_000), "cien mil")
        XCTAssertEqual(spanish.translate(1_000_000), "un millón")
        XCTAssertEqual(spanish.translate(1_000_050), "un millón cincuenta")
        XCTAssertEqual(spanish.translate(3_000_100), "tres millones cien")
        XCTAssertEqual(spanish.translate(10_000_000), "diez millones")
        XCTAssertEqual(spanish.translate(40_000_000), "cuarenta millones")
        XCTAssertEqual(spanish.translate(62_000_000), "sesenta y dos millones")
        XCTAssertEqual(spanish.translate(62_003_005), "sesenta y dos millones tres mil cinco")
        XCTAssertEqual(spanish.translate(62_003_105), "sesenta y dos millones tres mil ciento cinco")
        XCTAssertEqual(spanish.translate(100_000_000), "cien millones")
        XCTAssertEqual(spanish.translate(500_000_000), "quinientos millones")
        XCTAssertEqual(spanish.translate(1_000_000_000), "mil millones")
        XCTAssertEqual(spanish.translate(1_000_000_200), "mil millones doscientos")
        XCTAssertEqual(spanish.translate(10_000_000_000), "diez mil millones")
        XCTAssertEqual(spanish.translate(20_000_000_700), "veinte mil millones setecientos")
        XCTAssertEqual(spanish.translate(100_000_000_000), "cien mil millones")
        XCTAssertEqual(spanish.translate(400_000_000_000), "cuatrocientos mil millones")
        XCTAssertEqual(spanish.translate(1_000_000_000_000), "un billón")

        XCTAssertEqual(spanish.translate(-1), "menos uno")
        XCTAssertEqual(spanish.translate(-74), "menos setenta y cuatro")
        XCTAssertEqual(spanish.translate(-1_000_000), "menos un millón")
        XCTAssertEqual(spanish.translate(3.1415926), "tres coma uno cuatro uno cinco nueve dos seis")
        XCTAssertEqual(spanish.translate(-3.1415926), "menos tres coma uno cuatro uno cinco nueve dos seis")
        XCTAssertEqual(spanish.translate(3.4e16), "tres coma cuatro por diez elevado a dieciséis")
    }
}