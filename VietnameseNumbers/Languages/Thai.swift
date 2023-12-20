//
//  Thai.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Thai: TenBasedLanguage {
    var negativeString = "ลบ"
    var dotString = "จุด"
    var exponentString = "e"
    var name: String = "ภาษาไทย"
    
    override init() {
        super.init()
        englishName = "Thai"
        afterNegative = " "
//        onlyOne = "หนึ่ง"
    }
    
    func read_0_9(_ i: Int) -> String {
        switch i {
        case 0: return "ศูนย์"
        case 1: return "เอ็ด"
        case 2: return "สอง"
        case 3: return "สาม"
        case 4: return "สี่"
        case 5: return "ห้า"
        case 6: return "หก"
        case 7: return "เจ็ด"
        case 8: return "แปด"
        case 9: return "เก้า"
        default: return " translate_0_10: outside range "
        }
    }
}
