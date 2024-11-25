//
//  FlagKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 20.11.2024.

import NumberTranslator
import SwiftUI

@Observable class FlagKey: Key {
    let persistent: TranslatePersistent
    private var languageEnum: NumberTranslator.LanguageEnum
    var image: Image
    var borderWidth: CGFloat = 0.0
    var padding: CGFloat = 0.0
    let borderColor: Color = Color(AppleColor.darkGray)
    var isSquare: Bool = false
    private var toggle: (() -> Void)?
    private var setLanguage: ((NumberTranslator.LanguageEnum) -> Void)?
    
    init(persistent: TranslatePersistent,
         languageEnum optionalLanguageEnum: NumberTranslator.LanguageEnum? = nil,
         toggle: (() -> ())? = nil,
         setLanguage: ((NumberTranslator.LanguageEnum) -> ())? = nil) {
        //print("FlagKey init() \(optionalLanguageEnum?.rawValue ?? "nil")")
        self.toggle = toggle
        self.setLanguage = setLanguage
        self.persistent = persistent
        self.languageEnum = optionalLanguageEnum ?? persistent.currentLanguageEnum
        self.image = Image("English")
        super.init()
//        if optionalLanguageEnum == nil {
//            self.newLanguageEnum(persistent.currentLanguageEnum)
//        } else {
//            self.newLanguageEnum(optionalLanguageEnum!)
//        }
//        if isSquare && AppleImage(named: persistent.flagName(languageEnum) + "Sqr") != nil {
//            image = Image(persistent.flagName(languageEnum) + "Sqr")
//        } else if AppleImage(named: persistent.flagName(languageEnum)) != nil{
//            image = Image(persistent.flagName(languageEnum))
//        } else {
//            image = Image("English")
//        }

    }
    
    func pressed() {
        if let toggle = toggle {
            toggle()
        } else {
            if let setLanguage = setLanguage {
                setLanguage(languageEnum)
            }
        }
    }
    
    func newLanguageEnum(_ languageEnum: NumberTranslator.LanguageEnum) {
        self.languageEnum = languageEnum
        if isSquare && AppleImage(named: persistent.flagName(languageEnum) + "Sqr") != nil {
            //print("FlagViewModel newLanguageEnum \(languageEnum.rawValue) SQR")
            image = Image(persistent.flagName(languageEnum) + "Sqr")
        } else if AppleImage(named: persistent.flagName(languageEnum)) != nil {
            //print("FlagViewModel newLanguageEnum \(languageEnum.rawValue) NOT SQR")
            image = Image(persistent.flagName(languageEnum))
        } else {
            image = Image("English")
        }
    }
    
    func newSize(_ rect: CGSize) {
        if rect.width < rect.height * 1.1 && AppleImage(named: persistent.flagName(languageEnum) + "Sqr") != nil {
            isSquare = true
        } else {
            isSquare = false
        }
        newLanguageEnum(languageEnum)
        borderWidth = ceil(min(rect.width, rect.height) * 0.05)
        padding = 0.5 * borderWidth
    }
    
    override func view() -> AnyView {
        AnyView(GeometryReader { geometry in
            FlagView(model: self)
                .onChange(of: self.image) {
                    //print("onChange of image geometry.size \(geometry.size)")
                    /// when the image is changed from non-square to
                    /// square the property isSquare needs to be updated
                    self.newSize(geometry.size)
                }
            .onAppear() {
                //print("onAppear geometry.size \(geometry.size)")
                self.newSize(geometry.size)
            }
        }
    )
    }
}

#Preview {
    let persistent = TranslatePersistent()
    let _ = persistent.currentLanguageEnum = .esperanto
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            FlagKey(persistent: persistent, languageEnum: .vietnamese).view()
            FlagKey(persistent: persistent, languageEnum: .english).view()
            FlagKey(persistent: persistent, languageEnum: .ukrainian).view()
            FlagKey(persistent: persistent).view()
        }
        .frame(height: 150)
    }
}
