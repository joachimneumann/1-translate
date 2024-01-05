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
    
    public struct LanguageList : View {
        var selectedIndex: Binding<Int?>
        let list: [Language]
        let color: Color
        
        public var body: some View {
            ScrollViewReader { scrollViewReaderProxy in
                List(0..<list.count, id: \.self, selection: selectedIndex) {
                    languageIndex in
                    let language = list[languageIndex]
                    let selected = languageIndex == selectedIndex.wrappedValue
                    HStack(spacing: 0) {
                        Image(language.flagName)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 1)
                            .border(.white, width: 1)
                            .frame(height: 20)
//                            .padding(.trailing, 10)
                        Text(language.name)
                            .padding(.leading, 10)
                        if language.nameDescription != nil {
                            Text(" ("+language.nameDescription!+")")
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
                    .id(languageIndex)
                    .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
                }
                .listStyle(.sidebar)
                .background(color)
                .onAppear() {
                    if let position = selectedIndex.wrappedValue {
                        scrollViewReaderProxy.scrollTo(position, anchor: .top)
                    }
                }
            }
        }
        
    }
    
    var body: some View {
        LanguageList(
            selectedIndex: isFirstLanguage ? $viewModel.languages.indexOfFirstLanguage : $viewModel.languages.indexOfSecondLanguage,
            list: viewModel.languages.list,
            color: .black)
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
        .onDisappear {
            viewModel.refreshDisplay(screen: screen)
        }
    }
    
}



#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), isFirstLanguage: true)
    }
}
