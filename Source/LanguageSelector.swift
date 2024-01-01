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
                    let selected = languageIndex == selectedIndex.wrappedValue
                    HStack(spacing: 0) {
                        Image(language.flagName)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 1)
                            .border(.white, width: 1)
                            .frame(height: 20)
//                            .padding(.trailing, 10)
                        Text("  "+language.name)
                        if language.nameDescription != nil {
                            Text("/"+language.nameDescription!)
                                .italic()
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
//                    .listRowBackground(languageIndex == selectedIndex.wrappedValue ? Color(.darkGray) : color)
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
                .padding(.trailing, 20)
                .background(.black)
                
                LanguageList(
                    selectedIndex: isFirstLanguage ? $viewModel.indexOfFirstLanguage : $viewModel.indexOfSecondLanguage,
                    list: viewModel.languages.list,
                    color: .black)
            }
        }
        .navigationTitle(isFirstLanguage ? "First Language" : "Second Language")
//        .edgesIgnoringSafeArea(.bottom)
    }
}



#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), isFirstLanguage: true)
    }
}
