//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

//let darkColor = Color(red: 65.0/255.0, green: 67.0/255.0, blue: 48.0/255.0)
let darkColor = Color(red: 59.0/255.0, green: 36.0/255.0, blue: 28.0/255.0)


struct MyDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                configuration.label
            }
            .padding(.vertical, 10)
            .contentShape(Rectangle())
        }
    }
}

struct LanguageSelector: View {
    
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    @ObservedObject var viewModel: ViewModel
    let screen : Screen
    @State private var isExpanded = false
    
    let contacts = [
        "John",
        "Alice",
        "Bob"
    ]
    
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
                        if language.englishName != nil {
                            Text(language.englishName!)
                                .italic()
                        }
                    }
                    .id(languageIndex)
                    //                    .padding(.horizontal, 10)
                    //                    .padding(.vertical, 5)
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
        ZStack(alignment: .top) {
            darkColor
                .edgesIgnoringSafeArea(.bottom)
            //                .ignoresSafeArea(SafeAreaRegions.)
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
                                .frame(height: screen.plusIconSize * 0.8)
                                .foregroundColor(Color.white)
                        }
                        .buttonStyle(TransparentButtonStyle())
                        .opacity(0.9)
                    }
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                    .listStyle(.sidebar)
                    .background(.black)
                    
                    LanguageList(
                        selectedIndex: $viewModel.indexOfFirstLanguage,
                        list: viewModel.languages.list,
                        color: .black)
                }
                .background(.black)
                VStack {
                    Text("Second Language")
                        .bold()
                        .padding(.top, 5)
                        .padding(.bottom, viewModel.secondLanguageAllowed ? 10 : 30)
                        .onTapGesture {
                            withAnimation {
                                viewModel.secondLanguageAllowed.toggle()
                            }
                        }
                        .disclosureGroupStyle(MyDisclosureStyle())
                    if viewModel.secondLanguageAllowed {
                        LanguageList(
                            selectedIndex: $viewModel.indexOfSecondLanguage,
                            list: viewModel.languages.list,
                            color: darkColor)
                        .transition(.move(edge: .bottom))
                    }
                }
                .background(darkColor)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}



#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size))
    }
}
