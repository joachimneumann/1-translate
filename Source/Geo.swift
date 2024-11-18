//
//  Geo.swift
//  Calculator
//
//  Created by Joachim Neumann on 18.11.2024.
//

import SwiftUI

protocol SizeAwareModel: AnyObject {
    var size: CGSize { get set }
}

struct Geo<Model: SizeAwareModel, Content: View>: View {
    var model: Model
    let content: (Model) -> Content

    var body: some View {
        GeometryReader { geometry in
            if geometry.size != .zero {
                content(model)
                    .onAppear {
                        model.size = geometry.size
                    }
                    .onChange(of: geometry.size) { oldValue, newValue in
                        model.size = newValue
                    }
            }
        }
    }
}


protocol SizeAwareView: View {
    var model: any SizeAwareModel { get set }
}

struct Geo2<Content: SizeAwareView>: View {
    @State private var size: CGSize = .zero
    let content: (CGSize) -> Content

    var body: some View {
        GeometryReader { geometry in
            if geometry.size != .zero {
                content(geometry.size) // Pass the updated size to the content closure
                    .onAppear {
                        size = geometry.size
                    }
                    .onChange(of: geometry.size) { oldSize, newSize in
                        size = newSize
                    }
            }
        }
    }
}
