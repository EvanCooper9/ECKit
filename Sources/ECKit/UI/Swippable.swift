import SwiftUI

public struct Swipeable<Content: View>: View {

    public init(@ViewBuilder content: @escaping () -> Content, onDelete: @escaping () -> Void) {
        self.content = content
        self.onDelete = onDelete
    }

    @ViewBuilder private let content: () -> Content
    private let onDelete: () -> Void
    private let swipeThreshold: CGFloat = -100
    @State private var horizontalOffset: CGFloat = .zero
    @State private var height: CGFloat = .zero
    @State private var thresholdReached = false

    public var body: some View {
        ZStack(alignment: .trailing) {
            Image(systemName: .xCircleFill)
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .fill(.red)
                        .frame(
                            width: (horizontalOffset / swipeThreshold) * height,
                            height: (horizontalOffset / swipeThreshold) * height
                        )
                }
                .padding(.trailing, abs(height / 2))
                .frame(maxWidth: .infinity, maxHeight: height, alignment: .trailing)
                .background(Color.red.opacity(thresholdReached ? 1 : 0.5))
                .cornerRadius(10)
                .animation(.default, value: thresholdReached)
            if #available(iOS 17, *) {
                swippableContent
                    .sensoryFeedback(.selection, trigger: thresholdReached)
            } else {
                swippableContent
            }
        }
    }

    private var swippableContent: some View {
        content()
            .onAppearAndChangeOfFrame { height = $0.height }
            .offset(x: horizontalOffset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { drag in
                        guard drag.translation.width < 0 else { return }
                        horizontalOffset = drag.translation.width
                        thresholdReached = drag.translation.width < swipeThreshold
                    }
                    .onEnded { _ in
                        defer {
                            thresholdReached = false
                            withAnimation {
                                horizontalOffset = 0
                            }
                        }
                        guard thresholdReached else { return }
                        onDelete()
                    }
            )
    }
}

#Preview {
    Swipeable {
        Text("Content")
            .padding()
            .maxWidth(.infinity)
            .background(.yellow)
    } onDelete: {
        print("delete")
    }
}
