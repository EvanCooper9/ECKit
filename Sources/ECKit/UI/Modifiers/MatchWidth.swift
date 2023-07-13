import SwiftUI

public extension View {
    func matchWidth(width: Binding<CGFloat?>) -> some View {
        modifier(MatchWidthModifier(width: width))
    }
}

private struct MatchWidthGroup<Content: View>: View {

    private var content: () -> Content
    @State private var width: CGFloat?

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        Group {
            content()
        }
        .matchWidth(width: $width)
    }
}

private struct MatchWidthModifier: ViewModifier {
    @Binding var width: CGFloat?

    public func body(content: Content) -> some View {
        content
            .frame(width: width)
            .background {
                GeometryReader { geometry in
                    Color.clear.preference(key: WidthPreferenceKey.self, value: [geometry.size.width])
                }
            }
            .onPreferenceChange(WidthPreferenceKey.self) { width = $0.reduce(width ?? 0, max) }
    }
}

private struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
