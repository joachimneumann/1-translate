//
//  TestArmenian.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import XCTest

final class TestArmenian: XCTestCase{
    let armenian=Armenian()
    
    func test() {
        XCTAssertEqual(armenian.read(0), "զրո")
        XCTAssertEqual(armenian.read(1), "մեկ")
        XCTAssertEqual(armenian.read(2), "երկու")
        XCTAssertEqual(armenian.read(3), "երեք")
        XCTAssertEqual(armenian.read(4), "չորս")
        XCTAssertEqual(armenian.read(5), "հինգ")
        XCTAssertEqual(armenian.read(6), "վեց")
        XCTAssertEqual(armenian.read(7), "յոթ")
        XCTAssertEqual(armenian.read(8), "ութ")
        XCTAssertEqual(armenian.read(9), "ինը")
        XCTAssertEqual(armenian.read(10), "տասը")
        XCTAssertEqual(armenian.read(11), "տասնմեկ")  
        XCTAssertEqual(armenian.read(12), "տասներկու")
        XCTAssertEqual(armenian.read(13), "տասներեք")
        XCTAssertEqual(armenian.read(14), "տասնչորս")
        XCTAssertEqual(armenian.read(15), "տասնհինգ")
        XCTAssertEqual(armenian.read(16), "տասնվեց")
        XCTAssertEqual(armenian.read(17), "տասնյոթ")
        XCTAssertEqual(armenian.read(18), "տասնութ")
        XCTAssertEqual(armenian.read(19), "տասնինը")
        XCTAssertEqual(armenian.read(20), "քսան")
        XCTAssertEqual(armenian.read(21), "քսանմեկ")
        XCTAssertEqual(armenian.read(22), "քսաներկու")
        XCTAssertEqual(armenian.read(23), "քսաներեք")
        XCTAssertEqual(armenian.read(24), "քսանչորս")
        XCTAssertEqual(armenian.read(25), "քսանհինգ")
        XCTAssertEqual(armenian.read(26), "քսանվեց")
        XCTAssertEqual(armenian.read(27), "քսանյոթ")
        XCTAssertEqual(armenian.read(28), "քսանութ")
        XCTAssertEqual(armenian.read(29), "քսանինը")
        XCTAssertEqual(armenian.read(30), "երեսուն")
        XCTAssertEqual(armenian.read(40), "քառասուն")
        XCTAssertEqual(armenian.read(50), "հիսուն")
        XCTAssertEqual(armenian.read(60), "վաթսուն")
        XCTAssertEqual(armenian.read(70), "յոթանասուն")
        XCTAssertEqual(armenian.read(80), "ութսուն")
        XCTAssertEqual(armenian.read(90), "ինիսուն")
        XCTAssertEqual(armenian.read(100), "հարյուր")
        XCTAssertEqual(armenian.read(200), "երկու հարյուր")
        XCTAssertEqual(armenian.read(300), "երեք հարյուր")
        XCTAssertEqual(armenian.read(400), "չորս հարյուր")
        XCTAssertEqual(armenian.read(500), "հինգ հարյուր")
        XCTAssertEqual(armenian.read(600), "վեց հարյուր")
        XCTAssertEqual(armenian.read(700), "յոթ հարյուր")
        XCTAssertEqual(armenian.read(800), "ութ հարյուր")
        XCTAssertEqual(armenian.read(900), "ինը հարյուր")
        XCTAssertEqual(armenian.read(1_000), "հազար")
        XCTAssertEqual(armenian.read(2_000), "երկու հազար")
        XCTAssertEqual(armenian.read(3_000), "երեք հազար")
        XCTAssertEqual(armenian.read(4_000), "չորս հազար")
        XCTAssertEqual(armenian.read(5_000), "հինգ հազար")
        XCTAssertEqual(armenian.read(6_000), "վեց հազար")
        XCTAssertEqual(armenian.read(7_000), "յոթ հազար")
        XCTAssertEqual(armenian.read(8_000), "ութ հազար")
        XCTAssertEqual(armenian.read(9_000), "ինը հազար")
        XCTAssertEqual(armenian.read(10_000), "տասը հազար")
        XCTAssertEqual(armenian.read(100_000), "հարյուր հազար")
        XCTAssertEqual(armenian.read(1_000_000), "միլիոն")
    }
}
