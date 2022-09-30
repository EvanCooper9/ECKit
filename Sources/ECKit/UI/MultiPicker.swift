import SwiftUI
import SwiftUIX

public struct MultiPicker<Selection: CustomStringConvertible & Hashable & Identifiable>: View {

    private let title: String
    @Binding private var selection: [Selection]
    private let options: [Selection]

    public init(title: String, selection: Binding<[Selection]>, options: [Selection]) {
        self.title = title
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        NavigationLink {
            List {
                ForEach(options) { option in
                    HStack {
                        Text(option.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .tag(option)
                            .onTapGesture { selection.toggle(option) }
                        if selection.contains(option) {
                            Image(systemName: .checkmark)
                                .font(.body.bold())
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        } label: {
            HStack {
                Text(title)
                Spacer()
                if selection.isNotEmpty {
                    Text(selection.map(\.description).joined(separator: ", "))
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
