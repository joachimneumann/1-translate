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
                Spacer()
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
                    .bold()
            }
            .padding()
            .padding(.trailing, 5)
            .contentShape(Rectangle())
        }
    }
}

struct LanguageSelector: View {
    @ObservedObject var viewModel: ViewModel
    let screen : Screen
    @State var additionalDisclosureText = ""

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
        ZStack(alignment: .top) {
            darkColor
                .edgesIgnoringSafeArea(.bottom)
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
                    DisclosureGroup(isExpanded: $viewModel.persistent.secondLanguageAllowed) {
                    } label: {
                        HStack {
                            Text("Second Language")
                                .bold()
                            Text(additionalDisclosureText)
                                .italic()
                                .padding(.leading, 5)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.persistent.secondLanguageAllowed.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation {
                                if viewModel.persistent.secondLanguageAllowed {
                                    additionalDisclosureText = ""
                                } else {
                                    additionalDisclosureText = "(hidden)"
                                }
                            }
                        }
                    }
                    .disclosureGroupStyle(MyDisclosureStyle())
                    if viewModel.persistent.secondLanguageAllowed {
                        LanguageList(
                            selectedIndex: $viewModel.indexOfSecondLanguage,
                            list: viewModel.languages.list,
                            color: darkColor)
                        .transition(.move(edge: .bottom))
                        Rectangle()
                            .frame(height: 0)
                            .padding(.bottom, 30)
                    } else {
                        Rectangle()
                            .frame(height: 0)
                            .padding(.bottom, 30)
                    }
                }
                .background(darkColor)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear() {
            additionalDisclosureText = viewModel.persistent.secondLanguageAllowed ? "" : "(hidden)"
        }
    }
}



#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size))
    }
}
