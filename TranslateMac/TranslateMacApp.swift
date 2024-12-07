//
//  TranslateMacApp.swift
//  TranslateMac
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

@main
struct FixedSizeMacApp: App {
    let w: CGFloat = 250
    let h: CGFloat = 500
    let model: TranslateViewModel = TranslateViewModel(.macTranslator, width: 250 - 10, height: 500 - 30)
    var body: some Scene {
        WindowGroup {
            TranslateMacView(model: model)
                .frame(width: w, height: h) // Set the fixed size for the content
                .modifier(WindowAccessor { window in
                    // Set window properties
                    window?.styleMask.remove(.resizable) // Disable resizing
                    window?.setFrame(NSRect(x: 400, y: 400, width: w, height: h), display: true)
                })
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("This is a fixed-size Mac app!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
    }
}

struct WindowAccessor: ViewModifier {
    let callback: (NSWindow?) -> Void

    func body(content: Content) -> some View {
        content
            .background(WindowReader(callback: callback)) // Attach a helper to read NSWindow
    }
}

private struct WindowReader: NSViewRepresentable {
    let callback: (NSWindow?) -> Void

    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async {
            self.callback(nsView.window)
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
