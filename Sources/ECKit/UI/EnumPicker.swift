import SwiftUI

public struct EnumPicker<T: CaseIterable & CustomStringConvertible & Hashable & Identifiable>: View {

    let name: String
    @Binding var selection: T?

    public init(_ name: String, selection: Binding<T?>) {
        self.name = name
        self._selection = selection
    }

    public var body: some View {
        Picker(name, selection: $selection) {
            if selection == nil {
                Text("Select...").tag(T?.none)
            }
            ForEach(Array(T.allCases)) { someCase in
                Text(someCase.description).tag(someCase as T?)
            }
        }
    }
}
