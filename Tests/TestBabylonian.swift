//
//  TestBabylonian.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/27/23.
//

import Foundation

import XCTest

final class TestBabylonian: XCTestCase {
    let babylonian = Languages().babylonian
    func test_babylonian() {
        XCTAssertEqual(babylonian.read(1), BabylonianImpl.symbolOne)
        XCTAssertEqual(babylonian.read(60), BabylonianImpl.symbolOne) // 6,0
        XCTAssertEqual(babylonian.read(61), BabylonianImpl.symbolOne+" "+BabylonianImpl.symbolOne) // 6,1
        XCTAssertEqual(babylonian.read(147), BabylonianImpl.symbolTwo+" "+BabylonianImpl.symbolTwenty+BabylonianImpl.symbolSeven) // 2,27
        XCTAssertEqual(babylonian.read(3661), BabylonianImpl.symbolOne+" "+BabylonianImpl.symbolOne+" "+BabylonianImpl.symbolOne) // 1,1,1
        XCTAssertEqual(babylonian.read(21609), BabylonianImpl.symbolSix+" "+BabylonianImpl.symbolNone+BabylonianImpl.symbolNine) // 6,0 9.
        XCTAssertEqual(babylonian.read(424000), BabylonianImpl.symbolOne+" "+BabylonianImpl.symbolFifty+BabylonianImpl.symbolSeven+" "+BabylonianImpl.symbolForty+BabylonianImpl.symbolSix+" "+BabylonianImpl.symbolForty) // 1,57,46,40
    }
}
