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
    
    @State var timerIsRunning: Bool = false
    @State var settingsPrecision: Int = 0
    @State var settingsForceScientific: Bool = false
    @State var settingsShowPreliminaryResults: Bool = false
    @State var timerInfo: String = "click to measure"
    @State var settingsDecimalSeparator: DecimalSeparator = .comma
    @State var settingsGroupingSeparator: GroupingSeparator = .none
    
    var body: some View {
        VStack {
            BackButton(
                timerIsRunning: timerIsRunning,
                screen: screen,
                font: font,
                presentationMode: presentation)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    switches
                        .padding(.top, 20)
                    
                    hobbyProject
                        .padding(.top, 20)
                    
                    Spacer()
                }
                //.font(font)
                .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .onDisappear() {
                Task {
                    if viewModel.precision != settingsPrecision {
                        await viewModel.updatePrecision(to: settingsPrecision)
                    }
                    await viewModel.refreshDisplay(screen: screen)
                }
                if viewModel.showPreliminaryResults != settingsShowPreliminaryResults {
                    viewModel.showPreliminaryResults = settingsShowPreliminaryResults
                }
                if screen.forceScientific != settingsForceScientific {
                    screen.forceScientific = settingsForceScientific
                }
                if screen.decimalSeparator != settingsDecimalSeparator {
                    screen.decimalSeparator = settingsDecimalSeparator
                }
                if screen.groupingSeparator != settingsGroupingSeparator {
                    screen.groupingSeparator = settingsGroupingSeparator
                }
            }
        }
        .onAppear() {
            settingsPrecision              = viewModel.precision
            settingsShowPreliminaryResults = viewModel.showPreliminaryResults
            settingsForceScientific        = screen.forceScientific
            settingsDecimalSeparator       = screen.decimalSeparator
            settingsGroupingSeparator      = screen.groupingSeparator
        }
#if !os(macOS)
        .navigationBarHidden(true)
#endif
        .navigationBarBackButtonHidden(true)
    }
    
    struct BackButton: View {
        let timerIsRunning: Bool
        let screen: Screen
        let font: Font
        let presentationMode: Binding<PresentationMode>
        var body: some View {
            HStack {
                Button {
                    if !timerIsRunning {
                        presentationMode.wrappedValue.dismiss()
                    }
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
            .foregroundColor(timerIsRunning ? .gray : .white)
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
            }
            .foregroundColor(timerIsRunning ? .gray : .white)
            .multilineTextAlignment(.leading)
            VStack(alignment: .leading, spacing: 0.0) {
                Picker("", selection: $settingsDecimalSeparator) {
                    ForEach(DecimalSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .frame(height: tableCellHeight)
                .onChange(of: settingsDecimalSeparator) { _ in
                    if settingsDecimalSeparator == .comma {
                        if settingsGroupingSeparator == .comma {
                            settingsGroupingSeparator = .dot
                        }
                    } else if settingsDecimalSeparator == .dot {
                        if settingsGroupingSeparator == .dot {
                            settingsGroupingSeparator = .comma
                        }
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 230 * 2 / 3)
                Picker("", selection: $settingsGroupingSeparator) {
                    ForEach(GroupingSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .frame(height: tableCellHeight)
                .onChange(of: settingsGroupingSeparator) { _ in
                    if settingsGroupingSeparator == .comma {
                        if settingsDecimalSeparator == .comma {
                            settingsDecimalSeparator = .dot
                        }
                    } else if settingsGroupingSeparator == .dot { /// dot
                        if settingsDecimalSeparator == .dot { /// also dot
                            settingsDecimalSeparator = .comma
                        }
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 230)
            }
        }
    }
    
    var decimalSeparatorView: some View {
        HStack(spacing: 20.0) {
            let example = settingsForceScientific ?
            "1\(settingsDecimalSeparator.string)20003 e4" :
            "12\(settingsGroupingSeparator.string)000\(settingsDecimalSeparator.string)3"
            Text("Decimal Separator")
                .foregroundColor(timerIsRunning ? .gray : .white)
            Picker("", selection: $settingsDecimalSeparator) {
                ForEach(DecimalSeparator.allCases, id: \.self) { value in
                    Text("\(value.rawValue)")
                        .tag(value)
                }
            }
            .onChange(of: settingsDecimalSeparator) { _ in
                if settingsDecimalSeparator == .comma {
                    if settingsGroupingSeparator == .comma {
                        settingsGroupingSeparator = .dot
                    }
                } else if settingsDecimalSeparator == .dot {
                    if settingsGroupingSeparator == .dot {
                        settingsGroupingSeparator = .comma
                    }
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 160)
            Text("for example \(example)")
                .foregroundColor(.gray)
                .padding(.leading, 0)
            Spacer()
        }
    }
    
    var groupingSeparatorView: some View {
        HStack(spacing: 20.0) {
            Text("Grouping Separator")
                .foregroundColor(timerIsRunning ? .gray : .white)
            Picker("", selection: $settingsGroupingSeparator) {
                ForEach(GroupingSeparator.allCases, id: \.self) { value in
                    Text("\(value.rawValue)")
                        .tag(value)
                }
            }
            .onChange(of: settingsGroupingSeparator) { _ in
                if settingsGroupingSeparator == .comma {
                    if settingsDecimalSeparator == .comma {
                        settingsDecimalSeparator = .dot
                    }
                } else if settingsGroupingSeparator == .dot { /// dot
                    if settingsDecimalSeparator == .dot { /// also dot
                        settingsDecimalSeparator = .comma
                    }
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 260)
            Spacer()
        }
    }
    
    var hobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return Text("\nVersion: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
            .foregroundColor(Color.gray) +

        Text("\nThis is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. The App is free to use. The code is open source and you may add a feature requestion or report a bug at the ")
            .foregroundColor(Color.gray) +
            
        Text("[github repository](https://github.com/joachimneumann/VietnameseNumbers)")
            .foregroundColor(Color.white) /// This link is blue. I don't know why.
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
