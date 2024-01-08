// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_babylonian: XCTestCase {

    let languages = Languages()

    func test_babylonian() {
        let language = languages.babylonian

        language.babylonianEmptyColumn = false
        XCTAssertEqual(language.read(1).x, BabylonianImpl.symbolOne)
        XCTAssertEqual(language.read(60).x, BabylonianImpl.symbolOne)  // 6,0
        XCTAssertEqual(language.read(61).x, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne)  // 6,1
        XCTAssertEqual(language.read(147).x, BabylonianImpl.symbolTwo+BabylonianImpl.symbolTwenty+BabylonianImpl.symbolSeven)  // 2,27
        XCTAssertEqual(language.read(3661).x, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne+BabylonianImpl.symbolOne)  // 1,1,1
        XCTAssertEqual(language.read(21609).x, BabylonianImpl.symbolSix+BabylonianImpl.symbolNone+BabylonianImpl.symbolNine)  // 6,0 9.
        XCTAssertEqual(language.read(424000).x,  BabylonianImpl.symbolOne+BabylonianImpl.symbolFifty+BabylonianImpl.symbolSeven+BabylonianImpl.symbolForty+BabylonianImpl.symbolSix+BabylonianImpl.symbolForty)  // 1,57,46,40

        language.babylonianEmptyColumn = true
        XCTAssertEqual(language.read(1).x, BabylonianImpl.symbolOne)
        XCTAssertEqual(language.read(60).x, BabylonianImpl.symbolOne)  // 6,0
        XCTAssertEqual(language.read(61).x, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne)  // 6,1
        XCTAssertEqual(language.read(147).x, BabylonianImpl.symbolTwo+BabylonianImpl.symbolTwenty+BabylonianImpl.symbolSeven)  // 2,27
        XCTAssertEqual(language.read(3661).x, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne+BabylonianImpl.symbolOne)  // 1,1,1
        XCTAssertEqual(language.read(21609).x, BabylonianImpl.symbolSix+BabylonianImpl.symbolEmptyColumn+BabylonianImpl.symbolNine)  // 6,0 9.
        XCTAssertEqual(language.read(424000).x, BabylonianImpl.symbolOne+BabylonianImpl.symbolFifty+BabylonianImpl.symbolSeven+BabylonianImpl.symbolForty+BabylonianImpl.symbolSix+BabylonianImpl.symbolForty)  // 1,57,46,40
    }
}
