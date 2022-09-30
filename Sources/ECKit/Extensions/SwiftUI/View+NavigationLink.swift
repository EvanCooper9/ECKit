import SwiftUI

public extension View {
    func withNavigationLink<Destination: View>(@ViewBuilder to destination: () -> Destination) -> some View {
        NavigationLink {
            destination()
        } label: {
            self
        }
    }
}
