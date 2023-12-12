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
        let _2_selected = viewModel.allowSecondLanguage && viewModel.secondTranslator == translator
        let _2_allowed = viewModel.allowSecondLanguage
        HStack {
            Image(translator.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 25)
                .padding(.trailing, 10)
                .opacity(_1_selected ? 1.0 : 0.5)
            if _2_allowed {
                Image(translator.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .padding(.trailing, 10)
                    .opacity(_2_selected ? 1.0 : 0.5)
            }
            Text(translator.language)
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
        ScrollView {
            HStack {
                Toggle("", isOn: viewModel.$allowSecondLanguage)
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
            .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 0.0) {
                languageSelector(viewModel: viewModel, translator: viewModel.translateEnglish)
                languageSelector(viewModel: viewModel, translator: viewModel.translateGerman)
                languageSelector(viewModel: viewModel, translator: viewModel.translateVietnamese)
                languageSelector(viewModel: viewModel, translator: viewModel.translateSpanish)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Image(viewModel.translateGerman.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.translateGerman.language)
                        .frame(height: 25)
                    Spacer()
                }
            }
            .onTapGesture {
                //                if forTranslatorNumber == 0 {
                //                    viewModel.firstTranslator = viewModel.translateGerman
                //                } else {
                //                    viewModel.secondTranslator = viewModel.translateGerman
                //                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(viewModel.firstTranslator == viewModel.translateGerman ? .gray : .black)
            .padding(.bottom, 40)
            
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Image(viewModel.translateVietnamese.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.translateVietnamese.language)
                        .frame(height: 25)
                    Spacer()
                }
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
            .onTapGesture {
                //                if forTranslatorNumber == 0 {
                //                    viewModel.firstTranslator = viewModel.translateVietnamese
                //                } else {
                //                    viewModel.secondTranslator = viewModel.translateVietnamese
                //                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(viewModel.firstTranslator == viewModel.translateVietnamese ? .gray : .black)
            .padding(.bottom, 40)
            
            //                }
            //            }
            //            .padding(5)
            //            .background(Color.gray)
            //            .padding(.bottom, 40)
            //            Grid(alignment: .leading, horizontalSpacing: 20.0, verticalSpacing: 10.0) {
            //                GridRow {
            Image("flag UK")
                .resizable()
                .scaledToFit()
                .frame(height: 25)
        }
        //                GridRow {
        Text(viewModel.settingsEnglishExample)
            .foregroundColor(.white)
            .padding(.leading, 0)
            .gridCellColumns(2)
            .gridCellUnsizedAxes(.horizontal)
        //                }
        //                GridRow {
        Text("use \"and\"")
        Toggle("", isOn: $viewModel.englishUseAndAfterHundred)
            .frame(width: 40)
            .toggleStyle(
                ColoredToggleStyle(onColor: Color(white: 0.6),
                                   offColor: Color(white: 0.25),
                                   thumbColor: .white))
            .padding(.leading, 3)
    }
    //}
    //}
    //    .foregroundColor(Color.white)
    //}
    //    .padding(.horizontal)
    //}
}

#Preview {
    CountryDetailScreen(viewModel: ViewModel())
        .background(Color.black)
}
