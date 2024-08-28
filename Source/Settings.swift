//
//  Settings.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI
import NumberTranslator

struct Settings: View {
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    
    @Bindable var viewModel: ViewModel
    let font: Font
    let yellow = Color(red: 242.0/255.0, green: 203.0/255.0, blue: 48.0/255.0)
    
    var body: some View {
        VStack {
            List {
                DigitsSettings
                if viewModel.translator.name == "English" {
                    EnglishParameters
                }
                if viewModel.translator.name == "Deutsch" {
                    GermanParameters
                }
                if viewModel.translator.name == "Español" {
                    SpanishParameters
                }
                if viewModel.translator.name == "Babylonian" {
                    BabylonianParameters
                }
                if viewModel.translator.name == "Tiếng Việt" {
                    VietnameseParameters
                }
                if viewModel.translator.code != nil {
                    VoiceSettings
                }
                HobbyProject
            }
        }
        .onDisappear() {
            viewModel.refreshDisplay()
        }
    }
    
    var DigitsSettings: some View {
        let example =  Display(left: "").withSeparators(numberString: "120000.5", isNegative: false, separators: viewModel.persistent, groupSize: viewModel.translator.groupSize)
        return Section(header: Text("Separators")) {
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
                .padding(.bottom, 5)
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
                .padding(.bottom, 5)
            }
        }
    }
    
    func updateSelectedVoice(reducedIdentifier: String, for code: String) {
        viewModel.voices.updateSelectedVoice(reducedIdentifier: reducedIdentifier, for: code, languageList: viewModel.languages.list)
    }
    
    var VoiceSettings: some View {
        return Section(header: Text("Read Aloud")) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Offer to read aloud")
                    Spacer()
                    Toggle("", isOn: $viewModel.persistent.offerReadingAloud)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            VStack(alignment: .leading) {
                NavigationLink {
                    VoiceSelection(viewModel: viewModel, code: viewModel.translator.code!, callback: updateSelectedVoice)
                } label: {
                    Text("Select Voice")
                }
                .disabled(!viewModel.persistent.offerReadingAloud)
            }
        }
    }
    
    struct LanguageSection <Content: View>: View {
        let language: Language
        let example: String
        var content: () -> Content
        init(language: Language,
             example: String,
             @ViewBuilder content: @escaping () -> Content) {
            self.language = language
            self.example = example
            self.content = content
        }
        
        var body: some View {
            Section(header: HStack {
                Image(language.flagName)
                    .resizable()
                    .scaledToFit()
                    .padding(1)
                    .border(.white)
                    .frame(height: 13)
                    .padding(.trailing, 3)
                Text(language.nameWithDescription) }) {
                    Text(example + ": " + language.translator.translate(example))
                        .fontWeight(.semibold)
                        .frame(height: 25)
                        .foregroundColor(.yellow)
                    content()
                }
        }
    }
    
    var EnglishParameters: some View {
        return LanguageSection(
            language: viewModel.languages.language,
            example: "150") {
                HStack {
                    Text("\"and\" after hundred")
                    Spacer()
                    Toggle("", isOn: $viewModel.translator.englishUseAndAfterHundred)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    
    var GermanParameters: some View {
        return LanguageSection(
            language: viewModel.languages.language,
            example: "88") {
                HStack {
                    Text("Großschreibung")
                    Spacer()
                    Toggle("", isOn: $viewModel.translator.germanCapitalisation)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    var BabylonianParameters: some View {
        return LanguageSection(
            language: viewModel.languages.language,
            example: "3601") {
                HStack {
                    Text("Empty column")
                    Spacer()
                    Toggle("", isOn: $viewModel.translator.babylonianAllowEmptyColumn)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }

    
    var SpanishParameters: some View {
        return LanguageSection(
            language: viewModel.languages.language,
            example: "1.5") {
                HStack {
                    Text("Coma o punto:")
                    Spacer()
                    Picker("", selection: $viewModel.translator.puntoComma) {
                        ForEach(Translator.SpanishPuntoComma.allCases, id: \.self) { value in
                            Text("\(value.rawValue)")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
    }
    
    var VietnameseParameters: some View {
        return LanguageSection(
            language: viewModel.languages.language,
            example: "33303") {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("1000")
                        Picker("", selection: $viewModel.translator.vietnameseThousand) {
                            ForEach(Translator.VietnameseThousand.allCases, id: \.self) { value in
                                Text("\(value.rawValue)")
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom, 5)
                    }
                    GridRow {
                        Text("Linh hoặc lẻ")
                        Picker("", selection: $viewModel.translator.vietnameseSecondLast) {
                            ForEach(Translator.VietnameseSecondLast.allCases, id: \.self) { value in
                                Text("\(value.rawValue)")
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                HStack {
                    Text("Ngắn gọn")
                    Spacer()
                    Toggle("", isOn: $viewModel.translator.vietnameseCompact)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
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
            Text("This is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. If you have feedback, for example a wrong translations or ideas for improvement, drop me an email or, even better, look at existing tests and file a bug in the Testing Repository:").tint(.white)
            Link("Write email", destination: URL(string: "mailto:joachim@joachimneumann.com")!).tint(.yellow)
            Text("[Open Testing Repository](https://github.com/joachimneumann/1-translate-tests)").tint(.yellow)
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
