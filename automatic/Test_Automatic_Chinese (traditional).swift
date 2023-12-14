//
//  Test_Automatic_Chinese (traditional).swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticChinese (traditional): XCTestCase {

    func test_automatic_chinese (traditional)() {
        let chinese (traditional) = TranslateChinese (traditional)()
        chinese (traditional).groupSeparator = ""
        chinese (traditional).decimalSeparator = "."
        }
}
