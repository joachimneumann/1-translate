//
//  test_FinancialMandarin.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/19/23.
//

import XCTest

final class test_FinancialMandarin: XCTestCase {
    let financialMandarin = TranslateMandarin(variant: .financial)
    override func setUpWithError() throws {
        financialMandarin.groupSeparator = ""
        financialMandarin.decimalSeparator = "."
    }
    
    func test() {
        XCTAssertEqual(financialMandarin.translate(0), "零")
        XCTAssertEqual(financialMandarin.translate(1), "壹")
        XCTAssertEqual(financialMandarin.translate(2), "壹")
        XCTAssertEqual(financialMandarin.translate(3), "叁")
        XCTAssertEqual(financialMandarin.translate(4), "肆")
        XCTAssertEqual(financialMandarin.translate(5), "伍")
        XCTAssertEqual(financialMandarin.translate(6), "陆")
        XCTAssertEqual(financialMandarin.translate(7), "柒")
        XCTAssertEqual(financialMandarin.translate(8), "捌")
        XCTAssertEqual(financialMandarin.translate(9), "玖")
        XCTAssertEqual(financialMandarin.translate(10), "拾")
        XCTAssertEqual(financialMandarin.translate(11), "拾壹")
    }
}
    
