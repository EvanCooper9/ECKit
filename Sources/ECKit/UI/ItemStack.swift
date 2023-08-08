import SwiftUI

@available(iOS 16.0, *)
public struct ItemStack<Model: Identifiable, ModelContent: View>: View {

    private let models: [Model]
    private let maxDepth: Int
    @ViewBuilder private let modelContent: (Model) -> ModelContent

    @State private var expanded = false

    public init(models: [Model], maxDepth: Int = 3, modelContent: @escaping (Model) -> ModelContent) {
        self.models = models
        self.maxDepth = maxDepth
        self.modelContent = modelContent
    }

    public var body: some View {
        let layout = expanded ? AnyLayout(VStackLayout()) : AnyLayout(ZStackLayout(alignment: .bottom))
        layout {
            ForEach(enumerated: models) { index, model in
                modelContent(model)
                    .padding(.bottom, expanded ? 0 : CGFloat((models.count - index - 1) * 10))
                    .scaleEffect(expanded ? 1 : 1.0 - (CGFloat(index) * 0.05))
                    .zIndex(Double(models.count - index))
            }
        }
        .onTapGesture {
            withAnimation {
                expanded.toggle()
            }
        }
        .animation(.default, value: expanded)
    }
}

#if DEBUG
@available(iOS 16.0, *)
struct ItemStack_Previews: PreviewProvider {

    private struct Model: Identifiable {
        let id = UUID()
        let text: String
        let color: Color
    }

    @available(iOS 16.0, *)
    private struct Preview: View {
        @State private var models = [
            Model(text: "First model", color: .yellow),
            Model(text: "Second model", color: .blue),
            Model(text: "Third model", color: .green),
            Model(text: "Fourth model", color: .red)
        ]

        var body: some View {
            VStack {

                ItemStack(models: models, maxDepth: models.count) { model in
                    Text(model.text)
                        .font(.title)
                        .maxWidth(.infinity)
                        .padding()
                        .background(model.color)
                        .cornerRadius(10)
                }

                Color.gray.opacity(0.2)
                    .cornerRadius(10)
                    .overlay {
                        Text("Other content")
                    }
            }
            .padding()
        }
    }
    static var previews: some View {
        Preview()
    }
}
#endif
