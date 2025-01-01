import SwiftUI
import SwiftUIX

public struct ContentUnavailableViewiOS16: View {

    private let icon: SFSymbol
    private let title: String
    private let message: String

    public init(icon: SFSymbol, title: String, message: String) {
        self.icon = icon
        self.title = title
        self.message = message
    }

    public var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(title)
                .font(.title3)
                .bold()
            Text(message)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentUnavailableViewiOS16(
        icon: .bellSlash,
        title: "Nothing here",
        message: "You're all caught up"
    )
}
