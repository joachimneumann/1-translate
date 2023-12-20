//
//  German.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class German: TenBasedLanguage {
    init() {
        super.init(
            name: "Deutsch",
            negativeString: "minus",
            dotString: "Komma",
            exponentString: " mal zehn hoch ",
            groupSeparator: "",
            decimalSeparator: ".")

        e3 = "tausend"
        e6 = "Millionen"
        e6_single = "eine Million"
        e9 = "Milliarden"
        e9_single = "eine Milliarde"
        afterNegative = " "
        beforeAndAfterDotString = " "
        tensConnector = "und"
        eSpace = ""
        e69Space = " "
    }
    
    override func read_11_19(_ i: Int) -> String {
        if i == 11 { return "elf" }
        if i == 12 { return "zwölf" }
        if i == 13 { return "dreizehn" }
        if i == 14 { return "vierzehn" }
        if i == 15 { return "fünfzehn" }
        if i == 16 { return "sechzehn" }
        if i == 17 { return "siebzehn" }
        if i == 18 { return "achtzehn" }
        if i == 19 { return "neunzehn" }
        return ""
    }
    
    override func read_21_99(_ i: Int) -> String {
        let tens = i / 10
        let leftOver = i - tens * 10

        var ret = ""
        if leftOver > 0 {
            var temp = read_0_9(leftOver)
            if temp.hasSuffix("eins") {
                temp.removeLast()
            }
            ret += temp + tensConnector_
        }
        ret += read_10s(tens)
        return ret
    }
    
    override func read_100_999(_ i: Int) -> String {
        let hundreds = i / 100
        let leftOver = i - hundreds * 100
        
        var ret = readPositive(hundreds)
        if ret.hasSuffix("eins") {
            ret.removeLast()
        }
        ret += "hundert"
        if leftOver > 0 {
            ret += eSpace_ + readPositive(leftOver)
        }
        return ret
    }
    
    override func thousandString(_ i: Int) -> String {
        var ret = super.thousandString(i)
        if ret.hasSuffix("eins") {
            ret.removeLast()
        }
        return ret
    }


    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "null"
        case 1:     return "eins"
        case 2:     return "zwei"
        case 3:     return "drei"
        case 4:     return "vier"
        case 5:     return "fünf"
        case 6:     return "sechs"
        case 7:     return "sieben"
        case 8:     return "acht"
        case 9:     return "neun"
        default: return " translate_0_10: outside range "
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "zehn"
        case 2:     return "zwanzig"
        case 3:     return "dreißig"
        case 4:     return "vierzig"
        case 5:     return "fünfzig"
        case 6:     return "sechzig"
        case 7:     return "siebzig"
        case 8:     return "achtzig"
        case 9:     return "neunzig"
        default: return " 10s outside range "
        }
    }
}
