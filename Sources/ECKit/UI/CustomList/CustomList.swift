import SwiftUI

public struct CustomList<Content: View>: View {

    @ViewBuilder let content: () -> Content

    @Environment(\.colorScheme) private var colorScheme

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    private var background: Color {
        switch colorScheme {
        case .dark:
            return .systemBackground
        case .light:
            return .secondarySystemBackground
        @unknown default:
            return .secondarySystemBackground
        }
    }

    public var body: some View {
        ScrollView {
            VStack {
                content()
                    .maxWidth(.infinity)
                    .maxHeight(.infinity)
            }
            .padding(.vertical)
        }
        .background(background)
    }
}
