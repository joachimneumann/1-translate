//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct LanguageSelector: View {
    @ObservedObject var viewModel: ViewModel
    let screen : Screen
    let isFirstLanguage: Bool
    
    public struct LanguageList : View {
        var selectedIndex: Binding<Int?>
        let list: [Language]
        let color: Color
        
        public var body: some View {
            ScrollViewReader { scrollViewReaderProxy in
                List(0..<list.count, id: \.self, selection: selectedIndex) { languageIndex in
                    let language = list[languageIndex]
                    HStack {
                        Image(language.flagName)
                            .resizable()
                            .scaledToFit()
                            .padding(2)
                            .border(.white, width: 2)
                            .frame(height: 30)
                            .padding(.trailing, 10)
                        Text(language.name)
                        Spacer()
                        if language.nameDescription != nil {
                            Text(language.nameDescription!)
                                .italic()
                        }
                    }
                    .id(languageIndex)
                    .listRowBackground(languageIndex == selectedIndex.wrappedValue ? Color(.darkGray) : color)
                }
                .listStyle(.plain)
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
        VStack {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink {
                        Settings(viewModel: viewModel, font: Font(screen.infoUiFont))
                    } label: {
                        Image(systemName: "switch.2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(Font.title.weight(.thin))
                            .frame(height: screen.plusIconSize)
                            .foregroundColor(Color.white)
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                .listStyle(.sidebar)
                .background(.black)
                
                LanguageList(
                    selectedIndex: isFirstLanguage ? $viewModel.indexOfFirstLanguage : $viewModel.indexOfSecondLanguage,
                    list: viewModel.languages.list,
                    color: .black)
            }
        }
        .navigationTitle(isFirstLanguage ? "First Language" : "Second Language")
        .edgesIgnoringSafeArea(.bottom)
    }
}



#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), isFirstLanguage: true)
    }
}
