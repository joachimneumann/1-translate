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
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    Grid(alignment: .leading, horizontalSpacing: 10.0, verticalSpacing: 10.0) {
                        DigitsSettings
                        VoiceSettings
                        EnglishSettings
                        GermanSettings
                        SpanishSettings
                        VietnameseSettings
                    }
                    HobbyProject
                    Spacer()
                }
                .padding(.top, 10)
                .foregroundColor(Color.white)
                .padding(.horizontal, 15)
            }
            .padding(.top, 10)
        }
        .navigationTitle("Settings")
    }
    
    var DigitsSettings: some View {
        let example =  Display(left: "").withSeparators(numberString: "10000.05", isNegative: false, separators: viewModel.persistent)
        return Group {
            GridRow {
                Text("\(example)")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
                    .gridCellColumns(2)
            }
            GridRow {
                Text("Decimal")
                Picker("", selection: $viewModel.persistent.decimalSeparator) {
                    ForEach(DecimalSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .padding(2)
                .frame(width: 220)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .pickerStyle(.segmented)
            }
            GridRow {
                Text("Grouping")
                Picker("", selection: $viewModel.persistent.groupSeparator) {
                    ForEach(GroupSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: .allCorners)
                .frame(width: 220)
                .pickerStyle(.segmented)
            }
            GridRow {
                Text("GroupSize")
                Picker("", selection: $viewModel.persistent.groupSize) {
                    ForEach(GroupSize.allCases, id: \.self) { value in
                        Text("\(value.string)")
                            .tag(value)
                    }
                }
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: .allCorners)
                .frame(width: 150)
                .pickerStyle(.segmented)
            }
        }
    }
    
    var VoiceSettings: some View {
        let noVoice = !viewModel.persistent.offerReadingAloud
        let color =  noVoice ? yellow.opacity(0.7) : yellow
        let symbolName = noVoice ? "speaker.slash.fill" : "speaker.wave.3.fill"
        let symbolSize: CGFloat = noVoice ? 23.0 : 18.0
        return Group {
            Button {
                viewModel.firstLanguage.readAloud(viewModel.firstLanguage.read("100"))
            } label: {
                Image(systemName: symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .frame(height: symbolSize)
                    .padding(.bottom, 5)
                    .frame(height: 23)
                    .padding(.top, 40)
            }
            .disabled(noVoice)
            GridRow {
                Text("Read Aloud")
                Toggle("", isOn: $viewModel.persistent.offerReadingAloud)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
            NavigationLink {
                VoiceSelection(viewModel: viewModel)
            } label: {
                Text("Select Voices")
                Image(systemName: "chevron.right")
                    .padding(.leading, 15)
            }
            .foregroundColor(viewModel.persistent.offerReadingAloud ? .white : .gray)
            
            .disabled(!viewModel.persistent.offerReadingAloud)
            .padding(.top, 5)
        }
    }
    
    struct SettingsHeader: View {
        let flagName: String
        let text: String
        var body: some View {
            GridRow {
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
                .gridCellColumns(2)
                .padding(.top, 40)
            }
        }
    }
    
    var EnglishSettings: some View {
        let english = viewModel.languages.english
        let example =  english.read(150)
        return Group {
            SettingsHeader(flagName: english.flagName, text: example)
            GridRow {
                Text("use \"and\"")
                Toggle("", isOn: $viewModel.languages.english.useAndAfterHundred)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
        }
    }
    
    var GermanSettings: some View {
        let german = viewModel.languages.german
        let example =  german.read(88) + (german.useWordSplitter ? " (with word splitter)" : "")
        return Group {
            SettingsHeader(flagName: german.flagName, text: example)
            GridRow {
                Text("Trennung")
                Toggle("", isOn: $viewModel.languages.german.useWordSplitter)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
            GridRow {
                Text("Großschreibung")
                Toggle("", isOn: $viewModel.languages.german.capitalisation)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
        }
    }
    
    var SpanishSettings: some View {
        let spanish = viewModel.languages.spanish
        let example = spanish.read("1.5")
        
        return Group {
            SettingsHeader(flagName: spanish.flagName, text: example)
            GridRow {
                Text("Coma o punto")
                Picker("", selection: $viewModel.languages.spanish.puntoComma) {
                    ForEach(SpanishImpl.PuntoComma.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .frame(width: 220)
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .pickerStyle(.segmented)
            }
        }
    }
    
    var VietnameseSettings: some View {
        let vietnamese = viewModel.languages.vietnamese
        let example = vietnamese.read(33303)
        return Group {
            SettingsHeader(flagName: vietnamese.flagName, text: example)
            GridRow {
                Text("1000")
                Picker("", selection: $viewModel.languages.vietnamese.thousand) {
                    ForEach(VietnameseImpl.Thousand.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .frame(width: 220)
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .pickerStyle(.segmented)
            }
            GridRow {
                Text("linh hoặc lẻ")
                Picker("", selection: $viewModel.languages.vietnamese.secondLast) {
                    ForEach(VietnameseImpl.SecondLast.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .frame(width: 220)
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .pickerStyle(.segmented)
            }
            GridRow {
                Text("gọn")
                Toggle("", isOn: $viewModel.languages.vietnamese.compact)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
        }
    }
    
    
    var HobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return VStack(alignment: .leading) {
            Text("\nVersion: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
                .italic()
                .padding(.bottom, 3)
            Text("This is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. If you have feedback, for example a wrong translations or ideas for improvement, drop me an email at joachim@joachimneumann.com").tint(.white)
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
