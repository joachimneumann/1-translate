//
//  Test_Extensions.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

import XCTest

final class Extensions: XCTestCase {
    func test_extension() {
        var e0: Period
        var e3: Period
        var e6: Period
//        var e9: Period
//        var e12: Period
        
        var i = 0
        XCTAssertNil(i.e3)
        XCTAssertNil(i.e6)
        XCTAssertNil(i.e9)
        XCTAssertNil(i.e12)
        e0 = i.e0

        XCTAssertEqual(e0.__x, 0)
        XCTAssertEqual(e0._x_, 0)
        XCTAssertEqual(e0.x__, 0)

        i = 123
        XCTAssertNil(i.e3)
        XCTAssertNil(i.e6)
        XCTAssertNil(i.e9)
        XCTAssertNil(i.e12)
        e0 = i.e0

        XCTAssertEqual(e0.__x, 3)
        XCTAssertEqual(e0._x_, 2)
        XCTAssertEqual(e0.x__, 1)
        XCTAssertEqual(e0._xx, 23)

        i = 123_456
        XCTAssertNotNil(i.e3)
        XCTAssertNil(i.e6)
        XCTAssertNil(i.e9)
        XCTAssertNil(i.e12)
        e0 = i.e0
        e3 = i.e3!

        XCTAssertEqual(e0.__x, 6)
        XCTAssertEqual(e0._x_, 5)
        XCTAssertEqual(e0.x__, 4)
        XCTAssertEqual(e0._xx, 56)
        XCTAssertEqual(e3.__x, 3)
        XCTAssertEqual(e3._x_, 2)
        XCTAssertEqual(e3.x__, 1)
        XCTAssertEqual(e3._xx, 23)
        
        i = 1_000_000
        XCTAssertNotNil(i.e3)
        XCTAssertNotNil(i.e6)
        XCTAssertNil(i.e9)
        XCTAssertNil(i.e12)
        e0 = i.e0
        e3 = i.e3!
        e6 = i.e6!

        XCTAssertEqual(e0.__x, 0)
        XCTAssertEqual(e0._x_, 0)
        XCTAssertEqual(e0.x__, 0)
        XCTAssertEqual(e0._xx, 0)

        XCTAssertEqual(e3.__x, 0)
        XCTAssertEqual(e3._x_, 0)
        XCTAssertEqual(e3.x__, 0)
        XCTAssertEqual(e3._xx, 0)

        XCTAssertEqual(e6.__x, 1)
        XCTAssertEqual(e6._x_, 0)
        XCTAssertEqual(e6.x__, 0)
        XCTAssertEqual(e6._xx, 1)
    }
}
