//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct LanguageSelector: View {
    @Bindable var viewModel: ViewModel
    let screen : Screen
    let isFirstLanguage: Bool
        
    @State var currentLanguage: Language? {
        didSet {
            if let currentLanguage = currentLanguage {
                if isFirstLanguage {
                    viewModel.languages.first = currentLanguage
                    viewModel.languages.firstName = currentLanguage.translator.name
                } else {
                    viewModel.languages.second = currentLanguage
                    viewModel.languages.secondName = currentLanguage.translator.name
                }
            }
            viewModel.updateTranslation()
        }
    }
    
    var body: some View {
         ScrollViewReader { scrollViewReaderProxy in
            List(viewModel.languages.list)  { language in
                let selected: Bool = (language.translator.name == currentLanguage?.translator.name)
                Button {
                    currentLanguage = language
                } label: {
                    HStack(spacing: 0) {
                        Image(language.flagName)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 1)
                            .border(.white, width: 1)
                            .frame(height: 20)
                        Text(language.translator.name)
                            .padding(.leading, 10)
                        if language.translator.englishName != nil {
                            Text(" ("+language.translator.englishName!+")")
                        }
                        Spacer()
                        if selected {
                            Image(systemName: "checkmark")
                                .foregroundColor(.yellow)
                                .bold()
                                .frame(width: 20)
                        } else {
                            Rectangle()
                                .background()
                                .frame(width: 20, height: 0)
                        }
                    }
                }
                .id(language.translator.name)
                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
            }
            .onAppear() {
                scrollViewReaderProxy.scrollTo(isFirstLanguage ? viewModel.languages.first.translator.name : viewModel.languages.second.translator.name, anchor: .top)
            }
            .listStyle(.sidebar)
        }
        .onAppear() {
            if isFirstLanguage {
                currentLanguage = viewModel.languages.first
            } else {
                currentLanguage = viewModel.languages.second
            }
        }
        .padding(.top, 20)
        .navigationTitle(isFirstLanguage ? "First Language" : "Second Language")
        .toolbar {
            NavigationLink {
                Settings(viewModel: viewModel, font: Font(screen.infoUiFont))
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .bold()
                    .frame(height: 30)
                    .foregroundColor(Color.white)
                    .padding(.top, 14)
                    .padding(.trailing, 5)
            }
        }
    }
    
}


#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), isFirstLanguage: true)
    }
}
