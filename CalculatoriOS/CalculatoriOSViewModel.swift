//
//  CalculatoriOSViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 12.12.2024.
//

import SwiftUI

@Observable class CalculatoriOSViewModel: ViewModel {

    override init(width: CGFloat, height: CGFloat, isTranslator: Bool = false, isMac: Bool = false) {
        super.init(width: width, height: height, isTranslator: isTranslator, isMac: isMac)
        print("isPortrait \(isPortrait)")
        print("isScientific \(isScientific)")
    }
//    func newOrientation(_ new: UIDeviceOrientation) {
//        if new == .landscapeLeft || new == .landscapeRight {
//            if isPortrait {
//                isPortrait = false
//                isScientific = true
//                setWidth()
//                print("\(new) --> landscape")
//            }
//        } else if new == .portrait || new == .portraitUpsideDown {
//            if !isPortrait {
//                isPortrait = true
//                isScientific = false
//                setWidth()
//                print("\(new) --> portrait")
//            }
//        }
//    }
}
