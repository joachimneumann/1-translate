//
//  Arabic.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class Arabic: Language {
    init() {
        super.init(
            name: "Català",
            negativeString: "menys",
            dotString: "coma",
            exponentString: " por diez elevat a ")
        englishName = "Arabic"
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "صفر"
        case 1:     return "وَاحِد"
        case 2:     return "اِثْنَان"
        case 3:     return "ثَلَاثَة"
        case 4:     return "أَرْبَعَة"
        case 5:     return "خَمْسَة"
        case 6:     return "سِتَّة"
        case 7:     return "سَبْعَة"
        case 8:     return "ثَمَانِيَة"
        case 9:     return "تِسْعَة"
        default: return "read_0_9: outside range"
        }
    }
    
    func read_0_9_compound(_ i: Int) -> String {
        switch i {
        case 1:     return "أَحَدَ"
        case 2:     return "اِثْنَا" 
        case 3:     return "ثَلَاثَةَ"
        case 4:     return "أَرْبَعَةَ"
        case 5:     return "خَمْسَةَ"
        case 6:     return "سِتَّةَ"
        case 7:     return "سَبْعَةَ"
        case 8:     return "ثَمَانِيَةَ"
        case 9:     return "تِسْعَةَ"
        default: return "read_0_9_compound: outside range"
        }
    }

    func read_10s_compound(_ i: Int) -> String {
        switch i {
        case 1:     return "عَشَرَ"
        case 2:     return "عِشْرُونَ"
        case 3:     return "ثَلَاثُونَ"
        case 4:     return "أَرْبَعُونَ"
        case 5:     return "خَمْسُونَ"
        case 6:     return "سِتُّونَ"
        case 7:     return "سَبْعُونَ"
        case 8:     return "ثَمَانُونَ"
        case 9:     return "تِسْعُونَ"
        default: return "read_10s: outside range"
        }
    }

    func read_100s_compound(_ i: Int) -> String {
        switch i {
        case 1:     return "مِئَة"
        case 2:     return "مِا۟ئَتَان"
        case 3:     return "ثَلَاثُمِئَة"
        case 4:     return "أَرْبَعُمِئَة"
        case 5:     return "خُمْسُمِئَة"
        case 6:     return "سِتُّمِئَة"
        case 7:     return "سَبْعُمِئَة"
        case 8:     return "ثَمَانِيُمِئَة"
        case 9:     return "تِسْعُمِئَة"
        default: return "read_100s_compound: outside range"
        }
    }

    override func read_10_99(_ i: Int) -> String {
        var ret = ""
        if i == 10 { return "عَشَرَة" }
        if i.E1x > 0 {
            if i.E1 == 1 {
                ret += read_0_9_compound(i.E1x) + " "
            } else {
                ret += read_0_9(i.E1x) + " "
            }
            if i.E1 > 1 {
                ret += "و "
            }
            ret += read_10s_compound(i.E1)
        } else {
            ret += read_10s_compound(i.E1)
        }
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        ret += read_100s_compound(i.E2)
        if i.E2x > 0 {
            ret += " و "
            ret += read(i.E2x)
        }
        return ret
    }
}
