//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct SelectLanguage: View {
    @ObservedObject var viewModel: ViewModel
    let language: Language

    struct LanguageText: View {
        let language: Language
        let selected: Bool
        var body: some View {
            HStack(spacing: 0.0) {
                Text(language.name)
                    .foregroundColor(.white)
                Spacer(minLength: 0)
                if language.englishName != nil {
                    Text(" "+language.englishName!)
                        .italic()
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.01)
                }
            }
            .frame(height: 25)
            .foregroundColor(Color.white)
        }
    }
    
    var body: some View {
        let imageBorderWidth: CGFloat = 3
        let _1_selected = (language.name == viewModel.firstLanguage.name)
        let _2_selected = viewModel.secondLanguageAllowed && (language.name == viewModel.secondLanguage.name)
        HStack {
            Button(action: {
                viewModel.newFirstLanguage(language)
            }) {
                HStack {
                    Image(language.flagName)
                        .resizable()
                        .scaledToFit()
                        .padding(imageBorderWidth)
                        .border(.white, width: viewModel.firstLanguage.name == language.name ? imageBorderWidth : 0)
                        .frame(height: 30)
                        .padding(.trailing, 10)
                }
            }
            if !viewModel.secondLanguageAllowed {
                LanguageText(language: language, selected: _1_selected || _2_selected)
                Spacer()
            }
            if viewModel.secondLanguageAllowed {
                Button(action: {
                    viewModel.newSecondLanguage(language)
                }) {
                    HStack {
                        Image(language.flagName)
                            .resizable()
                            .scaledToFit()
                            .padding(imageBorderWidth)
                            .border(.white, width: viewModel.secondLanguage.name == language.name ? imageBorderWidth : 0)
                            .frame(height: 30)
                            .padding(.trailing, 10)
                    }
                }
                LanguageText(language: language, selected: _1_selected || _2_selected)
                Spacer()
            }
        }
        .padding(.top, 15)
    }
}


struct LanguageSelector: View {
    
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    @ObservedObject var viewModel: ViewModel
    let screen : Screen
    
    var body: some View {
        VStack {
            HStack {
                Toggle("", isOn: $viewModel.secondLanguageAllowed)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 15)
                Text("Show 2 languages")
                    .foregroundColor(Color.white)
                Spacer()
                NavigationLink {
                    Settings(viewModel: viewModel, font: Font(screen.infoUiFont))
                } label: {
                    Image(systemName: "switch.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(Font.title.weight(.thin))
                        .frame(height: screen.plusIconSize * 0.8)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(TransparentButtonStyle())
                .opacity(0.9)
                .padding(.trailing, 15)
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            .padding(.leading, 10)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    ForEach(0 ..< viewModel.languages.list.count, id: \.self) { index in
                        let language = viewModel.languages.list[index]
                        let _1_selected = (language.name == viewModel.firstLanguage.name)
                        let _2_selected = viewModel.secondLanguageAllowed && (language.name == viewModel.secondLanguage.name)
                        SelectLanguage(viewModel: viewModel, language: language)
                    }
                }
                .padding(.trailing, 5)
            }
            .padding(.leading, 10)
        }
    }
}

