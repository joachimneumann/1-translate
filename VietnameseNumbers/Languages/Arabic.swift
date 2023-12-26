//
//  Arabic.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class Arabic: Language {
    enum Variant {
        case web
        case chatGTP
    }

    var variant: Variant
    
    init() {
        self.variant = .chatGTP
        super.init(
            name: "Català",
            negativeString: "menys",
            dotString: "coma",
            exponentString: " por diez elevat a ")
        englishName = "Arabic"
    }
    
    override func read_0_9(_ i: Int) -> String {
        if variant == .web {
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
        } else {
            switch i {
            case 0:     return "صفر"
            case 1:     return "واحد"
            case 2:     return "اثنان"
            case 3:     return "ثلاثة"
            case 4:     return "أربعة"
            case 5:     return "خمسة"
            case 6:     return "ستة"
            case 7:     return "سبعة"
            case 8:     return "ثمانية"
            case 9:     return "تسعة"
            default: return "read_0_9: outside range"
            }
        }
    }
    
    func read_arabic_0_9(_ i: Int) -> String {
        if variant == .web {
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
        } else {
            switch i {
            case 1:     return "واحد"
            case 2:     return "اثنان"
            case 3:     return "ثلاثة"
            case 4:     return "أربعة"
            case 5:     return "خمسة"
            case 6:     return "ستة"
            case 7:     return "سبعة"
            case 8:     return "ثمانية"
            case 9:     return "تسعة"
            default: return "read_0_9: outside range"
            }
        }
    }
    
    func read_arabic10s(_ i: Int) -> String {
        if variant == .web {
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
        } else {
            switch i {
            case 1:     return "عشر"
            case 2:     return "عشرون"
            case 3:     return "ثلاثون"
            case 4:     return "أربعون"
            case 5:     return "خمسون"
            case 6:     return "ستون"
            case 7:     return "سبعون"
            case 8:     return "ثمانون"
            case 9:     return "تسعون"
            default: return "read_10s: outside range"
            }
        }
    }
    
    
    func read_arabic_100s(_ i: Int) -> String {
        if variant == .web {
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
        } else {
            switch i {
            case 1:     return "مئة"
            case 2:     return "مئتان"
            case 3:     return "ثلاثمئة"
            case 4:     return "وواحد"
            case 5:     return "خُمْسُمِئَة"
            case 6:     return "سِتُّمِئَة"
            case 7:     return "سَبْعُمِئَة"
            case 8:     return "ثَمَانِيُمِئَة"
            case 9:     return "تِسْعُمِئَة"
            default: return "read_100s_compound: outside range"
            }

        }
    }
    
    func read_arabic_1000s(_ i: Int) -> String {
        switch i {
        case 1:     return "أَلف"
        case 2:     return "أَلفين"
        default:    return read(i) + " " + "أَلاف"
        }
    }
    
    func read_arabic_1000_000s(_ i: Int) -> String {
        switch i {
        case 1:     return "مليون"
        case 2:     return "مليونان"
        default:    return read(i) + " " + "ملايين"
        }
    }

    func read_arabic_1000_000_000s(_ i: Int) -> String {
        switch i {
        case 1:     return "مِلْيار"
        case 2:     return "مليارين"
        default:    return read(i) + " " + "مِلْيار"
        }
    }

    override func read_10_99(_ i: Int) -> String {
        var ret = ""
        if variant == .web {
            if i == 10 { return "عَشَرَة" }
        } else {
            if i == 10 { return "عشرة"}
            if i == 11 { return "أحد عشر"}
            if i == 12 { return "اثنا عشر"}
        }
        if i.E1x > 0 {
            if i.E1 == 1 {
                ret += read_arabic_0_9(i.E1x)
            } else {
                ret += read_0_9(i.E1x)
            }
            ret += " "
            if i.E1 > 1 {
                ret += "و"
            }
            ret += read_arabic10s(i.E1)
        } else {
            ret += read_arabic10s(i.E1)
        }
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        ret += read_arabic_100s(i.E2)
        if i.E2x > 0 {
            ret += " و"
            ret += read(i.E2x)
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        ret += read_arabic_1000s(i.E3)
        if i.E3x > 0 {
            ret += " و "
            ret += read(i.E3x)
        }
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = ""
        ret += read_arabic_1000_000s(i.E6)
        if i.E6x > 0 {
            ret += " و "
            ret += read(i.E6x)
        }
        return ret
    }

    override func read_e9_e12(_ i: Int) -> String {
        var ret = ""
        ret += read_arabic_1000_000_000s(i.E9)
        if i.E9x > 0 {
            ret += " و "
            ret += read(i.E9x)
        }
        return ret
    }

}
