//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct SelectLanguage: View {
    
    struct LanguageText: View {
        let language: Language
        let bold: Bool
        var body: some View {
            HStack(spacing: 0.0) {
                Text(language.name)
                    .bold(bold)
                Spacer(minLength: 0)
                if language.englishName != nil {
                    Text(" "+language.englishName!)
                        .italic()
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.01)
                }
            }
            .frame(height: 25)
            .foregroundColor(Color.white)
        }
    }
    
    @ObservedObject var viewModel: ViewModel
    let language: Language
    var body: some View {
        let _1_selected = (language.name == viewModel.firstLanguage.name)
        let _2_selected = (language.name == viewModel.secondLanguage.name)
        HStack {
            Button(action: {
                viewModel.firstLanguage = language
                viewModel.firstLanguageName = language.name
            }) {
                HStack {
                    Image(language.name)
                        .resizable()
                        .scaledToFit()
                        .padding(2)
                        .border(.white, width: viewModel.firstLanguage.name == language.name ? 2 : 0)
                        .frame(height: 30)
                        .padding(.trailing, 10)
                        .opacity(_1_selected ? 1.0 : 0.5)
                    if !viewModel.secondLanguageAllowed {
                        LanguageText(language: language, bold: _1_selected || (viewModel.secondLanguageAllowed && _2_selected))
                        Spacer()
                    }
                }
            }
            if viewModel.secondLanguageAllowed {
                Button(action: {
                    viewModel.secondLanguage = language
                    viewModel.secondLanguageName = language.name
                }) {
                    HStack {
                        Image(language.name)
                            .resizable()
                            .scaledToFit()
                            .padding(2)
                            .border(.white, width: viewModel.secondLanguage.name == language.name ? 2 : 0)
                            .frame(height: 30)
                            .opacity(_2_selected ? 1.0 : 0.5)
                            .padding(.trailing, 10)
                        LanguageText(language: language, bold: _1_selected || (viewModel.secondLanguageAllowed && _2_selected))
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
                ForEach(0 ..< viewModel.languages.count, id: \.self) { index in
                    SelectLanguage(viewModel: viewModel, language: viewModel.languages[index])
                }
            }
        }
}

#Preview {
    LanguageSelector(viewModel: ViewModel())
        .background(Color.black)
}
