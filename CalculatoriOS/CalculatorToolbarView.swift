import SwiftUI
import UIKit
import Neumorphic

@available(iOS 27.1, *)
struct CalculatorToolbarView: View {
    let model: ViewModel
    @State private var hasHinge = false
    @State private var showsSettings = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                CalculatoriOSView(model: model)
                    .onAppear {
                        model.updateDimensions(width: geometry.size.width, height: geometry.size.height)
                    }
                    .onChange(of: geometry.size) {
                        model.updateDimensions(width: geometry.size.width, height: geometry.size.height)
                    }
            }
            .background {
                HingeObserver(hasHinge: $hasHinge)
                    .allowsHitTesting(false)
            }
            .onChange(of: hasHinge, initial: true) {
                model.usesSystemToolbar = hasHinge
                model.setWidth()
            }
            .toolbar(hasHinge ? .automatic : .hidden, for: .navigationBar)
            .toolbar {
                if hasHinge {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Settings", systemImage: "gear") {
                            showsSettings = true
                        }
                    }
                    .visibilityPriority(.high)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Copy number", systemImage: "doc.on.doc") {
                            model.execute(model.copyKey)
                        }
                    }
                    .visibilityPriority(.high)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Paste number", systemImage: "clipboard") {
                            model.execute(model.pasteKey)
                        }
                    }
                    .visibilityPriority(.high)
                }
            }
            .tint(Color.Neumorphic.text)
            .sheet(isPresented: $showsSettings) {
                NavigationStack {
                    Form {
                        Toggle("Group digits", isOn: Binding(
                            get: { model.display.groupingCharacter != nil },
                            set: { enabled in
                                model.display.groupingCharacter = enabled
                                    ? (model.display.separatorCharacter == "." ? "," : ".") : nil
                                model.process()
                            }
                        ))
                    }
                    .navigationTitle("Settings")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done", systemImage: "checkmark") {
                                showsSettings = false
                            }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}

// Observe device capability through the view hierarchy instead of a model-name check.
@available(iOS 27.1, *)
private struct HingeObserver: UIViewRepresentable {
    @Binding var hasHinge: Bool

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let binding = $hasHinge
        view.addInteraction(UIHingeInteraction { _, update in
            let available = update.hinge != nil
            DispatchQueue.main.async {
                if binding.wrappedValue != available {
                    binding.wrappedValue = available
                }
            }
        })
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
