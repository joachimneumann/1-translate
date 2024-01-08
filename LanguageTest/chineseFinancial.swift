// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_chineseFinancial: XCTestCase {

    let languages = Languages()

    func test_chineseFinancial() {
        let language = languages.chineseFinancial
        XCTAssertEqual(language.read(0).x, "零")
        XCTAssertEqual(language.read(1).x, "壹")
        XCTAssertEqual(language.read(2).x, "壹")
        XCTAssertEqual(language.read(3).x, "叁")
        XCTAssertEqual(language.read(4).x, "肆")
        XCTAssertEqual(language.read(5).x, "伍")
        XCTAssertEqual(language.read(6).x, "陆")
        XCTAssertEqual(language.read(7).x, "柒")
        XCTAssertEqual(language.read(8).x, "捌")
        XCTAssertEqual(language.read(9).x, "玖")
        XCTAssertEqual(language.read(10).x, "拾")
        XCTAssertEqual(language.read(11).x, "拾壹")
        XCTAssertEqual(language.read(10_000).x, "壹萬")
    }
}
