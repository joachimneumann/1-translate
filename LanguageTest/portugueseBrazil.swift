// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest

final class Test_portugueseBrazil: XCTestCase {

    let language = Languages().portugueseBrazil

    func test_portugueseBrazil() {
        // https: www.fluentu.com/blog/portuguese/portuguese-numbers/
        XCTAssertEqual(language.read(0).x, "zero")
        XCTAssertEqual(language.read(1).x, "um")
        XCTAssertEqual(language.read(2).x, "dois")
        XCTAssertEqual(language.read(3).x, "três")
        XCTAssertEqual(language.read(4).x, "quatro")
        XCTAssertEqual(language.read(5).x, "cinco")
        XCTAssertEqual(language.read(6).x, "seis")
        XCTAssertEqual(language.read(7).x, "sete")
        XCTAssertEqual(language.read(8).x, "oito")
        XCTAssertEqual(language.read(9).x, "nove")
        XCTAssertEqual(language.read(10).x, "dez")
        XCTAssertEqual(language.read(11).x, "onze")
        XCTAssertEqual(language.read(12).x, "doze")
        XCTAssertEqual(language.read(13).x, "treze")
        XCTAssertEqual(language.read(14).x, "catorze")
        XCTAssertEqual(language.read(15).x, "quinze")
        XCTAssertEqual(language.read(16).x, "dezesseis")
        XCTAssertEqual(language.read(17).x, "dezessete")
        XCTAssertEqual(language.read(18).x, "dezoito")
        XCTAssertEqual(language.read(19).x, "dezenove")
        XCTAssertEqual(language.read(20).x, "vinte")
        XCTAssertEqual(language.read(30).x, "trinta")
        XCTAssertEqual(language.read(40).x, "quarenta")
        XCTAssertEqual(language.read(50).x, "cinquenta")
        XCTAssertEqual(language.read(60).x, "sessenta")
        XCTAssertEqual(language.read(70).x, "setenta")
        XCTAssertEqual(language.read(80).x, "oitenta")
        XCTAssertEqual(language.read(90).x, "noventa")
        XCTAssertEqual(language.read(21).x, "vinte e um")
        XCTAssertEqual(language.read(32).x, "trinta e dois")
        XCTAssertEqual(language.read(43).x, "quarenta e três")
        XCTAssertEqual(language.read(54).x, "cinquenta e quatro")
        XCTAssertEqual(language.read(31).x, "trinta e um")
        XCTAssertEqual(language.read(32).x, "trinta e dois")
        XCTAssertEqual(language.read(33).x, "trinta e três")
        XCTAssertEqual(language.read(40).x, "quarenta")
        XCTAssertEqual(language.read(41).x, "quarenta e um")
        XCTAssertEqual(language.read(50).x, "cinquenta")
        XCTAssertEqual(language.read(51).x, "cinquenta e um")
        XCTAssertEqual(language.read(60).x, "sessenta")
        XCTAssertEqual(language.read(61).x, "sessenta e um")
        XCTAssertEqual(language.read(70).x, "setenta")
        XCTAssertEqual(language.read(71).x, "setenta e um")
        XCTAssertEqual(language.read(80).x, "oitenta")
        XCTAssertEqual(language.read(81).x, "oitenta e um")
        XCTAssertEqual(language.read(90).x, "noventa")
        XCTAssertEqual(language.read(91).x, "noventa e um")
        XCTAssertEqual(language.read(99).x, "noventa e nove")
        XCTAssertEqual(language.read(100).x, "cem")
        XCTAssertEqual(language.read(200).x, "duzentos")
        XCTAssertEqual(language.read(300).x, "trezentos")
        XCTAssertEqual(language.read(400).x, "quatrocentos")
        XCTAssertEqual(language.read(500).x, "quinhentos")
        XCTAssertEqual(language.read(600).x, "seiscentos")
        XCTAssertEqual(language.read(700).x, "setecentos")
        XCTAssertEqual(language.read(800).x, "oitocentos")
        XCTAssertEqual(language.read(900).x, "novecentos")
        // https: streetsmartbrazil.com/learn-numbers-portuguese/
        XCTAssertEqual(language.read(101).x, "cento e um")
        XCTAssertEqual(language.read(102).x, "cento e dois")
        XCTAssertEqual(language.read(103).x, "cento e três")
        XCTAssertEqual(language.read(110).x, "cento e dez")
        XCTAssertEqual(language.read(115).x, "cento e quinze")
        XCTAssertEqual(language.read(120).x, "cento e vinte")
        XCTAssertEqual(language.read(121).x, "cento e vinte e um")
        XCTAssertEqual(language.read(126).x, "cento e vinte e seis")
        XCTAssertEqual(language.read(129).x, "cento e vinte e nove")
        XCTAssertEqual(language.read(130).x, "cento e trinta")
        XCTAssertEqual(language.read(137).x, "cento e trinta e sete")
        XCTAssertEqual(language.read(140).x, "cento e quarenta")
        XCTAssertEqual(language.read(150).x, "cento e cinquenta")
        XCTAssertEqual(language.read(160).x, "cento e sessenta")
        XCTAssertEqual(language.read(170).x, "cento e setenta")
        XCTAssertEqual(language.read(180).x, "cento e oitenta")
        XCTAssertEqual(language.read(190).x, "cento e noventa")
        XCTAssertEqual(language.read(200).x, "duzentos")
        XCTAssertEqual(language.read(201).x, "duzentos e um")
        XCTAssertEqual(language.read(210).x, "duzentos e dez")
        XCTAssertEqual(language.read(220).x, "duzentos e vinte")
        XCTAssertEqual(language.read(222).x, "duzentos e vinte e dois")
        XCTAssertEqual(language.read(300).x, "trezentos")
        XCTAssertEqual(language.read(400).x, "quatrocentos")
        XCTAssertEqual(language.read(500).x, "quinhentos")
        XCTAssertEqual(language.read(600).x, "seiscentos")
        XCTAssertEqual(language.read(700).x, "setecentos")
        XCTAssertEqual(language.read(800).x, "oitocentos")
        XCTAssertEqual(language.read(900).x, "novecentos")
        XCTAssertEqual(language.read(999).x, "novecentos e noventa e nove")
        XCTAssertEqual(language.read(1_001).x, "mil e um")
        XCTAssertEqual(language.read(1_002).x, "mil e dois")
        XCTAssertEqual(language.read(1_010).x, "mil e dez")
        XCTAssertEqual(language.read(1_020).x, "mil e vinte")
        XCTAssertEqual(language.read(1_021).x, "mil e vinte e um")
        XCTAssertEqual(language.read(1_088).x, "mil e oitenta e oito")
        XCTAssertEqual(language.read(1_099).x, "mil e noventa e nove")
        XCTAssertEqual(language.read(1_100).x, "mil e cem")
        XCTAssertEqual(language.read(1_100).x, "mil e cem")
        XCTAssertEqual(language.read(1_200).x, "mil e duzentos")
        XCTAssertEqual(language.read(1_300).x, "mil e trezentos")
        XCTAssertEqual(language.read(1_101).x, "mil cento e um")
        XCTAssertEqual(language.read(1_110).x, "mil cento e dez")
        XCTAssertEqual(language.read(1_954).x, "mil novecentos e cinquenta e quatro")
        XCTAssertEqual(language.read(1_999).x, "mil novecentos e noventa e nove")
        XCTAssertEqual(language.read(2_000).x, "dois mil")
        XCTAssertEqual(language.read(2_022).x, "dois mil e vinte e dois")
        XCTAssertEqual(language.read(2_100).x, "dois mil e cem")
        XCTAssertEqual(language.read(2_122).x, "dois mil cento e vinte e dois")
        XCTAssertEqual(language.read(2_200).x, "dois mil e duzentos")
        XCTAssertEqual(language.read(2_235).x, "dois mil duzentos e trinta e cinco")
        XCTAssertEqual(language.read(222).x, "duzentos e vinte e dois")
        XCTAssertEqual(language.read(359).x, "trezentos e cinquenta e nove")
        XCTAssertEqual(language.read(404).x, "quatrocentos e quatro")
        XCTAssertEqual(language.read(3_000).x, "três mil")
        XCTAssertEqual(language.read(4_000).x, "quatro mil")
        XCTAssertEqual(language.read(10_000).x, "dez mil")
        XCTAssertEqual(language.read(10_001).x, "dez mil e um")
        XCTAssertEqual(language.read(10_021).x, "dez mil e vinte e um")
        XCTAssertEqual(language.read(10_600).x, "dez mil e seiscentos")
        XCTAssertEqual(language.read(10_621).x, "dez mil seiscentos e vinte e um")
        XCTAssertEqual(language.read(20_000).x, "vinte mil")
        XCTAssertEqual(language.read(30_000).x, "trinta mil")
        XCTAssertEqual(language.read(100_000).x, "cem mil")
        XCTAssertEqual(language.read(100_001).x, "cem mil e um")
        XCTAssertEqual(language.read(101_000).x, "cento e um mil")
        XCTAssertEqual(language.read(101_500).x, "cento e um mil e quinhentos")
        XCTAssertEqual(language.read(101_550).x, "cento e um mil quinhentos e cinquenta")
        XCTAssertEqual(language.read(200_000).x, "duzentos mil")
        XCTAssertEqual(language.read(300_000).x, "trezentos mil")
        XCTAssertEqual(language.read(900_000).x, "novecentos mil")
        XCTAssertEqual(language.read(999_000).x, "novecentos e noventa e nove mil")
        XCTAssertEqual(language.read(999_999).x, "novecentos e noventa e nove mil novecentos e noventa e nove")
        XCTAssertEqual(language.read(1_000_000).x, "um milhão")
        XCTAssertEqual(language.read(1_100_000).x, "um milhão e cem mil")
        XCTAssertEqual(language.read(1_120_000).x, "um milhão cento e vinte mil")
        XCTAssertEqual(language.read(2_000_000).x, "dois milhões")
        XCTAssertEqual(language.read(2_000_100).x, "dois milhões e cem")
        XCTAssertEqual(language.read(2_000_127).x, "dois milhões cento e vinte e sete")
        XCTAssertEqual(language.read(1_000).x, "mil")
        XCTAssertEqual(language.read(2_000).x, "dois mil")
        XCTAssertEqual(language.read(3_000).x, "três mil")
        XCTAssertEqual(language.read(4_000).x, "quatro mil")
        XCTAssertEqual(language.read(5_000).x, "cinco mil")
        XCTAssertEqual(language.read(10_000).x, "dez mil")
        XCTAssertEqual(language.read(20_000).x, "vinte mil")
        XCTAssertEqual(language.read(100_000).x, "cem mil")
        XCTAssertEqual(language.read(1_100).x, "mil e cem")
        XCTAssertEqual(language.read(2_200).x, "dois mil e duzentos")
        XCTAssertEqual(language.read(3_300).x, "três mil e trezentos")
        XCTAssertEqual(language.read(1_101).x, "mil cento e um")
        XCTAssertEqual(language.read(4_510).x, "quatro mil quinhentos e dez")
        XCTAssertEqual(language.read(9_837).x, "nove mil oitocentos e trinta e sete")
        // https: rioandlearn.com/big-numbers-portuguese/
        XCTAssertEqual(language.read(101).x, "cento e um")
        XCTAssertEqual(language.read(130).x, "cento e trinta")
        XCTAssertEqual(language.read(199).x, "cento e noventa e nove")
        XCTAssertEqual(language.read(203).x, "duzentos e três")
        XCTAssertEqual(language.read(364).x, "trezentos e sessenta e quatro")
        XCTAssertEqual(language.read(528).x, "quinhentos e vinte e oito")
        XCTAssertEqual(language.read(400).x, "quatrocentos")
        XCTAssertEqual(language.read(415).x, "quatrocentos e quinze")
        XCTAssertEqual(language.read(626).x, "seiscentos e vinte e seis")
        XCTAssertEqual(language.read(750).x, "setecentos e cinquenta")
        XCTAssertEqual(language.read(803).x, "oitocentos e três")
        XCTAssertEqual(language.read(4_000_000).x, "quatro milhões")
        XCTAssertEqual(language.read(8_000_000).x, "oito milhões")
        XCTAssertEqual(language.read(121).x, "cento e vinte e um")
        XCTAssertEqual(language.read(237).x, "duzentos e trinta e sete")
        XCTAssertEqual(language.read(1_990).x, "mil novecentos e noventa")
        XCTAssertEqual(language.read(4_259).x, "quatro mil duzentos e cinquenta e nove")
        XCTAssertEqual(language.read(9_135).x, "nove mil cento e trinta e cinco")
        XCTAssertEqual(language.read(54_033).x, "cinquenta e quatro mil e trinta e três")
        XCTAssertEqual(language.read(173_862).x, "cento e setenta e três mil oitocentos e sessenta e dois")
        XCTAssertEqual(language.read(631_897).x, "seiscentos e trinta e um mil oitocentos e noventa e sete")
        XCTAssertEqual(language.read(7_543_100).x, "sete milhões quinhentos e quarenta e três mil e cem")
        XCTAssertEqual(language.read(16_550_024).x, "dezesseis milhões quinhentos e cinquenta mil e vinte e quatro")
        XCTAssertEqual(language.read(1_000_000).x, "um milhão")
        XCTAssertEqual(language.read(2_000_000).x, "dois milhões")
        XCTAssertEqual(language.read(4_000_000).x, "quatro milhões")
        XCTAssertEqual(language.read(8_000_000).x, "oito milhões")
        XCTAssertEqual(language.read(1_000_000_000).x, "um bilhão")
        XCTAssertEqual(language.read(2_000_000_000).x, "dois bilhões")
        XCTAssertEqual(language.read(1_000_000_000_000).x, "um trilhão")
        XCTAssertEqual(language.read(2_000_000_000_000).x, "dois trilhões")
        XCTAssertEqual(language.read(3_000_000_000_000).x, "três trilhões")
    }
}
