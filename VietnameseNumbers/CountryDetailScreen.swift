//
//  CountryDetailScreen.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/11/23.
//

import SwiftUI

struct languageSelector: View {
    @ObservedObject var viewModel: ViewModel
    let translator: BasicTranslator
    var body: some View {
        let _1_selected = viewModel.firstTranslator == translator
        let _2_selected = viewModel.secondTranslator == translator
        HStack {
            Button(action: {
                viewModel.firstLanguage = translator.language
            }) {
                Image(translator.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .padding(.trailing, 10)
                    .opacity(_1_selected ? 1.0 : 0.3)
            }
            if viewModel.secondLanguageAllowed {
                Button(action: {
                    viewModel.secondLanguage = translator.language
                }) {
                    Image(translator.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.trailing, 10)
                        .opacity(_2_selected ? 1.0 : 0.3)
                }
            }
            Text(translator.language)
                .bold(_1_selected || (viewModel.secondLanguageAllowed && _2_selected))
                .frame(height: 25)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(.bottom, 15)
    }
}
struct CountryDetailScreen: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Toggle("", isOn: $viewModel.secondLanguageAllowed)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .padding(.trailing, 15)
                    Text("Add second Language")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                languageSelector(viewModel: viewModel, translator: viewModel.translateEnglish)
                languageSelector(viewModel: viewModel, translator: viewModel.translateGerman)
                languageSelector(viewModel: viewModel, translator: viewModel.translateVietnamese)
                languageSelector(viewModel: viewModel, translator: viewModel.translateSpanish)
//                Text("Settings")
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding(.top, 40)
//                    .padding(.bottom, 20)
//                HStack {
//                    Toggle("", isOn: $viewModel.secondLanguageAllowed)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .padding(.trailing, 15)
//                    Text("Add second Language")
//                        .foregroundColor(Color.white)
//                    Spacer()
//                }
            }
            .padding(20)
            .background(Color(red: 0.3, green: 0.3, blue: 0.3))
//            .padding(.horizontal, 20)
//            .padding(.top, 20)
//            .frame(maxWidth: .infinity)
        }
        
            
//            VStack(alignment: .leading, spacing: 0.0) {
//                HStack {
//                    Image(viewModel.translateGerman.imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 25)
//                        .padding(.trailing, 10)
//                    Text(viewModel.translateGerman.language)
//                        .frame(height: 25)
//                    Spacer()
//                }
//            }
//            .onTapGesture {
//                //                if forTranslatorNumber == 0 {
//                //                    viewModel.firstTranslator = viewModel.translateGerman
//                //                } else {
//                //                    viewModel.secondTranslator = viewModel.translateGerman
//                //                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.vertical, 20)
//            .frame(maxWidth: .infinity)
//            .background(viewModel.firstTranslator == viewModel.translateGerman ? .gray : .black)
//            .padding(.bottom, 40)
//            
//            
//            VStack(alignment: .leading, spacing: 0.0) {
//                HStack {
//                    Image(viewModel.translateVietnamese.imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 25)
//                        .padding(.trailing, 10)
//                    Text(viewModel.translateVietnamese.language)
//                        .frame(height: 25)
//                    Spacer()
//                }
//            }
//            .onTapGesture {
//            }
//            .padding(.horizontal, 20)
//            .padding(.vertical, 20)
//            .frame(maxWidth: .infinity)
//            .background(viewModel.firstTranslator == viewModel.translateVietnamese ? .gray : .black)
//            .padding(.bottom, 40)
//            Image("flag UK")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 25)
//        }
//        //                GridRow {
//        Text(viewModel.settingsEnglishExample)
//            .foregroundColor(.white)
//            .padding(.leading, 0)
//            .gridCellColumns(2)
//            .gridCellUnsizedAxes(.horizontal)
//        //                }
//        //                GridRow {
//        Text("use \"and\"")
//        Toggle("", isOn: $viewModel.settingsEnglishUseAndAfterHundred)
//            .frame(width: 40)
//            .toggleStyle(
//                ColoredToggleStyle(onColor: Color(white: 0.6),
//                                   offColor: Color(white: 0.25),
//                                   thumbColor: .white))
//            .padding(.leading, 3)

    //}
    //}
    //    .foregroundColor(Color.white)
    //}
    //    .padding(.horizontal)
    //}
    
    //                Text(viewModel.settingsVietnameseExample)
    //                    .foregroundColor(.white)
    //                    .padding(.leading, 0)
    //                    .gridCellColumns(2)
    //                    .gridCellUnsizedAxes(.horizontal)
    //                Text("1000")
    //                Picker("", selection: $viewModel.vietnameseThousand) {
    //                    ForEach(VietnameseThousand.allCases, id: \.self) { value in
    //                        Text("\(value.rawValue)")
    //                            .tag(value)
    //                    }
    //                }
    //                .frame(width: 220)
    //                .padding(2)
    //                .background(Color(UIColor.darkGray))
    //                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
    //                .pickerStyle(.segmented)
    //                Text("1?3")
    //                Picker("", selection: $viewModel.vietnameseSecondLast) {
    //                    ForEach(VietnameseSecondLast.allCases, id: \.self) { value in
    //                        Text("\(value.rawValue)")
    //                            .tag(value)
    //                    }
    //                }
    //                .frame(width: 220)
    //                .padding(2)
    //                .background(Color(UIColor.darkGray))
    //                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
    //                .pickerStyle(.segmented)
    //                Text("Compact")
    //                Toggle("", isOn: $viewModel.vietnameseCompact)
    //                    .frame(width: 40)
    //                    .toggleStyle(
    //                        ColoredToggleStyle(onColor: Color(white: 0.6),
    //                                           offColor: Color(white: 0.25),
    //                                           thumbColor: .white))
    //                    .padding(.leading, 3)

    
}

#Preview {
    CountryDetailScreen(viewModel: ViewModel())
        .background(Color.black)
}
