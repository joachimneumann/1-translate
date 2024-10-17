////
////  CountryDetailScreen.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 12/11/23.
////
//
//import SwiftUI
//import NumberTranslator
//
////extension NumberTranslator.XXXX: @retroactive Identifiable {
////    public var id: String { rawValue }
////}
//
//struct LanguageSelector: View {
//    var viewModel: ViewModel
//    let screen : Screen
//    
////    @State var currentLanguage: NumberTranslator.Language {
////        didSet {
////            viewModel.numberTranslator.currentLanguage = currentLanguage
////            viewModel.updateTranslation()
////        }
////    }
//        
//    var body: some View {
//        ScrollViewReader { scrollViewReaderProxy in
//            List(NumberTranslator.Language.allCases) { listLanguage in
//                let selected: Bool = (viewModel.numberTranslator.name(listLanguage) == viewModel.numberTranslator.name(currentLanguage))
//                let name = viewModel.numberTranslator.name(listLanguage)
//                let x = viewModel.numberTranslator.englishName(listLanguage)
//                let englishName = (x != nil ? " (\(x!))" : "")
//                Button {
//                    currentLanguage = listLanguage
//                } label: {
//                    HStack(spacing: 0) {
//                        Image(viewModel.numberTranslator.flagName(listLanguage))
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.vertical, 1)
//                            .border(.white, width: 1)
//                            .frame(height: 20)
//                        Text(name)
//                            .padding(.leading, 10)
//                        Text(englishName)
//                        Spacer()
//                        if selected {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.yellow)
//                                .bold()
//                                .frame(width: 20)
//                        } else {
//                            Rectangle()
//                                .background()
//                                .frame(width: 20, height: 0)
//                        }
//                    }
//                }
//                .id(viewModel.numberTranslator.currentLanguage.rawValue)
//                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
//            }
//            .onAppear() {
//                scrollViewReaderProxy.scrollTo(viewModel.numberTranslator.currentLanguage.rawValue, anchor: .top)
//            }
//            .listStyle(.sidebar)
//        }
//        .onAppear() {
//            currentLanguage = viewModel.numberTranslator.currentLanguage
//            viewModel.calculator.decimalSeparator = viewModel.persistent.decimalSeparator
//            viewModel.calculator.separateGroups = viewModel.persistent.separateGroups
//        }
//        .padding(.top, 20)
//        .navigationTitle("Select Language")
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
//    
//}
//
//
////#Preview {
////    GeometryReader { geo in
////        LanguageSelector(viewModel: ViewModel(), screen: Screen(geo.size), currentLanguage: .english)
////    }
////}
