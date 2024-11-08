//
//  SettingsView.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

struct SettingsView: View {
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    @ObservedObject var viewModel: ViewModel
    let languageEnum: NumberTranslator.LanguageEnum
    let exampleFont: UIFont
    let grayToggleStyle = ColoredToggleStyle(onColor: Color(white: 0.75),
                                                offColor: Color(white: 0.5),
                                                thumbColor: .white)
    var body: some View {
        VStack {
            List {
                GeneralSettings
                    .listRowBackground(Color(UIColor.darkGray))
                switch languageEnum {
                case .babylonian:
                    BabylonianParameters
                        .listRowBackground(Color(white: 0.25))
                case .english:
                    EnglishParameters
                        .listRowBackground(Color(white: 0.25))
                case .german:
                    GermanParameters
                        .listRowBackground(Color(white: 0.25))
                case .romanNumerals:
                    RomanNumeralsParameters
                        .listRowBackground(Color(white: 0.25))
                case .spanish:
                    SpanishParameters
                        .listRowBackground(Color(white: 0.25))
                case .vietnamese:
                    VietnameseParameters
                        .listRowBackground(Color(white: 0.25))
                default:
                    EmptyView()
                }
                //                if viewModel.translationManager.code(language) != nil {
                //                    VoiceSettings(language)
                //                }
                HobbyProject
                    .listRowBackground(Color(UIColor.darkGray))
            }
        }
        .onDisappear {
//            viewModel.process()
        }
    }
    
    var GeneralSettings: some View {
        viewModel.calculator.evaluateString("120000.5")
        let raw = viewModel.calculator.raw
//        calculator.display = Display(floatDisplayWidth: 1000, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
        viewModel.display.separatorCharacter = viewModel.separatorCharacter(forLanguage: languageEnum)
        viewModel.display.update(raw: raw)
        return Section(header:
            Text("Settings")
            .fontWeight(.semibold)
            .foregroundColor(.white)) {
                VStack {
                    HStack {
                        Spacer()
                        Text(viewModel.display.string)
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                            .gridCellColumns(2)
                            .padding(.bottom, 5)
                    }
                    HStack {
                        Text("Show Grouping")
                        Spacer()
                        Toggle("", isOn: $viewModel.persistent.showGrouping)
                            .frame(width: 40)
                            .toggleStyle(grayToggleStyle)
                            .buttonStyle(.plain)
                            .padding(.trailing, 10)
                    }
                }
        }
    }
    //        let calculator = Calculator(precision: 100)
    //        calculator.evaluateString("120000.5")
    //        let raw = calculator.raw
    //        let display = Display(floatDisplayWidth: 1000, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
    //        calculator.separator = viewModel.separator(forLanguage: language)
    //        display.update(raw: raw, separator: calculator.separator)
    //        return Section(header: Text("Separators")) {
    //            VStack {
    //                Text(display.string)
    //                    .foregroundColor(.yellow)
    //                    .font(.largeTitle)
    //                    .gridCellColumns(2)
    //                    .padding(.bottom, 5)
    //                HStack {
    //                    Text("Grouping")
    //                        .padding(.trailing, 5)
    //                    Toggle("", isOn: $viewModel.persistent.showGrouping)
    //                        .frame(width: 40)
    //                        .toggleStyle(grayToggleStyle)
    //                        .buttonStyle(.plain)
    //                        .padding(.trailing, 10)
    //                }
    //                .padding(.bottom, 5)
    //            }
    //        }
    //    }
    
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
    //                        .toggleStyle(grayToggleStyle)
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
        let flagname: String
        let name: String
        let example: String
        let translationResult: TranslationResult
        let uiFont: UIFont
        var content: () -> Content
        init(languageEnum: NumberTranslator.LanguageEnum,
             example: String,
             translationManager: TranslationManager,
             uiFont: UIFont,
             @ViewBuilder content: @escaping () -> Content) {
            self.flagname = translationManager.flagname(languageEnum)
            self.name = translationManager.name(languageEnum)
            self.example = example
            self.uiFont = uiFont
            translationManager.translateThis(example, to: languageEnum)
            self.translationResult = translationManager.result
            self.content = content
        }
        
        var body: some View {
            Section(header: HStack {
                Image(flagname)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .clipShape(Capsule())
                    .padding(.trailing, 3)
                Text(name)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }) {
                    HStack {
                        Text("\(example) →")
                        TranslatedDisplay(uiFont: uiFont, translationResult: translationResult)
                            .fontWeight(.semibold)
                            .frame(height: 40)
                            .foregroundColor(.orange)
                            .foregroundColor(.white)
                    }
                    content()
                }
        }
    }
    
    var EnglishParameters: some View {
        return LanguageSection(languageEnum: .english,
                               example: "150",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
            HStack {
                Text("\"and\" after hundred")
                Spacer()
                Toggle("", isOn: $viewModel.translationManager.englishUseAndAfterHundred)
                    .frame(width: 40)
                    .toggleStyle(grayToggleStyle)
                    .buttonStyle(.plain)
                    .padding(.trailing, 10)
            }
        }
    }
    
    
    var GermanParameters: some View {
        return LanguageSection(languageEnum: .german,
                               example: "88",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Großschreibung")
                    Spacer()
                    Toggle("", isOn: $viewModel.translationManager.germanCapitalisation)
                        .frame(width: 40)
                        .toggleStyle(grayToggleStyle)
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    var VietnameseParameters: some View {
        return LanguageSection(languageEnum: .vietnamese,
                               example: "33303",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("1000")
                        Spacer(minLength: 0.0)
                        Picker("", selection: $viewModel.translationManager.vietnameseThousand) {
                            ForEach(NumberTranslator.VietnameseThousand.allCases, id: \.self) { value in
                                Text("\(value.rawValue)")
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom, 5)
                        .frame(maxWidth: 150)
                    }
                    GridRow {
                        Text("Linh hoặc lẻ")
                        Spacer(minLength: 0.0)
                        Picker("", selection: $viewModel.translationManager.vietnameseSecondLast) {
                            ForEach(NumberTranslator.VietnameseSecondLast.allCases, id: \.self) { value in
                                Text("\(value.rawValue)")
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 150)
                    }
                }
                HStack {
                    Text("Ngắn gọn")
                    Spacer()
                    Toggle("", isOn: $viewModel.translationManager.vietnameseCompact)
                        .frame(width: 40)
                        .toggleStyle(grayToggleStyle)
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    var BabylonianParameters: some View {
        return LanguageSection(languageEnum: .babylonian,
                               example: "3601",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Empty column (after 400 BC)")
                    Spacer()
                    Toggle("", isOn: $viewModel.translationManager.babylonianAllowEmptyColumn)
                        .frame(width: 40)
                        .toggleStyle(grayToggleStyle)
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    
    var SpanishParameters: some View {
        return LanguageSection(languageEnum: .spanish,
                               example: "1.5",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Coma o punto:")
                    Spacer()
                    Picker("", selection: $viewModel.translationManager.spanishPuntoComa) {
                        ForEach(NumberTranslator.SpanishPuntoComa.allCases, id: \.self) { value in
                            Text("\(value.rawValue)")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 150)
                }
            }
    }

    
    
    var RomanNumeralsParameters: some View {
        return LanguageSection(languageEnum: .romanNumerals,
                               example: "10000",
                               translationManager: viewModel.translationManager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Use vinculum (overline):")
                    Spacer()
                    Toggle("", isOn: $viewModel.translationManager.romanNumeralsUseVinculum)
                        .frame(width: 40)
                        .toggleStyle(grayToggleStyle)
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                }
            }
    }
    
    
    
    var HobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return Section() {
            Text("Version: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
                .italic()
                .padding(.bottom, 3)
            Text("This is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. If find a wrong translation or have ideas for improvement you can add or correct the test data in the folder Tests/Groundtruth of this git repository:")
            Text("[Translator Repository](https://github.com/joachimneumann/NumberTranslator)").tint(.white).underline()
            Text("The calculator is also open source and can be found here:")
            Text("[Calculator Repository](https://github.com/joachimneumann/1-translate)").tint(.white).underline()
            Text("You can also just drop me an email at")
            Link("joachim@joachimneumann.com", destination: URL(string: "mailto:joachim@joachimneumann.com")!).tint(.white).underline()
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
            .foregroundColor(.yellow)
            .background(.black)
        VStack {
            SettingsView(viewModel: ViewModel(), languageEnum: .vietnamese, exampleFont: Screen().infoUiFont)
                .scrollContentBackground(.hidden)
                .background(.black)
        }
    }
}
