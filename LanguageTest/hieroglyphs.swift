// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_hieroglyphs: XCTestCase {

    let languages = Languages()

    func test_hieroglyphs() {
        let language = languages.hieroglyphs
        XCTAssertEqual(language.read(0).x, HieroglyphsImpl.symbolZero)
        XCTAssertEqual(language.read(1).x, HieroglyphsImpl.symbolOne)
        XCTAssertEqual(language.read(2).x, HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(language.read(3).x, HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(language.read(10).x, HieroglyphsImpl.symbolTen)
        XCTAssertEqual(language.read(100).x, HieroglyphsImpl.symbolHundred)
        XCTAssertEqual(language.read(1_000).x, HieroglyphsImpl.symbolThousand)
        XCTAssertEqual(language.read(4_122).x, HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolHundred+HieroglyphsImpl.symbolTen+HieroglyphsImpl.symbolTen+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(language.read(4_002).x, HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(language.read(10_000).x, HieroglyphsImpl.symbolTenThousand)
        XCTAssertEqual(language.read(100_000).x, HieroglyphsImpl.symbolHundredThousand)
        XCTAssertEqual(language.read(1_000_000).x, HieroglyphsImpl.symbolMillion)
    }
}
