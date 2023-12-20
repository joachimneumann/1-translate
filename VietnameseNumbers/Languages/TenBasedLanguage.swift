//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


class TenBasedLanguage: Language {
    var e2: String? = nil
    var e3: String? = nil
    var e4: String? = nil
    var e5: String? = nil
    var e6: String? = nil
    var e9: String? = nil
    var e6_single: String? = nil
    var e9_single: String? = nil
    
    var _11: String? = nil
    var _12: String? = nil
    var _13: String? = nil
    var _14: String? = nil
    var _15: String? = nil
    var _16: String? = nil
    var _17: String? = nil
    var _18: String? = nil
    var _19: String? = nil

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
    
    func read_21_99(_ i: Int) -> String {
        let tens = i / 10
        let leftOver = i - tens * 10
        var ret = read_10s(tens)
        if leftOver > 0 {
            ret += tensConnector_ + read_0_9(leftOver)
        }
        return ret
    }

    func hundredsString(_ i: Int) -> String {
        readPositive(i)
    }

    func thousandString(_ i: Int) -> String {
        readPositive(i)
    }

    override func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("TenBasedLanguage readPositive out of range") }
        
        if i < 10 {
            return read_0_9(i)
        }
        
        if i == 11 && _11 != nil { return _11! }
        if i == 12 && _12 != nil { return _12! }
        if i == 13 && _13 != nil { return _13! }
        if i == 14 && _14 != nil { return _14! }
        if i == 15 && _15 != nil { return _15! }
        if i == 16 && _16 != nil { return _16! }
        if i == 17 && _17 != nil { return _17! }
        if i == 18 && _18 != nil { return _18! }
        if i == 19 && _19 != nil { return _19! }

        if i <= 99 {
            return read_21_99(i)
        }
        
        var ret = ""
        if i < 1_000 {
            if e2 != nil {
                let hundreds = i / 100
                let leftOver = i - hundreds * 100
                ret += hundredsString(hundreds)
                ret += eSpace_ + e2!
                if leftOver > 0 {
                    ret += eSpace_ + readPositive(leftOver)
                }
                return ret
            }
        }
        
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
