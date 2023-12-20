//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


class TenBasedLanguage: Language {
    var e0: String? = nil
    var e2: String? = nil
    var e3: String? = nil
    var e4: String? = nil
    var e5: String? = nil
    var e6: String? = nil
    var e9: String? = nil

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
    var eSpace_: String {
        if eSpace != nil {
            eSpace!
        } else {
            ""
        }
    }
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

    private func privateRead_0_9(_ i: Int) -> String {
        if i == 1 && e0 != nil {
            return e0!
        } else {
            return read_0_9(i)
        }
    }
    
    func read_10s(_ i: Int) -> String {
        fatalError("not implmented")
    }
    
    override func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("TenBasedLanguage readPositive out of range") }
        if i < 10 {
            return privateRead_0_9(i)
        }
        
        var ret = ""
        
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
            let p = i.e0
            ret += read_10s(p._x_)
            if p.__x > 0 {
                ret += tensConnector_ + read_0_9(p.__x)
            }
            return ret
        }
        
        if i < 1_000 {
            if e2 != nil {
                let p = i.e0
                ret += privateRead_0_9(p.x__)
                ret += eSpace_ + e2!
                if p._xx > 0 {
                    ret += eSpace_ + readPositive(p._xx)
                }
                return ret
            }
        }

        if i < 1_000_000 {
            if e5 != nil {
                if i >= 100_000 {
                    let hundredThousands = i / 100_000
                    let leftOver = i - hundredThousands * 100_000
                    
                    if hundredThousands == 1 {
                        ret += e0!
                    } else {
                        ret += read_0_9(hundredThousands)
                    }
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
                    
                    ret += privateRead_0_9(tenThousands)
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

                ret += readPositive(thousands)
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

                ret += readPositive(millions)
                ret += eSpace_ + e6!
                if leftOver > 0 {
                    ret += eSpace_ + readPositive(leftOver)
                }
                return ret
            }
        }

        if e9 != nil {
            let billions = i / 1_000_000_000
            let leftOver = i - billions * 1_000_000_000

            ret += readPositive(billions)
            ret += eSpace_ + e9!
            if leftOver > 0 {
                ret += eSpace_ + readPositive(leftOver)
            }
            return ret
        }

        return ret
    }

}
