// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest
import NumberTranslator

final class Test_ThaiNumerals: XCTestCase {
    let language = ThaiNumeralsImplementation()
    func testThaiNumerals() {
        XCTAssertEqual(language.translate(0).x, "๐")
        XCTAssertEqual(language.translate(1).x, "๑")
        XCTAssertEqual(language.translate(2).x, "๒")
        XCTAssertEqual(language.translate(3).x, "๓")
        XCTAssertEqual(language.translate(4).x, "๔")
        XCTAssertEqual(language.translate(5).x, "๕")
        XCTAssertEqual(language.translate(6).x, "๖")
        XCTAssertEqual(language.translate(7).x, "๗")
        XCTAssertEqual(language.translate(8).x, "๘")
        XCTAssertEqual(language.translate(9).x, "๙")
        XCTAssertEqual(language.translate(10).x, "๑๐")
        XCTAssertEqual(language.translate(11).x, "๑๑")
        XCTAssertEqual(language.translate(12).x, "๑๒")
        XCTAssertEqual(language.translate(13).x, "๑๓")
        XCTAssertEqual(language.translate(14).x, "๑๔")
        XCTAssertEqual(language.translate(114).x, "๑๑๔")
        XCTAssertEqual(language.translate(114.7).x, "๑๑๔.๗")
        XCTAssertEqual(language.translate(1_147).x, "๑๑๔๗")
        XCTAssertEqual(language.translate(1_000).x, "๑๐๐๐")
        XCTAssertEqual(language.translate(-1).x, "-๑")
        XCTAssertEqual(language.translate(1.3).x, "๑.๓")
    }
}
