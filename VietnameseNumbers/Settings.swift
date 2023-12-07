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
    
    @State var settingsDecimalSeparator: DecimalSeparator = .comma
    @State var settingsGroupingSeparator: GroupingSeparator = .none
    @State var vietnameseThousand: VietnameseThousand = .ngàn
    @State var vietnameseSecondLast: VietnameseSecondLast = .lẻ
    @State var vietnameseCompact: Bool = false

    var body: some View {
        let example = "1\(settingsGroupingSeparator.string)000\(settingsGroupingSeparator.string)000\(settingsDecimalSeparator.string)05"
        VStack {
            BackButton(
                screen: screen,
                font: font,
                presentationMode: presentation)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    Grid(alignment: .leading, horizontalSpacing: 20.0, verticalSpacing: 10.0) {
                        GridRow {
                            HStack {
                                Text("\(example)")
                                    .foregroundColor(.white)
                                    .padding(.leading, 0)
                                    .gridCellColumns(2)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                            }
                        }
                        GridRow {
                            Text("Decimal")
                            Picker("", selection: $settingsDecimalSeparator) {
                                ForEach(DecimalSeparator.allCases, id: \.self) { value in
                                    Text("\(value.rawValue)")
                                        .tag(value)
                                }
                            }
                            .padding(2)
                            .frame(width: 220)
                            .background(Color(UIColor.darkGray))
                            .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
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
                        }
                        GridRow {
                            Text("Grouping")
                            Picker("", selection: $settingsGroupingSeparator) {
                                ForEach(GroupingSeparator.allCases, id: \.self) { value in
                                    Text("\(value.rawValue)")
                                        .tag(value)
                                }
                            }
                            .padding(2)
                            .background(Color(UIColor.darkGray))
                            .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
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
                            .frame(width: 220)
                            .pickerStyle(.segmented)
                        }
                        .padding(.bottom, 40.0)
                        GridRow {
                            let vietnamese = VietnameseTranslator(groupingSeparator: .comma, thousand: vietnameseThousand, secondLast: vietnameseSecondLast, compact: vietnameseCompact)
                            Text(vietnamese.toString(103133)!)
                                .foregroundColor(.white)
                                .padding(.leading, 0)
                                .gridCellColumns(2)
                        }
                        GridRow {
                            Text("1000")
                            Picker("", selection: $vietnameseThousand) {
                                ForEach(VietnameseThousand.allCases, id: \.self) { value in
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
                            Text("1?3")
                            Picker("", selection: $vietnameseSecondLast) {
                                ForEach(VietnameseSecondLast.allCases, id: \.self) { value in
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
                            Text("Compact")
                            Toggle("", isOn: $vietnameseCompact)
                                .frame(width: 40)
                                .toggleStyle(
                                    ColoredToggleStyle(onColor: Color(white: 0.6),
                                                       offColor: Color(white: 0.25),
                                                       thumbColor: .white))
                        }
                    }
                   hobbyProject
                        .padding(.top, 20)
                    
                    Spacer()
                }
                .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .onDisappear() {
                if viewModel.decimalSeparator != settingsDecimalSeparator {
                    viewModel.decimalSeparator = settingsDecimalSeparator
                }
                if viewModel.groupingSeparator != settingsGroupingSeparator {
                    viewModel.groupingSeparator = settingsGroupingSeparator
                }
                if viewModel.vietnameseThousand != vietnameseThousand {
                    viewModel.vietnameseThousand = vietnameseThousand
                }
                if viewModel.vietnameseSecondLast != vietnameseSecondLast {
                    viewModel.vietnameseSecondLast = vietnameseSecondLast
                }
                if viewModel.vietnameseCompact != vietnameseCompact {
                    viewModel.vietnameseCompact = vietnameseCompact
                }
            }
        }
        .onAppear() {
            settingsDecimalSeparator  = viewModel.decimalSeparator
            settingsGroupingSeparator = viewModel.groupingSeparator
            vietnameseThousand        = viewModel.vietnameseThousand
            vietnameseSecondLast      = viewModel.vietnameseSecondLast
            vietnameseCompact         = viewModel.vietnameseCompact
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
            //            .font(font)
            .foregroundColor(.white)
            .padding()
        }
    }
    
    
    var hobbyProject: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return HStack {
            Text("\nVersion: \(appVersion ?? "unknown") (build \(buildNumber ?? "unknown"))")
                .foregroundColor(Color.gray) +
            Text("\nThis is a hobby project by Joachim Neumann. Although I have done some testing, errors may occur. The App is free and will always be free to use. The code is open source and you may add a feature requestion or report a bug at its ")
                .foregroundColor(Color.gray) +
            Text("[github repository](https://github.com/joachimneumann/VietnameseNumbers)")
                .foregroundColor(Color.white)
        }.accentColor(.white)
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
