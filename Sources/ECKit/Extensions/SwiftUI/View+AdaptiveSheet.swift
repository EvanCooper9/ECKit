#if canImport(UIKit)
import SwiftUI
import UIKit

public extension View {
    func adaptiveSheet<T: View>(isPresented: Binding<Bool>, detents : [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> T)-> some View {
        modifier(AdaptiveSheet(isPresented: isPresented, detents : detents, smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier, prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge, prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight, content: content))
    }
}

struct AdaptiveSheet<T: View>: ViewModifier {
    let sheetContent: T
    @Binding var isPresented: Bool
    let detents : [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool

    init(isPresented: Binding<Bool>, detents : [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> T) {
        self.sheetContent = content()
        self.detents = detents
        self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self._isPresented = isPresented
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            CustomSheet_UI(isPresented: $isPresented, detents: detents, smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier, prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge, prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight, content: {sheetContent}).frame(width: 0, height: 0)
        }
    }
}

struct CustomSheet_UI<Content: View>: UIViewControllerRepresentable {

    let content: () -> Content
    @Binding var isPresented: Bool
    let detents : [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool

    init(isPresented: Binding<Bool>, detents : [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.detents = detents
        self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self._isPresented = isPresented
    }

    func makeCoordinator() -> Coordinator { .init(self) }

    func makeUIViewController(context: Context) -> CustomSheetViewController<Content> {
        .init(coordinator: context.coordinator, detents: detents, smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier, prefersScrollingExpandsWhenScrolledToEdge:  prefersScrollingExpandsWhenScrolledToEdge, prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight, content: content)
    }

    func updateUIViewController(_ uiViewController: CustomSheetViewController<Content>, context: Context) {
        uiViewController.content = content
        if isPresented {
            uiViewController.presentModalView()
        } else {
            uiViewController.dismissModalView()
        }
    }

    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var parent: CustomSheet_UI

        init(_ parent: CustomSheet_UI) {
            self.parent = parent
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            guard parent.isPresented else { return }
            parent.isPresented = false
        }
    }
}

class CustomSheetViewController<Content: View>: UIViewController {

    var content: () -> Content {
        didSet {
            guard let presentedViewController = presentedViewController as? UIHostingController<Content> else { return }
            presentedViewController.rootView = content()
        }
    }

    let coordinator: CustomSheet_UI<Content>.Coordinator
    let detents : [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    private var isLandscape: Bool = UIDevice.current.orientation.isLandscape

    init(coordinator: CustomSheet_UI<Content>.Coordinator, detents : [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.coordinator = coordinator
        self.detents = detents
        self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dismissModalView() {
        dismiss(animated: true, completion: nil)
    }

    func presentModalView() {
        guard presentedViewController == nil else { return }
        let hostingController = UIHostingController(rootView: content())
        hostingController.modalPresentationStyle = .popover
        hostingController.presentationController?.delegate = coordinator as UIAdaptivePresentationControllerDelegate
        hostingController.modalTransitionStyle = .coverVertical
        if let hostPopover = hostingController.popoverPresentationController {
            hostPopover.sourceView = super.view
            let sheet = hostPopover.adaptiveSheetPresentationController
            // As of 13 Beta 4 if .medium() is the only detent in landscape error occurs
            sheet.detents = (isLandscape ? [.large()] : detents)
            sheet.largestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
            sheet.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            sheet.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true

        }
        present(hostingController, animated: true, completion: nil)
    }

    /// To compensate for orientation as of 13 Beta 4 only [.large()] works for landscape
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true
            self.presentedViewController?.popoverPresentationController?.adaptiveSheetPresentationController.detents = [.large()]
        } else {
            isLandscape = false
            self.presentedViewController?.popoverPresentationController?.adaptiveSheetPresentationController.detents = detents
        }
    }
}

struct CustomSheetView_Previews: PreviewProvider {

    private struct Preview: View {
        
        @State private var height: CGFloat = 350
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.blue)
                    .padding(.small)
                Button("Change height") {
                    height = .random(in: 200...500)
                }
            }
            .height(height)
        }
    }

    static var previews: some View {
        Text("Preview").adaptiveSheet(isPresented: .constant(true)) {
            Preview()
        }
    }
}
#endif
