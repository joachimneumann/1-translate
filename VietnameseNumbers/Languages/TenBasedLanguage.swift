//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


class TenBasedLanguage: Language {
    var e3: String? = nil
    var e4: String? = nil
    var e5: String? = nil
    var e6: String? = nil
    var e9: String? = nil
    var e6_single: String? = nil
    var e9_single: String? = nil
    
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
    
    func read_11_19(_ i: Int) -> String {
        return read_10s(1)+readPositive(i._10x)
    }
    
    func read_21_99(_ i: Int) -> String {
        var ret = read_10s(i._10)
        if i._10x > 0 {
            ret += tensConnector_ + read_0_9(i._10x)
        }
        return ret
    }

    func read_100_999(_ i: Int) -> String {
        fatalError("not implmented")
    }

    func thousandString(_ i: Int) -> String {
        readPositive(i)
    }

    override func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("TenBasedLanguage readPositive out of range") }
        
        if i < 10    { return read_0_9(i)     }
        if i == 10   { return read_10s(1)     }
        if i <= 19   { return read_11_19(i)   }
        if i <= 99   { return read_21_99(i)   }
        if i < 1_000 { return read_100_999(i) }
        
        var ret = ""
        if i < 1_000_000 {
            if e5 != nil {
                if i >= 100_000 {
                    ret += read_0_9(i._100_000)
                    ret += e5!
                    if i._100_000x > 0 {
                        ret += readPositive(i._100_000x)
                    }
                    return ret
                }
            }
            if e4 != nil {
                if i >= 10_000 {
                    ret += readPositive(i._10_000)
                    ret += e4!
                    if i._10_000x > 0 {
                        ret += readPositive(i._10_000x)
                    }
                    return ret
                }
            }
            if e3 != nil {
                ret += thousandString(i._1_000)
                ret += eSpace_ + e3!
                if i._1_000x > 0 {
                    ret += eSpace_ + readPositive(i._1_000x)
                }
                return ret
            }
            return ret
        }
        
        if i < 1_000_000_000 {
            if e6 != nil {
                if i._E6 == 1 && e6_single != nil {
                    ret += e6_single!
                } else {
                    ret += readPositive(i._E6)
                    ret += eSpace_ + e69Space_ + e6!
                }
                if i._E6x > 0 {
                    ret += eSpace_ + e69Space_ + readPositive(i._E6x)
                }
                return ret
            }
        }
        
        if e9 != nil {
            if i._E9 == 1 && e9_single != nil {
                ret += e9_single!
            } else {
                ret += readPositive(i._E9)
                ret += eSpace_ + e69Space_ + e9!
            }
            if i._E9x > 0 {
                ret += eSpace_ + e69Space_ + readPositive(i._E9x)
            }
            return ret
        }
        
        return ret
    }
    
}
