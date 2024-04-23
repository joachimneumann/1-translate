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
                    viewModel.languages.firstName = currentLanguage.name
                } else {
                    viewModel.languages.second = currentLanguage
                    viewModel.languages.secondName = currentLanguage.name
                }
            }
            viewModel.updateTranslation()
        }
    }
    
// from https://forums.developer.apple.com/forums/thread/670957
    struct ContentView: View {
        @State var animalType: AnimalListView.AnimalType = .allAnimals
        @State var linkIsActive: Bool = false
        var body: some View {
            NavigationStack{
                List {
                    SummaryView(animalType: $animalType, linkIsActive: $linkIsActive)
                        .frame(width: 300)
                        .background(Color.green)
                        .navigationDestination(isPresented: $linkIsActive) { AnimalListView(animalType: animalType)
                        }
                }
            }
            NavigationView {
                List {
                    NavigationLink(
                        destination: AnimalListView(animalType: animalType)
                                        .onDisappear{animalType = .allAnimals},
                        isActive: $linkIsActive
                    ) {
                        SummaryView(animalType: $animalType, linkIsActive: $linkIsActive)
                            .frame(width: 300)
                            .background(Color.green)
                    }
                }
            }
        }
    }
    struct SummaryView: View {
        @Binding var animalType: AnimalListView.AnimalType
        @Binding var linkIsActive: Bool
        var body: some View {
            HStack {
                VStack {
                    Text("24")
                    Text("Dogs")
                }
                .background(Color.red)
                .onTapGesture {
                    print("Dogs")
                    animalType = .dog
                    linkIsActive = false
                }
                VStack {
                    Text("24")
                    Text("Cats")
                }
                .background(Color.orange)
                .onTapGesture {
                    print("Cats")
                    animalType = .cat
                    linkIsActive = false
                }
            }
        }
    }
    struct AnimalListView: View {
        enum AnimalType {
            case cat
            case dog
            case allAnimals
        }
        @State var animalType: AnimalType
        var body: some View {
            // list animals of selected type
            Text("list animals of \(String(describing: animalType))")
        }
    }
    
    var body: some View {
        ContentView()
    }
        
        
//        ScrollViewReader { scrollViewReaderProxy in
//            List(viewModel.languages.list)  { language in
//                let selected: Bool = language.name == currentLanguage?.name
//                Button {
//                    currentLanguage = language
//                } label: {
//                    HStack(spacing: 0) {
//                        Image(language.flagName)
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.vertical, 1)
//                            .border(.white, width: 1)
//                            .frame(height: 20)
//                        Text(language.name)
//                            .padding(.leading, 10)
//                        if language.nameDescription != nil {
//                            Text(" ("+language.nameDescription!+")")
//                        }
//                        Spacer()
//                        if selected {
//                            NavigationLink(destination: Text("2nd  View")) {
//                                Image(systemName: "chevron.forward.square")
//                                    .foregroundColor(.yellow)
//                                    .font(.system(size: 25))
//                                }
//                        } else {
//                            Rectangle()
//                                .background()
//                                .frame(width: 20, height: 0)
//                        }
//                    }
//                }
//                .id(language.name)
//                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
//            }
//            .onAppear() {
//                scrollViewReaderProxy.scrollTo(isFirstLanguage ? viewModel.languages.first.name : viewModel.languages.second.name, anchor: .top)
//            }
//            .listStyle(.sidebar)
//        }
//        .onAppear() {
//            if isFirstLanguage {
//                currentLanguage = viewModel.languages.first
//            } else {
//                currentLanguage = viewModel.languages.second
//            }
//        }
//        .padding(.top, 20)
//        .navigationTitle(isFirstLanguage ? "First Language" : "Second Language")
//        .toolbar {
//            NavigationLink {
//                Settings(viewModel: viewModel, font: Font(screen.infoUiFont))
//            } label: {
//                Image(systemName: "gearshape")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .bold()
//                    .frame(height: 30)
//                    .foregroundColor(Color.white)
//                    .padding(.top, 14)
//                    .padding(.trailing, 5)
//            }
//        }
//    }
    
}


#Preview {
    GeometryReader { geo in
        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), isFirstLanguage: true)
    }
}
