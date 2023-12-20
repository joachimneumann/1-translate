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
        let tens = i / 10
        let leftOver = i - tens * 10
        return read_10s(1)+readPositive(leftOver)
    }
    
    func read_21_99(_ i: Int) -> String {
        let tens = i / 10
        let leftOver = i - tens * 10
        var ret = read_10s(tens)
        if leftOver > 0 {
            ret += tensConnector_ + read_0_9(leftOver)
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
                    let hundredThousands = i / 100_000
                    let leftOver = i - hundredThousands * 100_000
                    
                    ret += read_0_9(hundredThousands)
                    ret += e5!
                    if leftOver > 0 {
                        ret += readPositive(leftOver)
                    }
                    return ret
                }
            }
            if e4 != nil {
                if i >= 10_000 {
                    let tenThousands = i / 10_000
                    let leftOver = i - tenThousands * 10_000
                    
                    ret += readPositive(tenThousands)
                    ret += e4!
                    if leftOver > 0 {
                        ret += readPositive(leftOver)
                    }
                    return ret
                }
            }
            if e3 != nil {
                let thousands = i / 1_000
                let leftOver = i - thousands * 1_000
                
                ret += thousandString(thousands)
                ret += eSpace_ + e3!
                if leftOver > 0 {
                    ret += eSpace_ + readPositive(leftOver)
                }
                return ret
            }
            return ret
        }
        
        if i < 1_000_000_000 {
            if e6 != nil {
                let millions = i / 1_000_000
                let leftOver = i - millions * 1_000_000
                
                if millions == 1 && e6_single != nil {
                    ret += e6_single!
                } else {
                    ret += readPositive(millions)
                    ret += eSpace_ + e69Space_ + e6!
                }
                if leftOver > 0 {
                    ret += eSpace_ + e69Space_ + readPositive(leftOver)
                }
                return ret
            }
        }
        
        if e9 != nil {
            let billions = i / 1_000_000_000
            let leftOver = i - billions * 1_000_000_000
            
            if billions == 1 && e9_single != nil {
                ret += e9_single!
            } else {
                ret += readPositive(billions)
                ret += eSpace_ + e69Space_ + e9!
            }
            if leftOver > 0 {
                ret += eSpace_ + e69Space_ + readPositive(leftOver)
            }
            return ret
        }
        
        return ret
    }
    
}
