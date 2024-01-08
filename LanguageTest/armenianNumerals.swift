// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_armenianNumerals: XCTestCase {

    let languages = Languages()

    func test_armenianNumerals() {
        let language = languages.armenianNumerals
        XCTAssertEqual(language.read(0).x, "zero unknown")
        XCTAssertEqual(language.read(1).x, "Ա")
        XCTAssertEqual(language.read(2).x, "Բ")
        XCTAssertEqual(language.read(3).x, "Գ")
        XCTAssertEqual(language.read(4).x, "Դ")
        XCTAssertEqual(language.read(5).x, "Ե")
        XCTAssertEqual(language.read(6).x, "Զ")
        XCTAssertEqual(language.read(7).x, "Է")
        XCTAssertEqual(language.read(8).x, "Ը")
        XCTAssertEqual(language.read(9).x, "Թ")
        XCTAssertEqual(language.read(10).x, "Ժ")
        XCTAssertEqual(language.read(11).x, "ԺԱ")
        XCTAssertEqual(language.read(12).x, "ԺԲ")
        XCTAssertEqual(language.read(13).x, "ԺԳ")
        XCTAssertEqual(language.read(14).x, "ԺԴ")
        XCTAssertEqual(language.read(50).x, "Ծ")
        XCTAssertEqual(language.read(120).x, "ՃԻ")
        XCTAssertEqual(language.read(1975).x, "ՌՋՀԵ")
        XCTAssertEqual(language.read(2004).x, "ՍԴ")
        XCTAssertEqual(language.read(2_222).x, "ՍՄԻԲ")
        XCTAssertEqual(language.read(9_999).x, "ՔՋՂԹ")
        XCTAssertEqual(language.read(10_000).x, "10_000 Ա")
        XCTAssertEqual(language.read_OVERLINE(10_000)!.x, "")
        XCTAssertEqual(language.read(9_000_000).x, "9_000_000 Ջ")
        XCTAssertEqual(language.read_OVERLINE(9_000_000)!.x, "")
        XCTAssertEqual(language.read(11_431_255).x, "11_431_255 ՌՃԽԳ")
        XCTAssertEqual(language.read_OVERLINE(11_431_255)!.x, "ՌՄԾԵ")
// 9_999*10_000+9_999 ՔՋՂԹ OVERLINE ՔՋՂԹ
    }
}
