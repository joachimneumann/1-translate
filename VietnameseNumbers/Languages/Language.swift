//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


class Language: LanguageString {
    var e2: String? = nil
    var e3: String? = nil
    var e4: String? = nil
    var e5: String? = nil
    var e6: String? = nil
    var e9: String? = nil
    var e12: String? = nil
    var e1_one: String? = nil
    var e2_one: String? = nil
    var e3_one: String? = nil
    var e6_one: String? = nil
    var e9_one: String? = nil
    var e12_one: String? = nil
    var e2_cleanPlural: String? = nil
    var beforeHundred: String? = nil
    var afterHundred: String? = nil
    var allowNegativeNumbers = true


    var eSpace: String? = nil
    var e3Space: String? = nil
    var e69Space: String? = nil
    private var eSpace_: String { eSpace == nil ? "" : eSpace! }
    private var e3Space_: String { e3Space == nil ? "" : e3Space! }
    private var e69Space_: String { e69Space == nil ? "" : e69Space! }

    var tensConnector: String? = nil
    var tensConnector_: String {
        if tensConnector != nil {
            tensConnector!
        } else {
            ""
        }
    }
    
    func read_0_9(_ i: Int) -> String {
        fatalError("not implmented")
    }
    
    func read_10s(_ i: Int) -> String {
        fatalError("not implmented")
    }
    
    func read_10_99(_ i: Int) -> String {
        var ret = read_10s(i.E1)
        if i.E1 == 1 && e1_one != nil {
            ret = e1_one!
        } else {
            if i.E1x > 0 {
                ret += tensConnector_ + read_0_9(i.E1x)
            }
        }
        return ret
    }
    
    func read_e2_e3(_ i: Int) -> String {
        var ret = read(i.E2)
        if i.E2 == 1 && e2_one != nil {
            ret = e2_one!
        } else {
            if let e2 = e2 {
                ret = read(i.E2)
                ret += eSpace_
                if i.E2 > 1 && i.E2x == 0 && e2_cleanPlural != nil {
                    ret += e2_cleanPlural!
                } else {
                    if let beforeHundred = beforeHundred {
                        ret += beforeHundred
                    }
                    ret += e2
                }
            }
        }
        if i.E2x > 0 {
            if let afterHundred = afterHundred {
                ret += afterHundred
            }
            ret += eSpace_ + read(i.E2x)
        }
        return ret
    }
    
    func read_e3_e6(_ i: Int) -> String {
        var ret = read(i.E3)
        if i.E3 == 1 && e3_one != nil {
            ret = e3_one!
        } else {
            if let e3 = e3 {
                ret = read(i.E3)
                ret += eSpace_ + e3Space_ + e3
            }
        }
        if i.E3x > 0 {
            ret += eSpace_ + e3Space_ + read(i.E3x)
        }
        return ret
    }

    func read_e6_e9(_ i: Int) -> String {
        var ret = read(i.E6)
        if i.E6 == 1 && e6_one != nil {
            ret = e6_one!
        } else {
            if let e6 = e6 {
                ret = read(i.E6)
                ret += eSpace_ + e69Space_ + e6
            }
        }
        if i.E6x > 0 {
            ret += eSpace_ + e69Space_ + read(i.E6x)
        }
        return ret
    }

    func read_e9_e12(_ i: Int) -> String {
        var ret = read(i.E9)
        if i.E9 == 1 && e9_one != nil {
            ret = e9_one!
        } else {
            if let e9 = e9 {
                ret = read(i.E9)
                ret += eSpace_ + e69Space_ + e9
            }
        }
        if i.E9x > 0 {
            ret += eSpace_ + e69Space_ + read(i.E9x)
        }
        return ret
    }

    override func read(_ i: Int) -> String {
        if i < 0 {
            guard allowNegativeNumbers else { return "negative: unknown" }
            return negativeString + afterNegative + read(-i)
        }
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("too large") }
        
        if i < 10    { return read_0_9(i) }
        if i <= 99   { return read_10_99(i)   }
        if i < 1_000 { return read_e2_e3(i) }
        
        var ret = ""
        if i < 1_000_000 {
            if e5 != nil {
                if i >= 100_000 {
                    ret += read_0_9(i.E5)
                    ret += e5!
                    if i.E5x > 0 {
                        ret += read(i.E5x)
                    }
                    return ret
                }
            }
            if e4 != nil {
                if i >= 10_000 {
                    ret += read(i.E4)
                    ret += e4!
                    if i.E4x > 0 {
                        ret += read(i.E4x)
                    }
                    return ret
                }
            }
            if e3 != nil {
                return read_e3_e6(i)
            }
            return ret
        }
        
        if i < 1_000_000_000 {
            return read_e6_e9(i)
        }
        
        if i < 1_000_000_000_000 {
            return read_e9_e12(i)
        }
        if e12 != nil {
            if i.E12 == 1 && e12_one != nil {
                ret += e12_one!
            } else {
                ret += read(i.E12)
                ret += eSpace_ + e69Space_ + e12!
            }
            if i.E12x > 0 {
                ret += eSpace_ + e69Space_ + read(i.E12x)
            }
            return ret
        }
        
        return ret
    }
    
}
