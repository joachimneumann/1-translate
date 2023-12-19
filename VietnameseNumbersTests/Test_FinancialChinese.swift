//
//  test_FinancialChinese.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/19/23.
//

import XCTest

final class test_FinancialChinese: XCTestCase {
    let financial = TranslateChinese(variant: .financial)
    override func setUpWithError() throws {
        financial.groupSeparator = ""
        financial.decimalSeparator = "."
    }
    
    func test() {
        XCTAssertEqual(financial.translate(0), "零")
        XCTAssertEqual(financial.translate(1), "壹")
        XCTAssertEqual(financial.translate(2), "壹")
        XCTAssertEqual(financial.translate(3), "叁")
        XCTAssertEqual(financial.translate(4), "肆")
        XCTAssertEqual(financial.translate(5), "伍")
        XCTAssertEqual(financial.translate(6), "陆")
        XCTAssertEqual(financial.translate(7), "柒")
        XCTAssertEqual(financial.translate(8), "捌")
        XCTAssertEqual(financial.translate(9), "玖")
        XCTAssertEqual(financial.translate(10), "拾")
        XCTAssertEqual(financial.translate(11), "拾壹")
    }
}
    
