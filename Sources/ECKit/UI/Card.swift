import SwiftUI

public struct Card<Content: View>: View {

    var axis: Axis = .vertical
    @ViewBuilder var content: () -> Content

    public init(_ axis: Axis = .vertical, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }

    public var body: some View {
        mainContent
            .padding()
            .background(.white)
            .cornerRadius(8)
            .shadow(color: .gray.opacity(0.15), radius: 10)
    }

    @ViewBuilder
    private var mainContent: some View {
        switch axis {
        case .horizontal:
            HStack(content: content)
        case .vertical:
            VStack(content: content)
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
