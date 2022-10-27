import SwiftUI

// https://pspdfkit.com/blog/2022/presenting-popovers-on-iphone-with-swiftui/
public extension View {
    func alwaysPopover<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(AlwaysPopoverModifier(isPresented: isPresented, content: content))
    }
}

struct AlwaysPopoverModifier<PopoverContent>: ViewModifier where PopoverContent: View {
    
    let isPresented: Binding<Bool>
    let content: () -> PopoverContent
    
    // Workaround for missing @StateObject in iOS 13.
    private struct Store {
        var anchorView = UIView()
    }
    @State private var store = Store()
    
    func body(content: Content) -> some View {
        if isPresented.wrappedValue {
            presentPopover()
        }
        
        return content.background(InternalAnchorView(view: store.anchorView))
    }
    
    private func presentPopover() {
        let contentController = ContentViewController(rootView: content(), isPresented: isPresented)
        contentController.modalPresentationStyle = .popover
        
        let view = store.anchorView
        guard let popover = contentController.popoverPresentationController else { return }
        popover.sourceView = view
        popover.sourceRect = view.bounds
        popover.delegate = contentController
        
        guard let sourceVC = view.closestVC() else { return }
        if let presentedVC = sourceVC.presentedViewController {
            presentedVC.dismiss(animated: true) {
                sourceVC.present(contentController, animated: true)
            }
        } else {
            sourceVC.present(contentController, animated: true)
        }
    }
    
    private struct InternalAnchorView: UIViewRepresentable {
        let view: UIView
        func makeUIView(context: Self.Context) -> UIView { view }
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
}
