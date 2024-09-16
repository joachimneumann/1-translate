//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI
import NumberTranslator

struct ContentView: View {
    enum LanguageX: String, Identifiable, CaseIterable {
        case english = "English"
        case french = "French"
        case spanish = "Spanish"
        
        var id: String { rawValue }
    }
    
    let languages = LanguageX.allCases
    
    var body: some View {
        List(languages) { language in
            Text(language.rawValue)
        }
    }
}

extension NumberTranslator.Language: @retroactive Identifiable {
    public var id: String { rawValue }
}

struct LanguageSelector: View {
    @Bindable var viewModel: ViewModel
    let screen : Screen
    
    @State var currentLanguage: NumberTranslator.Language {
        didSet {
            viewModel.translator.currentLanguage = currentLanguage
            viewModel.updateTranslation()
        }
    }
    
    var body: some View {
        ScrollViewReader { scrollViewReaderProxy in
            List(NumberTranslator.Language.allCases) { listLanguage in
                let selected: Bool = (listLanguage == currentLanguage)
                let name = viewModel.translator.name(listLanguage)
                let x = viewModel.translator.englishName(listLanguage)
                let englishName = (x != nil ? " (\(x!))" : "")
                Button {
                    currentLanguage = listLanguage
                } label: {
                    HStack(spacing: 0) {
                        Image(viewModel.translator.flagName(listLanguage))
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 1)
                            .border(.white, width: 1)
                            .frame(height: 20)
                        Text(name)
                            .padding(.leading, 10)
                        Text(englishName)
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
                .id(viewModel.translator.currentLanguage.rawValue)
                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
            }
            .onAppear() {
                scrollViewReaderProxy.scrollTo(viewModel.translator.currentLanguage.rawValue, anchor: .top)
            }
            .listStyle(.sidebar)
        }
        .onAppear() {
            currentLanguage = viewModel.translator.currentLanguage
        }
        .padding(.top, 20)
        .navigationTitle("Select Language")
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
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), currentLanguage: .english)
    }
}
