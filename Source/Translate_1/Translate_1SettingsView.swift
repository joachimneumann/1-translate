//
//  Translate_1SettingsView.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/13/22.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

struct Translate_1SettingsView: View {
    @Environment(\.presentationMode) var presentation /// for dismissing the Settings View
    @ObservedObject var viewModel: Translate_1ViewModel
    let languageEnum: NumberTranslator.LanguageEnum
    let exampleFont: UIFont
    let grayToggleStyle = ColoredToggleStyle(onColor: Color(white: 0.75),
                                                offColor: Color(white: 0.5),
                                                thumbColor: .white)
    let settingsCalculator: Calculator
    @ObservedObject var settingsDisplay: Display
    
    @State var settingsShowGrouping: Bool
    @State var groupingExampleString = "12000"
    
    func updateGroupingExampleString(grouping: Bool) {
        groupingExampleString = "12000"
        let gr: Character?
        let s = viewModel.separatorCharacter(forLanguage: languageEnum)
        if s == "." {
            gr = settingsShowGrouping ? "," : nil
        } else {
            gr = settingsShowGrouping ? "." : nil
        }
        inject(into: &groupingExampleString, separatorCharacter: s, groupingCharacter: gr)
    }
    
    init(viewModel: Translate_1ViewModel) {
        self.viewModel = viewModel
        self.languageEnum = viewModel.persistent.currentLanguageEnum
        self.exampleFont = viewModel.screen.numberDisplayFont
        self.settingsCalculator = Calculator(precision: 20)
        self.settingsDisplay = Display(floatDisplayWidth: viewModel.screen.displayWidth, font: viewModel.screen.numberDisplayFont, ePadding: 0.0)
        settingsShowGrouping = viewModel.persistent.showGrouping
    }
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
                //                if viewModel.translate_1Manager.code(language) != nil {
                //                    VoiceSettings(language)
                //                }
                HobbyProject
                    .listRowBackground(Color(UIColor.darkGray))
            }
            .onAppear() {
                updateGroupingExampleString(grouping: viewModel.persistent.showGrouping)
            }
        }
        .onDisappear {
            viewModel.persistent.showGrouping = settingsShowGrouping
            viewModel.process()
        }
    }
    
    var GeneralSettings: some View {
        return Section(header:
            Text("Settings")
            .fontWeight(.semibold)
            .foregroundColor(.white)) {
                VStack {
                    HStack {
                        Spacer()
                        Text(groupingExampleString)
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                            .gridCellColumns(2)
                            .padding(.bottom, 5)
                    }
                    HStack {
                        Text("Show Grouping")
                        Spacer()
                        Toggle("", isOn: $settingsShowGrouping)
                            .frame(width: 40)
                            .toggleStyle(grayToggleStyle)
                            .buttonStyle(.plain)
                            .padding(.trailing, 10)
                    }
                }
        }
            .onChange(of: settingsShowGrouping) { oldValue, newValue in
                updateGroupingExampleString(grouping: newValue)
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
        let translate_1Result: Translate_1Result
        let uiFont: UIFont
        var content: () -> Content
        init(languageEnum: NumberTranslator.LanguageEnum,
             example: String,
             translate_1Manager: Translate_1Manager,
             uiFont: UIFont,
             @ViewBuilder content: @escaping () -> Content) {
            self.flagname = translate_1Manager.flagname(languageEnum)
            self.name = translate_1Manager.name(languageEnum)
            self.example = example
            self.uiFont = uiFont
            translate_1Manager.translateThis(example, to: languageEnum)
            self.translate_1Result = translate_1Manager.result
            self.content = content
        }
        
        var body: some View {
            let borderwidth: CGFloat = 2.0
            let height: CGFloat = 20.0
            let width: CGFloat = 30.0
            Section(header: HStack {
                Image(flagname)
                    .resizable()
                    .frame(width: width-2*borderwidth, height: height-2*borderwidth)
                    .clipShape(Capsule())
                    .padding(0.5*borderwidth)
                    .overlay(
                        Capsule()
                            .stroke(.gray, lineWidth: borderwidth)
                    )
                    .padding(0.5*borderwidth)
                    .padding(.trailing, 3)
                Text(name)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }) {
                    HStack {
                        Text("\(example) →")
                        Translate_1Display(uiFont: uiFont, translate_1Result: translate_1Result)
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
            HStack {
                Text("\"and\" after hundred")
                Spacer()
                Toggle("", isOn: $viewModel.translate_1Manager.englishUseAndAfterHundred)
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Großschreibung")
                    Spacer()
                    Toggle("", isOn: $viewModel.translate_1Manager.germanCapitalisation)
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("1000")
                        Spacer(minLength: 0.0)
                        Picker("", selection: $viewModel.translate_1Manager.vietnameseThousand) {
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
                        Picker("", selection: $viewModel.translate_1Manager.vietnameseSecondLast) {
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
                    Toggle("", isOn: $viewModel.translate_1Manager.vietnameseCompact)
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Empty column (after 400 BC)")
                    Spacer()
                    Toggle("", isOn: $viewModel.translate_1Manager.babylonianAllowEmptyColumn)
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Coma o punto:")
                    Spacer()
                    Picker("", selection: $viewModel.translate_1Manager.spanishPuntoComa) {
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
                               translate_1Manager: viewModel.translate_1Manager,
                               uiFont: viewModel.screen.infoUiFont) {
                HStack {
                    Text("Use vinculum (overline):")
                    Spacer()
                    Toggle("", isOn: $viewModel.translate_1Manager.romanNumeralsUseVinculum)
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
            Translate_1SettingsView(viewModel: Translate_1ViewModel())
                .scrollContentBackground(.hidden)
                .background(.black)
        }
    }
}
