//
//  TestHieroglyphs.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/27/23.
//

import XCTest

final class TestHieroglyphs: XCTestCase {
    let hieroglyphs = Languages().hieroglyphs
    func test_hieroglyphs() {
        XCTAssertEqual(hieroglyphs.read(0), HieroglyphsImpl.symbolZero)
        XCTAssertEqual(hieroglyphs.read(1), HieroglyphsImpl.symbolOne)
        XCTAssertEqual(hieroglyphs.read(2), HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(hieroglyphs.read(3), HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(hieroglyphs.read(10), HieroglyphsImpl.symbolTen)
        XCTAssertEqual(hieroglyphs.read(100), HieroglyphsImpl.symbolHundred)
        XCTAssertEqual(hieroglyphs.read(1_000), HieroglyphsImpl.symbolThousand)
        XCTAssertEqual(hieroglyphs.read(4_122), HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolHundred+HieroglyphsImpl.symbolTen+HieroglyphsImpl.symbolTen+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(hieroglyphs.read(4_002), HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolThousand+HieroglyphsImpl.symbolOne+HieroglyphsImpl.symbolOne)
        XCTAssertEqual(hieroglyphs.read(10_000), HieroglyphsImpl.symbolTenThousand)
        XCTAssertEqual(hieroglyphs.read(100_000), HieroglyphsImpl.symbolHundredThousand)
        XCTAssertEqual(hieroglyphs.read(1_000_000), HieroglyphsImpl.symbolMillion)
    }
}
