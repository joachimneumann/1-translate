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
// 1, BabylonianImpl.symbolOne
// 60, BabylonianImpl.symbolOne  // 6,0
// 61, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne  // 6,1
// 147, BabylonianImpl.symbolTwo+BabylonianImpl.symbolTwenty+BabylonianImpl.symbolSeven  // 2,27
// 3661, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne+BabylonianImpl.symbolOne  // 1,1,1
// 21609, BabylonianImpl.symbolSix+BabylonianImpl.symbolNone+BabylonianImpl.symbolNine  // 6,0 9.
// 424000,  BabylonianImpl.symbolOne+BabylonianImpl.symbolFifty+BabylonianImpl.symbolSeven+BabylonianImpl.symbolForty+BabylonianImpl.symbolSix+BabylonianImpl.symbolForty  // 1,57,46,40

        language.babylonianEmptyColumn = true
// 1, BabylonianImpl.symbolOne
// 60, BabylonianImpl.symbolOne  // 6,0
// 61, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne  // 6,1
// 147, BabylonianImpl.symbolTwo+BabylonianImpl.symbolTwenty+BabylonianImpl.symbolSeven  // 2,27
// 3661, BabylonianImpl.symbolOne+BabylonianImpl.symbolOne+BabylonianImpl.symbolOne  // 1,1,1
// 21609, BabylonianImpl.symbolSix+BabylonianImpl.symbolEmptyColumn+BabylonianImpl.symbolNine  // 6,0 9.
// 424000, BabylonianImpl.symbolOne+BabylonianImpl.symbolFifty+BabylonianImpl.symbolSeven+BabylonianImpl.symbolForty+BabylonianImpl.symbolSix+BabylonianImpl.symbolForty  // 1,57,46,40
    }
}
