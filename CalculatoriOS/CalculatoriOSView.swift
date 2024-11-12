//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

struct CalculatoriOSView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: CalculatoriOSViewModel
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
    //    init(screen: Screen) {
    //        _viewModel = StateObject(wrappedValue: ViewModel(screen: screen))
    //    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                Spacer(minLength: 20.0)
                NumberDisplay(display: viewModel.display)
                KeyboardView(spacing: viewModel.screen.keySpacing, keyboard: viewModel.keyboard)
            }
        }
        .padding(.bottom, viewModel.screen.bottomPadding)
        .padding(.horizontal, viewModel.screen.horizontalPadding)
        .preferredColorScheme(.dark)
        //                .navigationDestination(isPresented: $viewModel.showSettings) {
        //                    if viewModel.showSettings {
        //                        Translate_1SettingsView(viewModel: viewModel)
        //                            .onDisappear {
        //                                viewModel.didReturnFromSettings()
        //                            }
        //                    }
        //                }
    }
}


#Preview {
    NavigationStack {
        CalculatoriOSView(viewModel: CalculatoriOSViewModel(screen: Screen()))
    }
}
