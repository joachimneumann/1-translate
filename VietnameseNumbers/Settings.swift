//
//  Settings.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI

struct Settings: View {

    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    
    @ObservedObject var viewModel: ViewModel
    let screen: Screen
    let font: Font
    
//    @State var settingsDecimalSeparator: DecimalSeparator = .comma
    
    var body: some View {
        VStack {
            BackButton(
                screen: screen,
                font: font,
                presentationMode: presentation)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    switches
                        .padding(.top, 20)
                    Spacer()
                }
                //.font(font)
                .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .onDisappear() {
                Task {}
            }
            .onAppear() {
                //            settingsGroupingSeparator      = screen.groupingSeparator
            }
            .navigationBarHidden(true)
        }
    }
        
    struct BackButton: View {
        let screen: Screen
        let font: Font
        let presentationMode: Binding<PresentationMode>
        var body: some View {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15.0)
                        Text("Back")
                    }
                }
                .buttonStyle(TransparentButtonStyle())
                Spacer()
            }
//            .font(font)
            .foregroundColor(.white)
            .padding()
        }
    }
    
//        .fixedSize(horizontal: false, vertical: true)
//        .fixedSize(horizontal: true, vertical: false)
    var switches: some View {
        HStack(alignment: .center, spacing: 20.0) {
            let tableCellHeight = 50.0
            VStack(alignment: .leading, spacing: 00.0) {
                Text("Decimal Separator")
                    .frame(height: tableCellHeight)
                Text("Grouping Separator")
                    .frame(height: tableCellHeight)
                Text("Force scientific display")
                    .frame(height: tableCellHeight)
                Text("Show preliminary results")
                    .frame(height: tableCellHeight)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            VStack(alignment: .leading, spacing: 0.0) {
//                Picker("", selection: $settingsDecimalSeparator) {
//                    ForEach(DecimalSeparator.allCases, id: \.self) { value in
//                        Text("\(value.rawValue)")
//                            .tag(value)
//                    }
//                }
//                .frame(height: tableCellHeight)
//                .onChange(of: settingsDecimalSeparator) { _ in
//                    if settingsDecimalSeparator == .comma {
//                        if settingsGroupingSeparator == .comma {
//                            settingsGroupingSeparator = .dot
//                        }
//                    } else if settingsDecimalSeparator == .dot {
//                        if settingsGroupingSeparator == .dot {
//                            settingsGroupingSeparator = .comma
//                        }
//                    }
//                }
//                .pickerStyle(.segmented)
//                .frame(width: 230 * 2 / 3)
            }
        }
    }
    
    
    struct ColoredToggleStyle: ToggleStyle {
        var label = ""
        var onColor = Color.green
        var offColor = Color(white: 0.5)
        var thumbColor = Color.white
        
        func makeBody(configuration: Self.Configuration) -> some View {
            HStack {
                Text(label)
                Spacer()
                Button(action: { configuration.isOn.toggle() } )
                {
                    RoundedRectangle(cornerRadius: 16, style: .circular)
                        .fill(configuration.isOn ? onColor : offColor)
                        .frame(width: 50, height: 29)
                        .overlay(
                            Circle()
                                .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: configuration.isOn ? 10 : -10))
                }
            }
            .font(.title)
            .padding(.horizontal)
        }
    }
}

private extension Int {
    var asMemorySize: String {
        let d = Double(self)
        if d > 1e9 {
            return String(format: "%.1fGB", d / 1e9)
        }
        if d > 1e6 {
            return String(format: "%.1fMB", d / 1e6)
        }
        if d > 1e3 {
            return String(format: "%.1fKB", d / 1e3)
        }
        return String(format: "%.0f bytes", d)
    }
}

struct ControlCenter_Previews: PreviewProvider {
    static var previews: some View {
        Settings(
            viewModel: ViewModel(),
            screen: Screen(CGSize()),
            font: Font(Screen.appleFont(ofSize: 20)))
        .background(.black)
    }
}

struct TransparentButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .background(.clear)
  }
}
