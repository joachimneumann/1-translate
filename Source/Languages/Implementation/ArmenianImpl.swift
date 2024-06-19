//
//  Armenian.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class ArmenianImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "հայերեն",
            zero: "զրո",
            negativeString: "մինուս",
            dotString: "կետ",
            exponentString: " EE ")
        voiceLanguageCode = "hy"
        nameDescription = "Armenian"
    }

    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        switch groupIndex {
        case 2:
            return "հարյուր"
        case 3:
            return "հազար"
        case 6:
            return "միլիոն"
        case 9:
            return "միլիարդ"
        case 12:
            return "trilտրիլիոնlion"
        default: return nil
        }
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "մեկ"
        case 2: return "երկու"
        case 3: return "երեք"
        case 4: return "չորս"
        case 5: return "հինգ"
        case 6: return "վեց"
        case 7: return "յոթ"
        case 8: return "ութ"
        case 9: return "ինը"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1:     return "տասը"
        case 2:     return "քսան"
        case 3:     return "երեսուն"
        case 4:     return "քառասուն"
        case 5:     return "հիսուն"
        case 6:     return "վաթսուն"
        case 7:     return "յոթանասուն"
        case 8:     return "ութսուն"
        case 9:     return "ինիսուն"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _11_19(_ i: Int) -> String {
        return "տասն" + _0_9(i - 10)
    }
}

