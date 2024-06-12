//
//  languageTest.swift
//  LanguageTest
//
//  Created by Joachim Neumann on 6/12/24.
//

import XCTest

final class Test_language: XCTestCase {
    
    let language = Languages().english
    
    func test_english() {
        XCTAssertEqual(aboveLimit(1234, 3), 1)
        XCTAssertEqual(aboveLimit(12345, 3), 12)
        XCTAssertEqual(aboveLimit(123456, 3), 123)
        XCTAssertEqual(aboveLimit(1234567, 3), 1234)
        XCTAssertEqual(belowLimit(1234, 3), 234)
        XCTAssertEqual(belowLimit(12345, 3), 345)
        XCTAssertEqual(belowLimit(123456, 3), 456)
        XCTAssertEqual(belowLimit(1234567, 3), 567)
    }
}
