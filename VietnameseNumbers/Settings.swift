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
        var vietnamese = Vietnamese(screen: screen)
        VStack {
            BackButton(
                screen: screen,
                font: font,
                presentationMode: presentation)
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    Grid(alignment: .leading, horizontalSpacing: 20.0, verticalSpacing: 10.0) {
                        GridRow {
                            Text("\(example)")
                                .foregroundColor(.white)
                                .padding(.leading, 0)
                                .font(.title)
                                .gridCellColumns(2)
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
                            .pickerStyle(.segmented)
                        }
                        .padding(.bottom, 20.0)
                        GridRow {
                            Text("103133 trong tiếng việt = \n" + vietnamese.toString(103133)!)
                                .foregroundColor(.white)
                                .padding(.leading, 0)
//                                .font(.title)
                                .gridCellColumns(2)
                        }
                        GridRow {
                            Picker("", selection: $vietnameseThousand) {
                                ForEach(VietnameseThousand.allCases, id: \.self) { value in
                                    Text("\(value.rawValue)")
                                        .tag(value)
                                }
                            }
                            .padding(2)
                            .background(Color(UIColor.darkGray))
                            .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                            .onChange(of: vietnameseThousand) { _ in
                                if vietnameseThousand == .ngàn {
                                    vietnameseThousand = .nghìn
                                } else {
                                    vietnameseThousand = .ngàn
                                }
                                if screen.vietnameseThousand != vietnameseThousand {
                                    screen.vietnameseThousand = vietnameseThousand
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        GridRow {
                            Picker("", selection: $vietnameseSecondLast) {
                                ForEach(VietnameseSecondLast.allCases, id: \.self) { value in
                                    Text("\(value.rawValue)")
                                        .tag(value)
                                }
                            }
                            .padding(2)
                            .background(Color(UIColor.darkGray))
                            .borderRadius(Color.black, width: 5, cornerRadius: 10, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                            .onChange(of: vietnameseSecondLast) { _ in
                                if vietnameseSecondLast == .linh {
                                    vietnameseSecondLast = .lẻ
                                } else {
                                    vietnameseSecondLast = .linh
                                }
                                if screen.vietnameseSecondLast != vietnameseSecondLast {
                                    screen.vietnameseSecondLast = vietnameseSecondLast
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        GridRow {
                            HStack {
                                Text("Compact")
                                Toggle("", isOn: $vietnameseCompact)
                                    .toggleStyle(
                                        ColoredToggleStyle(onColor: Color(white: 0.6),
                                                           offColor: Color(white: 0.25),
                                                           thumbColor: .white))
                                    .onChange(of: vietnameseCompact) { _ in
                                        if screen.vietnameseCompact != vietnameseCompact {
                                            screen.vietnameseCompact = vietnameseCompact
                                            // hack to make swiftui redraw and show the compact translation
                                            vietnamese = Vietnamese(screen: screen)
                                            print("Settings -> " + (vietnameseCompact ? "true" : "false"))
                                        }
                                    }
                                    .pickerStyle(.segmented)
                            }
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
                if screen.decimalSeparator != settingsDecimalSeparator {
                    screen.decimalSeparator = settingsDecimalSeparator
                }
                if screen.groupingSeparator != settingsGroupingSeparator {
                    screen.groupingSeparator = settingsGroupingSeparator
                }
            }
        }
        .onAppear() {
            settingsDecimalSeparator  = screen.decimalSeparator
            settingsGroupingSeparator = screen.groupingSeparator
            vietnameseThousand        = screen.vietnameseThousand
            vietnameseSecondLast      = screen.vietnameseSecondLast
            vietnameseCompact         = screen.vietnameseCompact
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
