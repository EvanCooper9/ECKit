import SwiftUI

public extension View {
    func matchHeight(height: Binding<CGFloat?>) -> some View {
        modifier(MatchHeightModifier(height: height))
    }
}

private struct MatchHeightGroup<Content: View>: View {

    private var content: () -> Content
    @State private var height: CGFloat?

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        Group {
            content()
        }
        .matchHeight(height: $height)
    }
}

private struct MatchHeightModifier: ViewModifier {
    @Binding var height: CGFloat?

    public func body(content: Content) -> some View {
        content
            .frame(height: height)
            .background {
                GeometryReader { geometry in
                    Color.clear.preference(key: HeightPreferenceKey.self, value: [geometry.size.height])
                }
            }
            .onPreferenceChange(HeightPreferenceKey.self) { height = $0.reduce(height ?? 0, max) }
    }
}

private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
