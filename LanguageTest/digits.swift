// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_digits: XCTestCase {

    let languages = Languages()

    func test_digits() {
        let language = languages.digits
        XCTAssertEqual(language.read(0).x, "0")
        XCTAssertEqual(language.read(1).x, "1")
        XCTAssertEqual(language.read(2).x, "2")
        XCTAssertEqual(language.read(3).x, "3")
        XCTAssertEqual(language.read(4).x, "4")
        XCTAssertEqual(language.read(5).x, "5")
        XCTAssertEqual(language.read(6).x, "6")
        XCTAssertEqual(language.read(7).x, "7")
        XCTAssertEqual(language.read(8).x, "8")
        XCTAssertEqual(language.read(9).x, "9")
        XCTAssertEqual(language.read(10).x, "10")
        XCTAssertEqual(language.read(11).x, "11")
        XCTAssertEqual(language.read(99).x, "99")
        XCTAssertEqual(language.read(100).x, "100")
        XCTAssertEqual(language.read(101).x, "101")
        XCTAssertEqual(language.read(110).x, "110")
        XCTAssertEqual(language.read(199).x, "199")
        XCTAssertEqual(language.read(200).x, "200")
        XCTAssertEqual(language.read(432).x, "432")
        XCTAssertEqual(language.read(1_000).x, "1000")
        XCTAssertEqual(language.read(1_254).x, "1254")
        XCTAssertEqual(language.read(23_423_423).x, "23423423")
        XCTAssertEqual(language.read(903_945_873_498).x, "903945873498")
        XCTAssertEqual(language.read(23_903_945_873_498).x, "23903945873498")
        XCTAssertEqual(language.read(123_903_945_873_498).x, "123903945873498")

        let temp1 = 1.5
        XCTAssertEqual(language.read(temp1).x, "1 . 5")

        let temp2 = 12224.543
        XCTAssertEqual(language.read(temp2).x, "12224 . 5 4 3")
        XCTAssertEqual(language.read(-1).x, "-1")
        XCTAssertEqual(language.read(-12).x, "-12")
        XCTAssertEqual(language.read(-1).x, "-1")
        XCTAssertEqual(language.read(0).x, "0")
        XCTAssertEqual(language.read(-0).x, "0")
    }
}
