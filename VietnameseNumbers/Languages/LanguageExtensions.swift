//
//  LanguageExtensions.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

extension Int {
    var _10: Int { self / 10 }
    var _10x: Int { self - self / 10 * 10 }
    var _100: Int { self / 100 }
    var _100x: Int { self - self / 100 * 100 }
    var _1_000: Int { self / 1_000 }
    var _1_000x: Int { self - self / 1_000 * 1_000}
    var _10_000: Int { self / 10_000 }
    var _10_000x: Int { self - self / 10_000 * 10_000 }
    var _100_000: Int { self / 100_000 }
    var _100_000x: Int { self - self / 100_000 * 100_000 }
    var _E6: Int { self / 1_000_000 }
    var _E6x: Int { self - self / 1_000_000 * 1_000_000 }
    var _E9: Int { self / 1_000_000_000 }
    var _E9x: Int { self - self / 1_000_000_000 * 1_000_000_000 }
    var _E12: Int { self / 1_000_000_000_000 }
    var _Ę12x: Int { self - self / 1_000_000_000_000 * 1_000_000_000_000 }
}
