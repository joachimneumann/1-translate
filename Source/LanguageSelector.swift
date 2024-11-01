//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI
import NumberTranslator

//extension NumberTranslator.XXXX: @retroactive Identifiable {
//    public var id: String { rawValue }
//}

struct LanguageSelector: View {
    var viewModel: ViewModel
    
    //    @State var currentLanguage: NumberTranslator.Language {
    //        didSet {
    //            viewModel.numberTranslator.currentLanguage = currentLanguage
    //            viewModel.updateTranslation()
    //        }
    //    }
    
    var body: some View {
        ScrollViewReader { scrollViewReaderProxy in
            List(NumberTranslator.Language.allCases) { listLanguage in
                let selected: Bool = (viewModel.translationManager.name(listLanguage) == viewModel.translationManager.name(viewModel.translationManager.currentLanguage))
                let name = viewModel.translationManager.name(listLanguage)
                let x = viewModel.translationManager.englishName(listLanguage)
                let englishName = (x != nil ? " (\(x!))" : "")
                Button {
                    viewModel.translationManager.currentLanguage = listLanguage
                } label: {
                    HStack(spacing: 0) {
                        Image(viewModel.translationManager.flagName(listLanguage))
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 1)
                            .border(.white, width: 1)
                            .frame(height: 20)
                    }
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
                .id(viewModel.translationManager.currentLanguage.rawValue)
                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
            }
            .onAppear() {
                scrollViewReaderProxy.scrollTo(viewModel.translationManager.currentLanguage.rawValue, anchor: .top)
            }
            .listStyle(.sidebar)
        }
        .onAppear() {
            //            currentLanguage = viewModel.numberTranslator.currentLanguage
            //            viewModel.display.separator.string = viewModel.persistent.decimalSeparator
            //            viewModel.calculator.separateGroups = viewModel.persistent.separateGroups
        }
        .padding(.top, 20)
        .navigationTitle("Select Language")
        //        .toolbar {
        //            NavigationLink {
        //                Settings(viewModel: viewModel, font: Font(viewModel.screen.infoUiFont))
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
    }
    
}


//#Preview {
//    LanguageSelector(viewModel: ViewModel(), screen: Screen(), currentLanguage: .english)
//}
