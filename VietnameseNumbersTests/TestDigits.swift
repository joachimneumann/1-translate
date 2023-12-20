//
//  TestDigits.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import XCTest

final class TestDigits: XCTestCase {
    let digits = Digits()
    
    func test_digits() {
        XCTAssertEqual(digits.read(0), "0")
        XCTAssertEqual(digits.read(1), "1")
        XCTAssertEqual(digits.read(2), "2")
        XCTAssertEqual(digits.read(3), "3")
        XCTAssertEqual(digits.read(4), "4")
        XCTAssertEqual(digits.read(5), "5")
        XCTAssertEqual(digits.read(6), "6")
        XCTAssertEqual(digits.read(7), "7")
        XCTAssertEqual(digits.read(8), "8")
        XCTAssertEqual(digits.read(9), "9")
        XCTAssertEqual(digits.read(10), "10")
        XCTAssertEqual(digits.read(11), "11")
        XCTAssertEqual(digits.read(99), "99")
        XCTAssertEqual(digits.read(100), "100")
        XCTAssertEqual(digits.read(101), "101")
        XCTAssertEqual(digits.read(110), "110")
        XCTAssertEqual(digits.read(199), "199")
        XCTAssertEqual(digits.read(200), "200")
        XCTAssertEqual(digits.read(432), "432")
        XCTAssertEqual(digits.read(1_000), "1000")
        XCTAssertEqual(digits.read(1_254), "1254")
        XCTAssertEqual(digits.read(23_423_423), "23423423")
        XCTAssertEqual(digits.read(903_945_873_498), "903945873498")
        XCTAssertEqual(digits.read(23_903_945_873_498), "23903945873498")
        XCTAssertEqual(digits.read(123_903_945_873_498), "123903945873498")

        XCTAssertEqual(digits.read("1.5"), "1.5")
        XCTAssertEqual(digits.read("12224.543"), "12224.543")

        XCTAssertEqual(digits.read(-1), "-1")
        XCTAssertEqual(digits.read(-12), "-12")
        XCTAssertEqual(digits.read("-1"), "-1")
        XCTAssertEqual(digits.read("0"), "0")
        XCTAssertEqual(digits.read("-0"), "-0")
    }
}

