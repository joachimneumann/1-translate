//
//  LanguageSelectorView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import NumberTranslator

struct LanguageSelectorView: View {
    var viewModel: ViewModel
    
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
                .id(viewModel.translationManager.currentLanguage.rawValue)
//                .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
                .listRowBackground(Color(white: 0.5))
            }
            .onAppear() {
                scrollViewReaderProxy.scrollTo(viewModel.translationManager.currentLanguage.rawValue, anchor: .top)
            }
            .listStyle(.sidebar)
        }
        .background(.yellow)
        //        .onAppear() {
        //            currentLanguage = viewModel.numberTranslator.currentLanguage
        //            viewModel.display.separator.string = viewModel.persistent.decimalSeparator
        //            viewModel.calculator.separateGroups = viewModel.persistent.separateGroups
        //        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        //        .ignoresSafeArea()
    }
}

#Preview {
    GeometryReader { geo in
        LanguageSelectorView(viewModel: ViewModel(screen: Screen()))
    }
}

