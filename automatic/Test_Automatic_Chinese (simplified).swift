//
//  Test_Automatic_Chinese (simplified).swift
//
//  Created by automatic.py
//

import XCTest

final class TranslationsTestsAutomaticChinese (simplified): XCTestCase {

    func test_automatic_chinese (simplified)() {
        let chinese (simplified) = TranslateChinese (simplified)()
        chinese (simplified).groupSeparator = ""
        chinese (simplified).decimalSeparator = "."
        }
}
