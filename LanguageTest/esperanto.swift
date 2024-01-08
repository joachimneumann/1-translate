// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_esperanto: XCTestCase {

    let languages = Languages()

    func test_esperanto() {
        let language = languages.esperanto
        XCTAssertEqual(language.read(0).x, "nul")
        XCTAssertEqual(language.read(1).x, "unu")
        XCTAssertEqual(language.read(2).x, "du")
        XCTAssertEqual(language.read(3).x, "tri")
        XCTAssertEqual(language.read(4).x, "kvar")
        XCTAssertEqual(language.read(5).x, "kvin")
        XCTAssertEqual(language.read(6).x, "ses")
        XCTAssertEqual(language.read(7).x, "sep")
        XCTAssertEqual(language.read(8).x, "ok")
        XCTAssertEqual(language.read(9).x, "naŭ")
        XCTAssertEqual(language.read(10).x, "dek")
        XCTAssertEqual(language.read(11).x, "dek unu")
        XCTAssertEqual(language.read(12).x, "dek du")
        XCTAssertEqual(language.read(13).x, "dek tri")
        XCTAssertEqual(language.read(16).x, "dek ses")
        XCTAssertEqual(language.read(20).x, "dudek")
        XCTAssertEqual(language.read(21).x, "dudek unu")
        XCTAssertEqual(language.read(22).x, "dudek du")
        XCTAssertEqual(language.read(23).x, "dudek tri")
        XCTAssertEqual(language.read(24).x, "dudek kvar")
        XCTAssertEqual(language.read(30).x, "tridek")
        XCTAssertEqual(language.read(42).x, "kvardek du")
        XCTAssertEqual(language.read(100).x, "cent")
        XCTAssertEqual(language.read(104).x, "cent kvar")
        XCTAssertEqual(language.read(105).x, "cent kvin")
        XCTAssertEqual(language.read(106).x, "cent ses")
        XCTAssertEqual(language.read(221).x, "ducent dudek unu")
        XCTAssertEqual(language.read(222).x, "ducent dudek du")
        XCTAssertEqual(language.read(223).x, "ducent dudek tri")
        XCTAssertEqual(language.read(224).x, "ducent dudek kvar")
        XCTAssertEqual(language.read(442).x, "kvarcent kvardek du")
        XCTAssertEqual(language.read(1_000).x, "mil")
        XCTAssertEqual(language.read(1_729).x, "mil sepcent dudek naŭ")
        XCTAssertEqual(language.read(22_729).x, "dudek du mil sepcent dudek naŭ")
        XCTAssertEqual(language.read(1_000_000).x, "miliono")
        XCTAssertEqual(language.read(2_200_000).x, "du milionoj ducent mil")
        XCTAssertEqual(language.read(3_022_729).x, "tri milionoj dudek du mil sepcent dudek naŭ")
        XCTAssertEqual(language.read(1_000_000_000).x, "miliardo")
        XCTAssertEqual(language.read(4_003_022_729).x, "kvar miliardoj tri milionoj dudek du mil sepcent dudek naŭ")
        XCTAssertEqual(language.read(1_000_000_000_000).x, "biliono")
        XCTAssertEqual(language.read(5_004_003_022_729).x, "kvin bilionoj kvar miliardoj tri milionoj dudek du mil sepcent dudek naŭ")
        XCTAssertEqual(language.read(-1).x, "minus unu")
        XCTAssertEqual(language.read(-1_000_000).x, "minus miliono")
        XCTAssertEqual(language.read("1.5").x, "unu kaj kvin")
    }
}