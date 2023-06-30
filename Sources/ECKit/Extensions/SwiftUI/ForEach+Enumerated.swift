import SwiftUI

public extension ForEach where Content: View {
    init<Model: Identifiable>(_ data: EnumeratedSequence<[Model]>, @ViewBuilder content: @escaping (Int, Model) -> Content) where Data == Array<(offset: Int, element: Model)>, Model.ID == ID {
        self.init(Array(data), id: \.element.id, content: content)
    }

    init<Model: Identifiable>(enumerated data: [Model], @ViewBuilder content: @escaping (Int, Model) -> Content) where Data == Array<(offset: Int, element: Model)>, Model.ID == ID {
        self.init(Array(data.enumerated()), id: \.element.id, content: content)
    }
}

#if DEBUG
struct ForEach_Previews: PreviewProvider {

    struct Model: Identifiable {
        let title: String
        var id: String { title }
    }

    private static let models = [
        Model(title: "lorem"),
        Model(title: "ipsum"),
        Model(title: "dolor")
    ]

    static var previews: some View {
        VStack {
            ForEach(models.enumerated()) { index, model in
                Text(model.title)
                    .zIndex(Double(index))
            }

            Divider()

            ForEach(enumerated: models) { index, model in
                Text(model.title)
                    .zIndex(Double(index))
            }
        }
        .padding()
    }
}
#endif
