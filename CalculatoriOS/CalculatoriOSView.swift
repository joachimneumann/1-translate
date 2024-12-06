//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct CalculatoriOSView: View {
    let model = ViewModel()
    
    var body: some View {
        let _ = print("CalculatoriOSView body()")
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                Spacer()
                NumberDisplay(display: model.display)
                    .padding(.horizontal, model.keyboard.padding)
                    .padding(.bottom, model.keyboard.padding * 0.2)
                    .frame(width: model.keyboard.frame.width)
                HStack {
                    Spacer()
                    KeyboardView(keyboard: model.keyboard)
                        .frame(width: model.keyboard.frame.width, height: model.keyboard.frame.height)
                    Spacer()
                }
            }
        }
    }
}


//struct CalculatoriOSView: View {
//    @ObservedObject var viewModel: CalculatoriOSViewModel
//    
//    @State var scrollViewID = UUID()
//    @State var isZoomed: Bool = false
//    @State private var settingsDetent = PresentationDetent.medium
//    
//    //    init(screen: Screen) {
//    //        _viewModel = StateObject(wrappedValue: ViewModel(screen: screen))
//    //    }
//    
//    var body: some View {
////        Text("XX")
//        VStack(spacing: 0.0) {
//            VStack(spacing: 0.0) {
//                Spacer(minLength: 20.0)
//                NumberDisplay(display: viewModel.display)
//                KeyboardView(spacing: viewModel.screen.keySpacing, keyboard: viewModel.keyboard)
//            }
//        }
//        .padding(.bottom, viewModel.screen.bottomPadding)
//        .padding(.horizontal, viewModel.screen.horizontalPadding)
////                        .navigationDestination(isPresented: $viewModel.showSettings) {
////                            if viewModel.showSettings {
////                                Translate_1SettingsView(viewModel: viewModel)
////                                    .onDisappear {
////                                        viewModel.didReturnFromSettings()
////                                    }
////                            }
////                        }
//    }
//}


#Preview("Dark") {
    CalculatoriOSView()
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    CalculatoriOSView()
        .preferredColorScheme(.light)
}

