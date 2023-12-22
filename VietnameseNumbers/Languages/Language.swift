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
    var e6_single: String? = nil
    var e9_single: String? = nil
    var e12_single: String? = nil

    var eSpace: String? = nil
    var eSpace_: String { eSpace == nil ? "" : eSpace! }
    var e69Space: String? = nil
    var e69Space_: String { e69Space == nil ? "" : e69Space! }
    
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
    
    func read_0_99(_ i: Int) -> String {
        if i < 10    { return read_0_9(i)     }
        var ret = read_10s(i.E1)
        if i.E1x > 0 {
            ret += tensConnector_ + read_0_9(i.E1x)
        }
        return ret
    }

    func read_100_999(_ i: Int) -> String {
        if let e2 = e2 {
            var ret = read(i.E2) + eSpace_ + e2
            if i.E2x > 0 {
                ret += eSpace_ + read(i.E2x)
            }
            return ret
        } else {
            fatalError("not implmented")
        }
    }
    
    func read_e3_e6(_ i: Int) -> String {
        if let e3 = e3 {
            var ret = read(i.E3) + eSpace_ + e3
            if i.E3x > 0 {
                ret += eSpace_ + read(i.E3x)
            }
            return ret
        } else {
            fatalError("not implmented")
        }
    }

    
    func read_e6_e9(_ i: Int) -> String {
        if let e6 = e6 {
            var ret = ""
            if i.E6 == 1 && e6_single != nil {
                ret += e6_single!
            } else {
                ret += read(i.E6)
                ret += eSpace_ + e69Space_ + e6
            }
            if i.E6x > 0 {
                ret += eSpace_ + e69Space_ + read(i.E6x)
            }
            return ret
        } else {
            return read(i.E6) + read(i.E6x)
        }
    }

    func read_e9_e12(_ i: Int) -> String {
        if let e9 = e9 {
            var ret = ""
            if i.E9 == 1 && e9_single != nil {
                ret += e9_single!
            } else {
                ret += read(i.E9)
                ret += eSpace_ + e69Space_ + e9
            }
            if i.E9x > 0 {
                ret += eSpace_ + e69Space_ + read(i.E9x)
            }
            return ret
        } else {
            return read(i.E9) + read(i.E9x)
        }
    }


    override func read(_ i: Int) -> String {
        if i < 0 {
            return negativeString + afterNegative + read(-i)
        }
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("too large") }
        
        if i <= 99   { return read_0_99(i)   }
        if i < 1_000 { return read_100_999(i) }
        
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
            if i.E12 == 1 && e12_single != nil {
                ret += e12_single!
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
