import SwiftUI

public extension View {
    func embeddedInNavigationView() -> some View {
        NavigationView {
            self
        }
        .navigationViewStyle(.stack)
    }
}
