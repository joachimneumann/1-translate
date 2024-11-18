//
//  Label.swift
//  ViewBuilder
//
//  Created by Joachim Neumann on 11/19/22.
//

import SwiftUI

struct Label: View {
    let model: SymbolKeyViewModel

    init(model: SymbolKeyViewModel) {
        self.model = model
    }

    var body: some View {
        model.label()
    }
    

}

