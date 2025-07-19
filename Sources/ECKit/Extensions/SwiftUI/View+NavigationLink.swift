import SwiftUI

public extension View {
    func withNavigationLink<Destination: View>(@ViewBuilder to destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(destination: destination))
    }
}

struct NavigationLinkModifier<Destination: View>: ViewModifier {

    let destination: () -> Destination

    func body(content: Content) -> some View {
        NavigationLink {
            destination()
        } label: {
            content
        }
    }
}
