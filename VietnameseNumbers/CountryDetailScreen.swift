//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct languageSelector: View {
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
                    Image(translator.imageName)
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
                        Image(translator.imageName)
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
        .padding(.bottom, 15)
    }
}
struct CountryDetailScreen: View {
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
                .padding(.top, 20)
                .padding(.bottom, 20)
                languageSelector(viewModel: viewModel, translator: viewModel.translateEnglish)
                languageSelector(viewModel: viewModel, translator: viewModel.translateGerman)
                languageSelector(viewModel: viewModel, translator: viewModel.translateVietnamese)
                languageSelector(viewModel: viewModel, translator: viewModel.translateSpanish)
            }
            .padding(20)
        }
}

#Preview {
    CountryDetailScreen(viewModel: ViewModel())
        .background(Color.black)
}
