import SwiftUI

extension View {
    public func embeddedInNavigationView() -> some View {
        NavigationView {
            self
        }
        .navigationViewStyle(.stack)
    }
}
