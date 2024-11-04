//
//  Settings.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

struct Settings: View {
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    
    @Bindable var viewModel: ViewModel
    let language: NumberTranslator.Language
    
    let font: Font
    let yellow = Color(red: 242.0/255.0, green: 203.0/255.0, blue: 48.0/255.0)
    
    var body: some View {
        VStack {
            List {
                DigitsSettings
//                if language == .english {
//                    EnglishParameters
//                }
//                if language == .german {
//                    GermanParameters
//                }
//                if language == .spanish {
//                    SpanishParameters
//                }
//                if language == .babylonian {
//                    BabylonianParameters
//                }
//                if language == .vietnamese {
//                    VietnameseParameters
//                }
//                if viewModel.translationManager.code(language) != nil {
//                    VoiceSettings(language)
//                }
                HobbyProject
            }
        }
        .onDisappear() {
            viewModel.process()
        }
    }
    
    var DigitsSettings: some View {
        let calculator = Calculator(precision: 100)
        calculator.evaluateString("120000.5")
        let raw = calculator.raw
        let display = Display(floatDisplayWidth: 1000, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
        display.update(raw: raw)
        return Section(header: Text("Separators")) {
            Grid(alignment: .leading, verticalSpacing: 10) {
                GridRow {
                    Text(display.left)
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .gridCellColumns(2)
                        .padding(.bottom, 5)
                }
                GridRow {
                    Text("Decimal Separator")
                        .padding(.trailing, 5)
                    Picker("", selection: $viewModel.persistent.separator.separatorType) {
                        ForEach(Separator.SeparatorType.allCases, id: \.self) { value in
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
                    Toggle("", isOn: $viewModel.persistent.separator.groups)
                        .frame(width: 40)
                        .toggleStyle(
                            ColoredToggleStyle(onColor: Color(white: 0.6),
                                               offColor: Color(white: 0.25),
                                               thumbColor: .white))
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
                .padding(.bottom, 5)
            }
        }
    }
    
//    func updateSelectedVoice(reducedIdentifier: String, for code: String) {
//        viewModel.voices.updateSelectedVoice(reducedIdentifier: reducedIdentifier, for: code)
//    }
    
//    var VoiceSettings: some View {
//        let language: NumberTranslator.Language
//        return Section(header: Text("Read Aloud")) {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Offer to read aloud")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.persistent.offerReadingAloud)
//                        .frame(width: 40)
//                        .toggleStyle(
//                            ColoredToggleStyle(onColor: Color(white: 0.6),
//                                               offColor: Color(white: 0.25),
//                                               thumbColor: .white))
//                        .buttonStyle(.plain)
//                        .padding(.trailing, 10)
//                }
//                .buttonStyle(BorderlessButtonStyle())
//            }
//            VStack(alignment: .leading) {
//                NavigationLink {
//                    VoiceSelection(viewModel: viewModel, code: viewModel.numberTranslator.code!, callback: updateSelectedVoice)
//                } label: {
//                    Text("Select Voice")
//                }
//                .disabled(!viewModel.persistent.offerReadingAloud)
//            }
//        }
//    }
//    
    struct LanguageSection <Content: View>: View {
        let flagName: String
        let name: String
        let example: String
        let translatedExample: TranslationResult
        var content: () -> Content
        init(flagName: String,
             name: String,
             example: String,
             translatedExample: TranslationResult,
             @ViewBuilder content: @escaping () -> Content) {
            self.flagName = flagName
            self.name = name
            self.example = example
            self.translatedExample = translatedExample
            self.content = content
        }
        
        var body: some View {
            Section(header: HStack {
                Image(flagName)
                    .resizable()
                    .scaledToFit()
                    .padding(1)
                    .border(.white)
                    .frame(height: 13)
                    .padding(.trailing, 3)
                Text(name) }) {
                    Text(example + ": " + translatedExample.displayText)
                        .fontWeight(.semibold)
                        .frame(height: 25)
                        .foregroundColor(.yellow)
                    content()
                }
        }
    }
    
//    var EnglishParameters: some View {
//        return LanguageSection(
//            flagName: viewModel.numberTranslator.flagName(.english),
//            name: viewModel.numberTranslator.name(.english),
//            example: "150",
//            translatedExample: viewModel.numberTranslator.getResult("150", to: .english))
//            {
//                Text("\"and\" after hundred")
//                Spacer()
//                Toggle("", isOn: $viewModel.numberTranslator.englishUseAndAfterHundred)
//                    .frame(width: 40)
//                    .toggleStyle(
//                        ColoredToggleStyle(onColor: Color(white: 0.6),
//                                           offColor: Color(white: 0.25),
//                                           thumbColor: .white))
//                    .buttonStyle(.plain)
//                    .padding(.trailing, 10)
//            }
//    }
//    
//    
//    var GermanParameters: some View {
//        return LanguageSection(
//            flagName: viewModel.numberTranslator.flagName(.german),
//            name: viewModel.numberTranslator.name(.german),
//            example: "88",
//            translatedExample: viewModel.numberTranslator.getResult("88", to: .german)) {
//                HStack {
//                    Text("Großschreibung")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.numberTranslator.germanCapitalisation)
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
//    var BabylonianParameters: some View {
//        return LanguageSection(
//            flagName: viewModel.numberTranslator.flagName(.babylonian),
//            name: viewModel.numberTranslator.name(.babylonian),
//            example: "3601",
//            translatedExample: viewModel.numberTranslator.getResult("3601", to: .babylonian)) {
//                HStack {
//                    Text("Empty column")
//                    Spacer()
//                    Toggle("", isOn: $viewModel.numberTranslator.babylonianAllowEmptyColumn)
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
//    var SpanishParameters: some View {
//        return LanguageSection(
//            flagName: viewModel.numberTranslator.flagName(.spanish),
//            name: viewModel.numberTranslator.name(.spanish),
//            example: "1.5",
//            translatedExample: viewModel.numberTranslator.getResult("1.5", to: .spanish)) {
//                HStack {
//                    Text("Coma o punto:")
//                    Spacer()
//                    Picker("", selection: $viewModel.numberTranslator.spanishPuntoComma) {
//                        ForEach(NumberTranslator.SpanishPuntoComma.allCases, id: \.self) { value in
//                            Text("\(value.rawValue)")
//                                .tag(value)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//            }
//    }
//    
//    var VietnameseParameters: some View {
//        return LanguageSection(
//            flagName: viewModel.numberTranslator.flagName(.vietnamese),
//            name: viewModel.numberTranslator.name(.vietnamese),
//            example: "33303",
//            translatedExample: viewModel.numberTranslator.getResult("33303", to: .vietnamese)) {
//                Grid(alignment: .leading) {
//                    GridRow {
//                        Text("1000")
//                        Picker("", selection: $viewModel.numberTranslator.vietnameseThousand) {
//                            ForEach(NumberTranslator.VietnameseThousand.allCases, id: \.self) { value in
//                                Text("\(value.rawValue)")
//                                    .tag(value)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.bottom, 5)
//                    }
//                    GridRow {
//                        Text("Linh hoặc lẻ")
//                        Picker("", selection: $viewModel.numberTranslator.vietnameseSecondLast) {
//                            ForEach(NumberTranslator.VietnameseSecondLast.allCases, id: \.self) { value in
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
//                    Toggle("", isOn: $viewModel.numberTranslator.vietnameseCompact)
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

//struct ControlCenter_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings(
//            viewModel: ViewModel(screen: Screen(CGSize(width: 100, height: 100))),
//            font: Font(viewModel.screen.appleFont(ofSize: 20, weight: .thin)))
//        .background(.black)
//    }
//}

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

#Preview {
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        VStack {
            Settings(viewModel: ViewModel(), language: .spanish, font: Font(AppleFont.systemFont(ofSize: 20)))
        }
    }
}
