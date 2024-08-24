//
//  NumberTranslatorTests.swift
//  NumberTranslatorTests
//
//  Created by Joachim Neumann on 23.08.24.
//

import XCTest
@testable import NumberTranslator

class NumberTranslatorTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    let language = ThaiNumerals()
    
    func test_thaiNumerals() {
        XCTAssertEqual(language.numberToText(0).x, "๐")
        XCTAssertEqual(language.numberToText(1).x, "๑")
        XCTAssertEqual(language.numberToText(2).x, "๒")
        XCTAssertEqual(language.numberToText(3).x, "๓")
        XCTAssertEqual(language.numberToText(4).x, "๔")
        XCTAssertEqual(language.numberToText(5).x, "๕")
        XCTAssertEqual(language.numberToText(6).x, "๖")
        XCTAssertEqual(language.numberToText(7).x, "๗")
        XCTAssertEqual(language.numberToText(8).x, "๘")
        XCTAssertEqual(language.numberToText(9).x, "๙")
        XCTAssertEqual(language.numberToText(10).x, "๑๐")
        XCTAssertEqual(language.numberToText(11).x, "๑๑")
        XCTAssertEqual(language.numberToText(12).x, "๑๒")
        XCTAssertEqual(language.numberToText(13).x, "๑๓")
        XCTAssertEqual(language.numberToText(14).x, "๑๔")
        XCTAssertEqual(language.numberToText(114).x, "๑๑๔")
        XCTAssertEqual(language.numberToText("114.7").x, "๑๑๔.๗")
        XCTAssertEqual(language.numberToText(1_147).x, "๑๑๔๗")
        XCTAssertEqual(language.numberToText(1_000).x, "๑๐๐๐")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}

extension String {
    var x: String {
        self
//        self.replacingOccurrences(of: Languages.WordSplitter, with: "")
    }
}
