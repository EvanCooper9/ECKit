import SwiftUI

public struct Card<Content: View>: View {

    private var axis: Axis
    private var horizontalAlignment: HorizontalAlignment
    private var verticalAlignment: VerticalAlignment
    @ViewBuilder private var content: () -> Content

    @Environment(\.colorScheme) var colorScheme

    public init(_ axis: Axis = .vertical, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
        self.horizontalAlignment = .center
        self.verticalAlignment = .center
    }

    public init(alignment: HorizontalAlignment, @ViewBuilder content: @escaping () -> Content) {
        self.axis = .vertical
        self.content = content
        self.horizontalAlignment = alignment
        self.verticalAlignment = .center
    }

    public init(alignment: VerticalAlignment, @ViewBuilder content: @escaping () -> Content) {
        self.axis = .horizontal
        self.content = content
        self.horizontalAlignment = .center
        self.verticalAlignment = alignment
    }

    public var body: some View {
        mainContent
            .padding()
            .background(colorScheme.cardBackgroundColor)
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
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("Hello, world!")
                .padding()
        }
    }
}

private extension ColorScheme {
    var cardBackgroundColor: Color {
        switch self {
        case .light:
            return .white
        case .dark:
            return .systemFill
        @unknown default:
            return .systemFill
        }
    }
}
