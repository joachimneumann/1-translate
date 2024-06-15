//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import SwiftUI

class VietnameseImpl: LanguageGroup3 {
    
    @AppStorage("VietnameseThousandKey")
    var vietnameseThousand: VietnameseImpl.VietnameseThousand = .nghìn
    
    @AppStorage("VietnameseSecondLastKey")
    var secondLast: VietnameseImpl.SecondLast = .lẻ
    
    @AppStorage("VietnameseCompactKey")
    var compact: Bool = false

    enum VietnameseThousand: String, Codable, CaseIterable {
        case ngàn
        case nghìn
    }

    enum SecondLast: String, Codable, CaseIterable {
        case linh
        case lẻ
    }
    
    init() {
        super.init(
            name: "Tiếng Việt",
            zero: "không",
            negativeString: "âm",
            dotString: "phẩy",
            exponentString: " nhân mười mũ ")
        voiceLanguageCode = "vi"
        afterNegative = " "
        nameDescription = "Vietnamese"
        _11_99_connector.before = " "
        secondLast = secondLast
        postProcessing = vietnamesePostProcessing
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = _1_99(hundreds, isLargestGroup: true) + " trăm"
        if below > 0 {
            ret += " " + _1_99(below, isLargestGroup: false)
        }
        return ret
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        switch groupIndex {
        case 3:
            ret = _0_999(above) + " " + vietnameseThousand.rawValue
            if below > 0 {
                if below <= 9 {
                    ret += " không trăm " + secondLast.rawValue
                } else if below <= 99 {
                    ret += " không trăm"
                }
                ret += " " + _0_999(below)
            }
        case 6:
            ret = _0_999(above) + " triệu"
            if below > 0 {
                if below.E3 > 0 {
                    if below.E3 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E3 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    if below <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + _0_999(below)
                }
            }
        case 9:
            ret = _0_999(above) + " tỷ"
            if below > 0 {
                if below.E6 > 0 {
                    if below.E6 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E6 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else if below.E6 > 0 {
                    if below.E6 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E6 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else {
                    if below <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + _0_999(below)
                }
            }
        case 12:
            ret = _0_999(above) + " " + vietnameseThousand.rawValue + " tỷ"
            if below > 0 {
                if below.E9 > 0 {
                    if below.E9 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E9 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(9, below.E9, below: below.E9x)
                } else if below.E6 > 0 {
                    if below.E6 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E6 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else if below.E6 > 0 {
                    if below.E6 <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below.E6 <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else {
                    if below <= 9 {
                        ret += " không trăm " + secondLast.rawValue
                    } else if below <= 99 {
                        ret += " không trăm"
                    }
                    ret += " " + _0_999(below)
                }
            }
        default:
            fatalError("wrong groupindex \(groupIndex)")
        }
        return ret
    }
    
    override func _10_99(_ i: Int) -> String {
        var ret = ""
        if i <= 19 {
            if let ret = _10_19(i) {
                return ret
            }
        }
        ret = _0_9(i.E1)
        ret += (!compact || i.E1x == 0) ? " mươi" : ""
        if i.E1x > 0 {
            if i.E1x == 1 {
                ret += " mốt"
            } else if i.E1x == 5 {
                ret += " lăm"
            } else {
                ret += " " + _0_9(i.E1x)
            }
        }
        
        return ret
    }
    
    override func _1_99(_ i: Int, isLargestGroup: Bool) -> String {
        var ret = super._1_99(i, isLargestGroup: isLargestGroup)
        if i <= 9 && !isLargestGroup {
            ret = secondLast.rawValue + " " + ret
        }
        return ret
    }
    
    func vietnamesePostProcessing(_ unprocessed: String) -> String {
        var ret = unprocessed
        ret = ret.replacingOccurrences(of: "mười năm", with: "mười lăm")
        ret = ret.replacingOccurrences(of: "mươi năm", with: "mươi lăm")
        ret = ret.replacingOccurrences(of: "mươi một", with: "mươi mốt")
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "một"
        case 2:  return "hai"
        case 3:  return "ba"
        case 4:  return "bốn"
        case 5:  return "năm"
        case 6:  return "sáu"
        case 7:  return "bảy"
        case 8:  return "tám"
        case 9:  return "chín"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String? {
        var ret = "mười"
        if i.E1x > 0 {
            ret += " " + _0_9(i.E1x)
        }
        return ret
    }
    
    override func _10s(_ i: Int) -> String? {
        if i == 1 { return _10_19(10) }
        return _0_9(i) + " mươi"
    }

}
