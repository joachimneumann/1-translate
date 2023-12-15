//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct SelectLanguage: View {
    @ObservedObject var viewModel: ViewModel
    let translator: BasicTranslator
    var body: some View {
        let _1_selected = viewModel.firstTranslator == translator
        let _2_selected = viewModel.secondTranslator == translator
        HStack {
            Button(action: {
                viewModel.firstLanguage = translator.language
            }) {
                HStack {
                    Image(translator.language)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(viewModel.firstLanguage == translator.language ? .white : .black)
                        .frame(height: 25)
                        .padding(.trailing, 10)
                        .opacity(_1_selected ? 1.0 : 0.5)
                    if !viewModel.secondLanguageAllowed {
                        Text(translator.language)
                            .bold(_1_selected || (viewModel.secondLanguageAllowed && _2_selected))
                            .frame(height: 25)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
            }
            if viewModel.secondLanguageAllowed {
                Button(action: {
                    viewModel.secondLanguage = translator.language
                }) {
                    HStack {
                        Image(translator.language)
                            .resizable()
                            .scaledToFit()
                            .padding(1)
                            .border(viewModel.secondLanguage == translator.language ? .white : .black)
                            .frame(height: 25)
                            .opacity(_2_selected ? 1.0 : 0.5)
                            .padding(.trailing, 10)
                        Text(translator.language)
                            .bold(_1_selected || (viewModel.secondLanguageAllowed && _2_selected))
                            .frame(height: 25)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
            }
        }
        .padding(.top, 15)
    }
}
struct LanguageSelector: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Toggle("", isOn: $viewModel.secondLanguageAllowed)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .padding(.trailing, 15)
                    Text("Second Language")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.top, 0)
                .padding(.bottom, 10)
                ForEach(viewModel.translators, id:\.self) { t in
                    SelectLanguage(viewModel: viewModel, translator: t)
                }
            }
        }
}

#Preview {
    LanguageSelector(viewModel: ViewModel())
        .background(Color.black)
}
