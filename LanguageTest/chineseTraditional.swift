// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_chineseTraditional: XCTestCase {

    let languages = Languages()

    func test_chineseTraditional() {
        let language = languages.chineseTraditional
        XCTAssertEqual(language.read(0).x, "零")
        XCTAssertEqual(language.read(10_000).x, "一萬")
        XCTAssertEqual(language.read(789_0298).x, "七百 八十九萬 零二百 九十八")
    }
}
