//
//  TranslatedDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct TranslatedDisplay: View {
    let translatedString: String
        
    var body: some View {
        //let _ = print(display.data.left)
        VStack(spacing: 0.0) {
            HStack(alignment: .bottom, spacing: 0.0) {
                Text(translatedString)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0.0)
            }
            Spacer(minLength: 0.0)
        }
    }
}
