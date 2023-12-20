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
        if i <= 99 {
            let p = i.e0
            ret += read_10s(p._x_)
            if p.__x > 0 {
                ret += read_0_9(p.__x)
            }
            return ret
        }
        
        if e2 != nil {
            if i < 1_000 {
                let p = i.e0
                if p.x__ == 1 {
                    ret += e0!
                } else {
                    ret += read_0_9(p.x__)
                }
                ret += e2!
                if p._xx > 0 {
                    ret += readPositive(p._xx)
                }
                return ret
            }
        }

        if e3 != nil {
            if i < 10_000 {
                let p = i.e3!
                if p.__x == 1 {
                    ret += e0!
                } else {
                    ret += read_0_9(p.__x)
                }
                ret += e3!
                if i.e0.value > 0 {
                    ret += readPositive(i.e0.value)
                }
                return ret
            }
        }

        if e4 != nil {
            if i < 100_000 {
                let tenThousands = i / 10_000
                let leftOver = i - tenThousands * 10_000
                
                if tenThousands == 1 {
                    ret += e0!
                } else {
                    ret += read_0_9(tenThousands)
                }
                ret += e4!
                if leftOver > 0 {
                    ret += readPositive(leftOver)
                }
                return ret
            }
        }

        if e5 != nil {
            if i < 1_000_000 {
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

        if e6 != nil {
            if i < 1_000_000_000 {
                let _e6 = i / 1_000_000
                let leftOver = i - _e6 * 1_000_000
                
                if _e6 == 1 {
                    ret += e0!
                } else {
                    ret += readPositive(_e6)
                }
                ret += e6!
                if leftOver > 0 {
                    ret += readPositive(leftOver)
                }
                return ret
            }
        }

        if e9 != nil {
            let _e9 = i / 1_000_000_000
            let leftOver = i - _e9 * 1_000_000_000
            
            if _e9 == 1 {
                ret += e0!
            } else {
                ret += readPositive(_e9)
            }
            ret += e9!
            if leftOver > 0 {
                ret += readPositive(leftOver)
            }
            return ret
        }

        return ret
    }

}

/*
 var ret = ""
 let e0 = i.e0
 
 guard let e3 = i.e3  else {
     return readPeriod(e0)
 }
 ret = readPeriod(e0)

 guard let e6 = i.e6  else {
     return readPeriod(e3) + ret
 }
 ret = readPeriod(e3) + ret

 guard let e9 = i.e9  else {
     return readPeriod(e6) + ret
 }
 ret = readPeriod(e6) + ret

 guard let e12 = i.e12  else {
     return readPeriod(e9) + ret
 }
 ret = readPeriod(e9) + ret
 ret = readPeriod(e12) + ret

 */
