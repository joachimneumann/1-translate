//
//  Settings.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    
    @Bindable var viewModel: ViewModel
    let font: Font
    let yellow = Color(red: 242.0/255.0, green: 203.0/255.0, blue: 48.0/255.0)
    
    var body: some View {
        VStack {
            List {
                DigitsSettings
                if viewModel.languages.language.translator.code != nil {
                    VoiceSettings
                }
//                English
//                German
//                Spanish
//                Vietnamese
//                Babylonian
                HobbyProject
            }
        }
        .onDisappear() {
            viewModel.refreshDisplay()
        }
    }
    
    var DigitsSettings: some View {
        let example =  Display(left: "").withSeparators(numberString: "120000.5", isNegative: false, separators: viewModel.persistent, groupSize: 3)
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
        let noVoice = !viewModel.persistent.offerReadingAloud
        let color =  noVoice ? yellow.opacity(0.7) : yellow
        let symbolName = noVoice ? "speaker.slash.fill" : "speaker.wave.3.fill"
        return Section(header: Text("Read Aloud")) {
            VStack(alignment: .leading) {
                let text = viewModel.languages.language.translator.translate("200")
                Button {
                    viewModel.voices.readAloud(text, in: viewModel.languages.language)
                } label: {
                    HStack {
                        Image(systemName: symbolName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 23)
                            .padding(.bottom, 5)
                            .padding(.leading, noVoice ? 0 : 5)
                            .frame(height: 23)
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        Text(text)
                            .padding(.top, 5)
                    }
                    .foregroundColor(color)
                }
                .buttonStyle(.plain)
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
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            VStack(alignment: .leading) {
                NavigationLink {
                    VoiceSelection(code: viewModel.languages.language.translator.code!, voiceDict: viewModel.voices.voiceDict, callback: updateSelectedVoice)
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
                    Text(example + ": " + "language.read(example)")
                        .fontWeight(.semibold)
                        .frame(height: 25)
                        .foregroundColor(.yellow)
                    content()
                }
        }
    }
    
//    var English: some View {
//        return LanguageSection(
//            language: viewModel.languages.english,
//            example: "150") {
//                HStack {
//                    Text("Use \"and\"")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.languages.english.useAndAfterHundred)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .buttonStyle(.plain)
//                        .padding(.trailing, 10)
//                }
//            }
//    }
//    
//    
//    var German: some View {
//        return LanguageSection(
//            language: viewModel.languages.german,
//            example: "88") {
//                HStack {
//                    Text("Großschreibung")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.languages.german.capitalisation)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .buttonStyle(.plain)
//                        .padding(.trailing, 10)
//                }
//            }
//    }
//    
//    
//    var Spanish: some View {
//        return LanguageSection(
//            language: viewModel.languages.spanish,
//            example: "1.5") {
//                HStack {
//                    Text("Coma o punto:")
//                    Spacer()
//                    Picker("", selection: $viewModel.languages.spanish.puntoComma) {
//                        ForEach(SpanishImpl.PuntoComma.allCases, id: \.self) { value in
//                            Text("\(value.rawValue)")
//                                .tag(value)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//            }
//    }
//    
//    var Vietnamese: some View {
//        return LanguageSection(
//            language: viewModel.languages.vietnamese,
//            example: "33303") {
//                Grid(alignment: .leading) {
//                    GridRow {
//                        Text("1000")
//                        Picker("", selection: $viewModel.languages.vietnamese.vietnameseThousand) {
//                            ForEach(VietnameseImpl.VietnameseThousand.allCases, id: \.self) { value in
//                                Text("\(value.rawValue)")
//                                    .tag(value)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.bottom, 5)
//                    }
//                    GridRow {
//                        Text("Linh hoặc lẻ")
//                        Picker("", selection: $viewModel.languages.vietnamese.secondLast) {
//                            ForEach(VietnameseImpl.SecondLast.allCases, id: \.self) { value in
//                                Text("\(value.rawValue)")
//                                    .tag(value)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                    }
//                }
//                HStack {
//                    Text("Ngắn gọn")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.languages.vietnamese.compact)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .buttonStyle(.plain)
//                        .padding(.trailing, 10)
//                }
//            }
//    }
//    
//    var Babylonian: some View {
//        return LanguageSection(
//            language: viewModel.languages.babylonian,
//            example: "3601") {
//                HStack {
//                    Text("Empty column")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.languages.babylonian.babylonianEmptyColumn)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .buttonStyle(.plain)
//                        .padding(.trailing, 10)
//                }
//            }
//    }
    
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
