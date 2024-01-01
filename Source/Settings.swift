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
    let font: Font
    let yellow = Color(red: 242.0/255.0, green: 203.0/255.0, blue: 48.0/255.0)
    
    var body: some View {
        VStack {
            List {
                Appearance(temp: $viewModel.persistent.secondLanguageAllowed)
                DigitsSettings
                VoiceSettings
                LanguageSettings
                HobbyProject
            }
            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 0.0) {
                    //                    Grid(alignment: .leading, horizontalSpacing: 10.0, verticalSpacing: 10.0) {
                    //                        DigitsSettings
                    //                        VoiceSettings
                    //                        EnglishSettings
                    //                        GermanSettings
                    //                        SpanishSettings
                    //                        VietnameseSettings
                    //                    }
                    //                    HobbyProject
//                    Spacer()
//                }
//                .padding(.top, 10)
//                .foregroundColor(Color.white)
//                .padding(.horizontal, 15)
//            }
//            .padding(.top, 10)
        }
        .navigationTitle("Settings")
    }
    
    struct Appearance: View {
        @Binding var temp: Bool
        var body: some View {
            Section(header: Text("Appearance")) {
                Grid(alignment: .center, horizontalSpacing: 0.0, verticalSpacing: 10.0) {
                    GridRow {
                        let size: CGFloat = 20.0
                        VStack {
                            Image("oneLanguage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 20)
                            Text("One")
                            if !temp {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.yellow)
                                    .frame(width: size, height: size)
                            } else {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(Color(UIColor.tertiaryLabel))
                                    .frame(width: size, height: size)
                            }
                        }
                        .onTapGesture {
                            temp = false
                        }
                        VStack {
                            Image("twoLanguages")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 20)
                            Text("Two")
                            if temp {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.yellow)
                                    .frame(width: size, height: size)
                            } else {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(Color(UIColor.tertiaryLabel))
                                    .frame(width: size, height: size)
                            }
                        }
                        .onTapGesture {
                            temp = true
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
    }
    
    var DigitsSettings: some View {
        let example =  Display(left: "").withSeparators(numberString: "10000.05", isNegative: false, separators: viewModel.persistent)
        return Section(header: Text("Display and Seperators")) {
            Grid(alignment: .leading, verticalSpacing: 10) {
                GridRow {
                    Text("\(example)")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .gridCellColumns(2)
                        .padding(.bottom, 5)
                }
                GridRow {
                    Text("Decimal")
                        .padding(.trailing, 5)
                    Picker("", selection: $viewModel.persistent.decimalSeparator) {
                        ForEach(DecimalSeparator.allCases, id: \.self) { value in
                            Text("\(value.rawValue)")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                GridRow {
                    Text("Grouping")
                        .padding(.trailing, 5)
                   Picker("", selection: $viewModel.persistent.groupSeparator) {
                        ForEach(GroupSeparator.allCases, id: \.self) { value in
                            Text("\(value.rawValue)")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                GridRow {
                    Text("GroupSize")
                        .padding(.trailing, 5)
                    Picker("", selection: $viewModel.persistent.groupSize) {
                        ForEach(GroupSize.allCases, id: \.self) { value in
                            Text("\(value.string)")
                                .tag(value)
                        }
                    }
                    .frame(width: 150)
                    .pickerStyle(.segmented)
                }
            }
        }
    }
    
    var VoiceSettings: some View {
        let noVoice = !viewModel.persistent.offerReadingAloud
        let color =  noVoice ? yellow.opacity(0.7) : yellow
        let symbolName = noVoice ? "speaker.slash.fill" : "speaker.wave.3.fill"
        return Section(header: Text("Read Aloud")) {
            Button {
                viewModel.firstLanguage.readAloud(viewModel.firstLanguage.read("100"))
            } label: {
                Image(systemName: symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .frame(height: 23)
                    .padding(.bottom, 5)
                    .padding(.leading, noVoice ? 0 : 5)
                    .frame(height: 23)
                    .padding(.top, 10)
            }
            .disabled(noVoice)
            HStack {
                Text("Read Aloud")
                Spacer()
                Toggle("", isOn: $viewModel.persistent.offerReadingAloud)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 10)
            }
            NavigationLink {
                VoiceSelection(viewModel: viewModel)
            } label: {
                Text("Select Voices")
            }
            .disabled(!viewModel.persistent.offerReadingAloud)
        }
    }
    
    struct SettingsHeader: View {
        let flagName: String
        let text: String
        var body: some View {
                HStack {
                    Image(flagName)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(.white)
                        .frame(height: 25)
                        .padding(.trailing, 5)
                    Text(text)
                        .bold()
                        .frame(height: 25)
                        .foregroundColor(.yellow)
                    Spacer()
                }
                .padding(.top, 15)
        }
    }
    
    var LanguageSettings: some View {
        let english = viewModel.languages.english
        let german = viewModel.languages.german
        let spanish = viewModel.languages.spanish
        let vietnamese = viewModel.languages.vietnamese

        return Section(header: Text("Language Settings")) {
            SettingsHeader(flagName: english.flagName, text: english.read(150))
            HStack {
                Text("use \"and\"")
                Spacer()
                Toggle("", isOn: $viewModel.languages.english.useAndAfterHundred)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 10)
            }
            SettingsHeader(
                flagName: german.flagName,
                text: german.read(88) + (german.useWordSplitter ? " +splitter" : ""))
            HStack {
                Text("Trennung")
                Spacer()
                Toggle("", isOn: $viewModel.languages.german.useWordSplitter)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 10)
            }
            HStack {
                Text("Großschreibung")
                Spacer()
                Toggle("", isOn: $viewModel.languages.german.capitalisation)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 10)
            }
            SettingsHeader(flagName: spanish.flagName, text: spanish.read("1.5"))
            HStack {
                Text("Coma o punto:")
                Spacer()
                Picker("", selection: $viewModel.languages.spanish.puntoComma) {
                    ForEach(SpanishImpl.PuntoComma.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .pickerStyle(.segmented)
            }
            SettingsHeader(flagName: vietnamese.flagName, text: vietnamese.read(33303))
            HStack {
                Text("1000")
                Spacer()
                Picker("", selection: $viewModel.languages.vietnamese.thousand) {
                    ForEach(VietnameseImpl.Thousand.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .pickerStyle(.segmented)
            }
            HStack {
                Text("linh hoặc lẻ")
                Spacer()
                Picker("", selection: $viewModel.languages.vietnamese.secondLast) {
                    ForEach(VietnameseImpl.SecondLast.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .pickerStyle(.segmented)
            }
            HStack {
                Text("gọn")
                Spacer()
                Toggle("", isOn: $viewModel.languages.vietnamese.compact)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.trailing, 10)
            }
        }
    }
    
    
    var HobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return Section(header: Text("About")) {
//            VStack(alignment: .leading) {
                Text("Version: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
                    .italic()
                    .padding(.bottom, 3)
                Text("This is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. If you have feedback, for example a wrong translations or ideas for improvement, drop me an email at joachim@joachimneumann.com").tint(.white)
//            }
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

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func borderRadius<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, corners: UIRectCorner) -> some View where S : ShapeStyle {
        let roundedRect = RoundedCorner(radius: cornerRadius, corners: corners)
        return clipShape(roundedRect)
            .overlay(roundedRect.stroke(content, lineWidth: width))
    }
}
