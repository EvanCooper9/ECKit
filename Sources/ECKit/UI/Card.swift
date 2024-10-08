import SwiftUI

public struct Card<Content: View>: View {

    private var axis: Axis
    @ViewBuilder private var content: () -> Content
    private var includeEdgePadding: Bool
    private var horizontalAlignment: HorizontalAlignment
    private var verticalAlignment: VerticalAlignment

    @Environment(\.colorScheme) var colorScheme

    public init(_ axis: Axis = .vertical, includeEdgePadding: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
        self.includeEdgePadding = includeEdgePadding
        self.horizontalAlignment = .center
        self.verticalAlignment = .center
    }

    public init(alignment: HorizontalAlignment, includeEdgePadding: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.axis = .vertical
        self.content = content
        self.includeEdgePadding = includeEdgePadding
        self.horizontalAlignment = alignment
        self.verticalAlignment = .center
    }

    public init(alignment: VerticalAlignment, includeEdgePadding: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.axis = .horizontal
        self.content = content
        self.includeEdgePadding = includeEdgePadding
        self.horizontalAlignment = .center
        self.verticalAlignment = alignment
    }

    public var body: some View {
        mainContent
            .if(includeEdgePadding) { $0.padding() }
            .background(background)
            .cornerRadius(8)
            .shadow(color: .gray.opacity(0.15), radius: 10)
    }

    @ViewBuilder
    private var mainContent: some View {
        switch axis {
        case .horizontal:
            HStack(alignment: verticalAlignment, content: content)
        case .vertical:
            VStack(alignment: horizontalAlignment, content: content)
        }
    }

    @ViewBuilder
    private var background: some View {
        switch colorScheme {
        case .light:
            Color.tertiarySystemBackground
        case .dark:
            Color.secondarySystemBackground
        @unknown default:
            Color.tertiarySystemBackground
        }
    }
}

public extension View {
    func card(_ axis: Axis = .vertical, includeEdgePadding: Bool = true) -> some View {
        Card(axis, includeEdgePadding: includeEdgePadding) {
            self
        }
    }
    
    func card(alignment: HorizontalAlignment, includeEdgePadding: Bool = true) -> some View {
        Card(alignment: alignment, includeEdgePadding: includeEdgePadding) {
            self
        }
    }

    func card(alignment: VerticalAlignment, includeEdgePadding: Bool = true) -> some View {
        Card(alignment: alignment, includeEdgePadding: includeEdgePadding) {
            self
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Card {
                Text("Hello, world!")
                    .padding()
            }
        }
    }
}

private extension ColorScheme {
    var cardBackgroundColor: Color {
        switch self {
        case .light:
            return .white
        case .dark:
            return .darkGray
        @unknown default:
            return .systemFill
        }
    }
}
