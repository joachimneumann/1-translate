////
////  FloatingSheet.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 29.10.2024.
////
//
//import SwiftUI
//
//struct FloatingSheetContentView: View {
//    @State private var showSheet = true
//    @State private var xxx = false
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Text("Calculator Interface")
//                    .foregroundColor(.yellow)
//                    .font(.largeTitle)
//                    .padding()
//
//                Button(action: {
//                    showSheet.toggle()
//                }) {
//                    Image(systemName: "line.horizontal.3")
//                        .font(.title)
//                        .padding()
//                        .foregroundColor(.yellow)
//                }
//            }
////            .background(.black)
//
//            FloatingSheet(isPresented: $showSheet) {
//                VStack(spacing: 16) {
//                    SheetOption(title: "Basic", icon: "function", isSelected: true)
//                    SheetOption(title: "Scientific", icon: "fx", isSelected: false)
//                    SheetOption(title: "Math Notes", icon: "note.text", isSelected: false)
//
//                    Toggle("Convert", isOn: $xxx)
//                        .padding(.horizontal)
//                        .foregroundColor(.white)
//                }
//                .padding()
//                .background(.black)
//            }
//        }
//    }
//}
//
//struct SheetOption: View {
//    let title: String
//    let icon: String
//    let isSelected: Bool
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(isSelected ? .orange : .white)
//
//            Text(title)
//                .foregroundColor(isSelected ? .orange : .white)
//                .fontWeight(.semibold)
//
//            Spacer()
//        }
//        .font(Font.system(size: 20))
//        .padding()
//        .cornerRadius(8)
//    }
//}
//
//struct FloatingSheet<Content: View>: View {
//    @Binding var isPresented: Bool
//    let content: Content
//
//    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
//        self._isPresented = isPresented
//        self.content = content()
//    }
//
//    var body: some View {
//        if isPresented {
//            VStack {
//                Spacer()
//                content
////                    .background(.ultraThinMaterial)
//                    .background(.black.opacity(0.6))
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(16)
//                    .shadow(radius: 10)
//                    .padding(.bottom, 40)
//                    .padding(.leading, 30)
//                    .padding(.trailing, 130)
////                    .frame(width: 260)
//            }
//            .transition(.move(edge: .bottom))
//            .animation(.easeInOut, value: isPresented)
//            .ignoresSafeArea()
//        }
//    }
//}
//
////#Preview {
////    @Previewable @State var x: Bool = false
////    ContentView()
////}
