//
//  Test_Automatic_Japanese.swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticJapanese: XCTestCase {

    func test_automatic_japanese() {
        let japanese = TranslateJapanese()
        japanese.groupSeparator = ""
        japanese.decimalSeparator = "."
        XCTAssertEqual(japanese.translate(1_010、1000), "10")
        XCTAssertEqual(japanese.translate(1_012、1000), "12")
        XCTAssertEqual(japanese.translate(1_015、1000), "15")
        XCTAssertEqual(japanese.translate(1_035、1000), "35")
        XCTAssertEqual(japanese.translate(1_099、1000), "90")
        XCTAssertEqual(japanese.translate(201_001、200), "One000One")
        XCTAssertEqual(japanese.translate(62_003_005、6200万人の3000), "5")
        XCTAssertEqual(japanese.translate(3.1415926、3ポイントワン4ワン5ナイン2), "6")
        XCTAssertEqual(japanese.translate(-3.1415926、マイナス3ポイントワン4ナイン2), "66")
        }
}
