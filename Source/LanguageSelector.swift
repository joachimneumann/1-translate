//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct OneLanguage: View {
    @ObservedObject var viewModel: ViewModel
    let isFirstLanguage: Bool
    let language: Language
    
    var body: some View {
        let imageBorderWidth: CGFloat = 3
        let isSelected = isFirstLanguage ? (language.name == viewModel.firstLanguage.name) : (language.name == viewModel.secondLanguage.name)
        Button(action: {
            isFirstLanguage ? viewModel.newFirstLanguage(language) : viewModel.newSecondLanguage(language)
        }) {
            HStack {
                Image(language.flagName)
                    .resizable()
                    .scaledToFit()
                    .padding(imageBorderWidth)
                    .border(.white, width: isSelected ? imageBorderWidth : 0)
                    .frame(height: 30)
                    .padding(.trailing, 10)
                Text(language.name)
                    .bold(isSelected)
                    .foregroundColor(.white)
                Spacer(minLength: 0)
                if let e = language.englishName {
                    Text(" "+e)
                        .italic()
                        .foregroundColor(isSelected ? .white : Color(.lightGray))
                }
            }
        }
        .padding(.bottom, 8)
    }
}


struct LanguageSelector: View {
    
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    @ObservedObject var viewModel: ViewModel
    let screen : Screen
    @State var scrollPosition: Int?
    
    var body: some View {
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
                        .frame(height: screen.plusIconSize * 0.8)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(TransparentButtonStyle())
                .opacity(0.9)
            }
            .padding(.bottom, 15)
            .padding(.trailing, 15)
            ScrollViewReader { scrollViewProxy in
                List {
                    ForEach(0 ..< viewModel.languages.list.count, id: \.self) { index in
                        OneLanguage(viewModel: viewModel, isFirstLanguage: true, language: viewModel.languages.list[index])
                            .id(index)
                            .padding(.trailing, 15)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .onAppear {
                    scrollViewProxy.scrollTo(viewModel.firstLanguageIndex, anchor: .top)
                }
            }
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
            
            HStack {
                Text("Second Language")
                    .bold()
                    .onTapGesture {
                        viewModel.secondLanguageAllowed = !viewModel.secondLanguageAllowed
                    }
                Spacer()
            }
            .padding(.top, 15)
            if viewModel.secondLanguageAllowed {
                ScrollViewReader { scrollViewProxy in
                    List {
                        ForEach(0 ..< viewModel.languages.list.count, id: \.self) { index in
                            OneLanguage(viewModel: viewModel, isFirstLanguage: false, language: viewModel.languages.list[index])
                                .id(index)
                                .padding(.trailing, 15)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(.plain)
                    .onAppear {
                        scrollViewProxy.scrollTo(viewModel.secondLanguageIndex, anchor: .top)
                    }
                }
                .background(Color(red: 0.1, green: 0.1, blue: 0.1))
//
//
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 0.0) {
//                        ForEach(0 ..< viewModel.languages.list.count, id: \.self) { index in
//                            OneLanguage(viewModel: viewModel, isFirstLanguage: false, language: viewModel.languages.list[index])
//                        }
//                    }
//                    .padding(.trailing, 15)
//                }
//                .background(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
        }
        .padding(.leading, 15)
        .padding(.bottom, 15)
    }
}

