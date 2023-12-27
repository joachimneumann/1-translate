//
//  TestArmenianNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import XCTest

final class TestArmenianNumerals: XCTestCase{
    let armenianNumerals = Languages().armenianNumerals
    
    func test() {
        XCTAssertEqual(armenianNumerals.read(0), "zero: unknown")
        XCTAssertEqual(armenianNumerals.read(1), "Ա")
        XCTAssertEqual(armenianNumerals.read(2), "Բ")
        XCTAssertEqual(armenianNumerals.read(3), "Գ")
        XCTAssertEqual(armenianNumerals.read(4), "Դ")
        XCTAssertEqual(armenianNumerals.read(5), "Ե")
        XCTAssertEqual(armenianNumerals.read(6), "Զ")
        XCTAssertEqual(armenianNumerals.read(7), "Է")
        XCTAssertEqual(armenianNumerals.read(8), "Ը")
        XCTAssertEqual(armenianNumerals.read(9), "Թ")
        XCTAssertEqual(armenianNumerals.read(10), "Ժ")
        XCTAssertEqual(armenianNumerals.read(11), "ԺԱ")
        XCTAssertEqual(armenianNumerals.read(12), "ԺԲ")
        XCTAssertEqual(armenianNumerals.read(13), "ԺԳ")
        XCTAssertEqual(armenianNumerals.read(14), "ԺԴ")
        XCTAssertEqual(armenianNumerals.read(50), "Ծ")
        XCTAssertEqual(armenianNumerals.read(120), "ՃԻ")
        XCTAssertEqual(armenianNumerals.read(1975), "ՌՋՀԵ")
        XCTAssertEqual(armenianNumerals.read(2004), "ՍԴ")
        XCTAssertEqual(armenianNumerals.read(2_222), "ՍՄԻԲ")
        XCTAssertEqual(armenianNumerals.read(9_999), "ՔՋՂԹ")
        XCTAssertEqual(armenianNumerals.read(10_000), "Ա"+OVERLINE)
        XCTAssertEqual(armenianNumerals.read(9_000_000), "Ջ"+OVERLINE)
        XCTAssertEqual(armenianNumerals.read(11_431_255), "ՌՃԽԳ"+OVERLINE+"ՌՄԾԵ")
        XCTAssertEqual(armenianNumerals.read(9_999 * 10_000 + 9_999), "ՔՋՂԹ"+OVERLINE+"ՔՋՂԹ")
    }
}
