//
//  TestArmenianNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import XCTest

final class TestArmenianNumerals: XCTestCase{
    let armenian=Armenian()
    
    func test() {
        XCTAssertEqual(armenian.read(0), "zero: unknown")
        XCTAssertEqual(armenian.read(1), "Ա")
        XCTAssertEqual(armenian.read(2), "Բ")
        XCTAssertEqual(armenian.read(3), "Գ")
        XCTAssertEqual(armenian.read(4), "Դ")
        XCTAssertEqual(armenian.read(5), "Ե")
        XCTAssertEqual(armenian.read(6), "Զ")
        XCTAssertEqual(armenian.read(7), "Է")
        XCTAssertEqual(armenian.read(8), "Ը")
        XCTAssertEqual(armenian.read(9), "Թ")
        XCTAssertEqual(armenian.read(10), "Ժ")
        XCTAssertEqual(armenian.read(11), "ԺԱ")
        XCTAssertEqual(armenian.read(12), "ԺԲ")
        XCTAssertEqual(armenian.read(13), "ԺԳ")
        XCTAssertEqual(armenian.read(14), "ԺԴ")
        XCTAssertEqual(armenian.read(50), "Ծ")
        XCTAssertEqual(armenian.read(120), "ՃԻ")
        XCTAssertEqual(armenian.read(1975), "ՌՋՀԵ")
        XCTAssertEqual(armenian.read(2004), "ՍԴ")
        XCTAssertEqual(armenian.read(2_222), "ՍՄԻԲ")
        XCTAssertEqual(armenian.read(9_999), "ՔՋՂԹ")
        XCTAssertEqual(armenian.read(10_000), "Ա"+OVERLINE)
        XCTAssertEqual(armenian.read(9_000_000), "Ջ"+OVERLINE)
        XCTAssertEqual(armenian.read(11_431_255), "ՌՃԽԳ"+OVERLINE+"ՌՄԾԵ")
        XCTAssertEqual(armenian.read(9_999 * 10_000 + 9_999), "ՔՋՂԹ"+OVERLINE+"ՔՋՂԹ")
    }
}
