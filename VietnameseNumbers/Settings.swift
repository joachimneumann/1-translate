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
    
    var body: some View {
        VStack {
            BackButton(
                screen: screen,
                font: font,
                presentationMode: presentation)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    Grid(alignment: .leading, horizontalSpacing: 10.0, verticalSpacing: 10.0) {
                        DigitsSettings
                        EnglishSettings
                        GermanSettings
                        SpanishSettings
                        VietnameseSettings
                        hobbyProject
                    }
                    Spacer()
                }
                .foregroundColor(Color.white)
                .padding(.horizontal, 15)
            }
        }
        .navigationBarBackButtonHidden(true)
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
            .foregroundColor(.white)
            .padding()
        }
    }
    
    var DigitsSettings: some View {
        let example =  "1\(viewModel.groupSeparator.string)000\(viewModel.groupSeparator.string)000\(viewModel.decimalSeparator.string)05"
        return Group {
            GridRow {
                Text("\(example)")
                    .bold()
                    .padding(.leading, 0)
                    .gridCellColumns(2)
            }
            GridRow {
                Text("Decimal")
                Picker("", selection: $viewModel.decimalSeparator) {
                    ForEach(DecimalSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .padding(2)
                .frame(width: 220)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .onChange(of: viewModel.decimalSeparator) { _ in
                    if viewModel.decimalSeparator == .comma {
                        if viewModel.groupSeparator == .comma {
                            viewModel.groupSeparator = .dot
                        }
                    } else if viewModel.decimalSeparator == .dot {
                        if viewModel.groupSeparator == .dot {
                            viewModel.groupSeparator = .comma
                        }
                    }
                }
                .pickerStyle(.segmented)
            }
            GridRow {
                Text("Grouping")
                Picker("", selection: $viewModel.groupSeparator) {
                    ForEach(GroupSeparator.allCases, id: \.self) { value in
                        Text("\(value.rawValue)")
                            .tag(value)
                    }
                }
                .padding(2)
                .background(Color(UIColor.darkGray))
                .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                .onChange(of: viewModel.groupSeparator) { _ in
                    if viewModel.groupSeparator == .comma {
                        if viewModel.decimalSeparator == .comma {
                            viewModel.decimalSeparator = .dot
                        }
                    } else if viewModel.groupSeparator == .dot { /// dot
                        if viewModel.decimalSeparator == .dot { /// also dot
                            viewModel.decimalSeparator = .comma
                        }
                    }
                }
                .frame(width: 220)
                .pickerStyle(.segmented)
            }
        }
    }
    
    var EnglishSettings: some View {
        return Group {
            GridRow {
                HStack {
                    Image(viewModel.english.name)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(.white)
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.english.name)
                        .bold()
                        .frame(height: 25)
                    Spacer()
                }
                .gridCellColumns(2)
            }
            .padding(.top, 40)
            GridRow {
                Text(viewModel.settingsEnglishExample)
                    .padding(.leading, 0)
                    .gridCellColumns(2)
            }
            GridRow {
                Text("use 'and'")
                Toggle("", isOn: $viewModel.settingsEnglishUseAndAfterHundred)
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
        return Group {
            GridRow {
                HStack {
                    Image(viewModel.german.name)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(.white)
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.german.name)
                        .bold()
                        .frame(height: 25)
                    Spacer()
                }
                .gridCellColumns(2)
            }
            .padding(.top, 40)
            GridRow {
                Text(viewModel.settingsGermanExample)
                    .padding(.leading, 0)
                    .gridCellColumns(2)
            }
            GridRow {
                Text("Trennung")
                Toggle("", isOn: $viewModel.settingsGermanSoftHyphen)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
            GridRow {
                Text("Großschreibung")
                Toggle("", isOn: $viewModel.settingsGermanCaptalisation)
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
        return Group {
            GridRow {
                HStack {
                    Image(viewModel.spanish.name)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(.white)
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.spanish.name)
                        .bold()
                        .frame(height: 25)
                    Spacer()
                }
                .gridCellColumns(2)
            }
            .padding(.top, 40)
            GridRow {
                Text(viewModel.settingsSpanishExample)
                    .padding(.leading, 0)
                    .gridCellColumns(2)
            }
            GridRow {
                Text("Coma o punto")
                Picker("", selection: $viewModel.settingsSpanishUsePunto) {
                    ForEach(Spanish.PuntoComma.allCases, id: \.self) { value in
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
        return Group {
            GridRow {
                HStack {
                    Image(viewModel.vietnamese.name)
                        .resizable()
                        .scaledToFit()
                        .padding(1)
                        .border(.white)
                        .frame(height: 25)
                        .padding(.trailing, 10)
                    Text(viewModel.vietnamese.name)
                        .bold()
                        .frame(height: 25)
                    Spacer()
                }
                .padding(.top, 40)
                .gridCellColumns(2)
            }
            GridRow {
                Text(viewModel.settingsVietnameseExample)
                    .padding(.leading, 0)
                    .gridCellColumns(2)
                    .gridCellUnsizedAxes(.horizontal)
            }
            GridRow {
                Text("1000")
                Picker("", selection: $viewModel.settingsVietnameseThousand) {
                    ForEach(Vietnamese.Thousand.allCases, id: \.self) { value in
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
                Picker("", selection: $viewModel.settingsVietnameseSecondLast) {
                    ForEach(Vietnamese.SecondLast.allCases, id: \.self) { value in
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
                Toggle("", isOn: $viewModel.settingsVietnameseCompact)
                    .frame(width: 40)
                    .toggleStyle(
                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                           offColor: Color(white: 0.25),
                                           thumbColor: .white))
                    .padding(.leading, 3)
            }
        }
    }
    
    var hobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return VStack(alignment: .leading) {
            Text("\nVersion: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
                .italic()
                .padding(.bottom, 3)
            Text("This is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur.")
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
