//
//  LanguageExtensions.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

extension Int {
    var E1: Int { self / 10 }
    var E1x: Int { self - self / 10 * 10 } // self % 10?
    var E2: Int { self / 100 }
    var E2x: Int { self - self / 100 * 100 }
    var E3: Int { self / 1_000 }
    var E3x: Int { self - self / 1_000 * 1_000}
    var E4: Int { self / 10_000 }
    var E4x: Int { self - self / 10_000 * 10_000 }
    var E5: Int { self / 100_000 }
    var E5x: Int { self - self / 100_000 * 100_000 }
    var E6: Int { self / 1_000_000 }
    var E6x: Int { self - self / 1_000_000 * 1_000_000 }
    var E8: Int { self / 100_000_000 }
    var E8x: Int { self - self / 100_000_000 * 100_000_000 }
    var E9: Int { self / 1_000_000_000 }
    var E9x: Int { self - self / 1_000_000_000 * 1_000_000_000 }
    var E12: Int { self / 1_000_000_000_000 }
    var E12x: Int { self - self / 1_000_000_000_000 * 1_000_000_000_000 }
    var secondLastDigit: Int { (self /  10) % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}
