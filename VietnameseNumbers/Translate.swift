//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

import Foundation

//func translate(display: Display) -> String {
//    return "không";
//}

private func translate_0_10(intValue: Int, mốt: Bool = false, lăm: Bool = false, mươi: Bool = false) -> String {
    switch intValue {
    case 0:     return "không"
    case 1:     if mốt { return "mốt" } else { return "môt" }
    case 2:     return "hai"
    case 3:     return "ba"
    case 4:     return "bốn"
    case 5:     if lăm { return "lăm" } else { return "năm" }
    case 6:     return "sáu"
    case 7:     return "bảy"
    case 8:     return "tám"
    case 9:     return "chín"
    case 10:    if mươi { return "mươi" } else { return "mười" }
    default: return "??"
    }
}

private func translate(intValue: Int) -> String {
    if intValue < 0 { return "negative" }
    if intValue <= 10 {
        return translate_0_10(intValue: intValue)
    }
    if intValue < 20 {
        return translate_0_10(intValue: 10) + " " +
        translate_0_10(intValue: intValue - 10, mốt: false, lăm: true)
    }
    if intValue <= 99 {
        let lastDigit = intValue % 10
        let tener = (intValue - lastDigit) / 10
        return translate_0_10(intValue: tener) + " mươi" +
        (lastDigit != 0 ? " " + translate_0_10(intValue: lastDigit, mốt: true, lăm: true) : "")
    }
    return "xx"
}

func translate(_ string: String) -> String {
    let intValue = Int(string)
    if intValue != nil {
        return translate(intValue: intValue!)
    }
    return "???";
}

