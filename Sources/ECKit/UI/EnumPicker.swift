import SwiftUI

public struct EnumPicker<T: CaseIterable & CustomStringConvertible & Hashable & Identifiable>: View {

    private let name: String
    @Binding private var selection: T?
    private let allowsNoSelection: Bool

    public init(_ name: String, selection: Binding<T?>, allowsNoSelection: Bool = false) {
        self.name = name
        self._selection = selection
        self.allowsNoSelection = allowsNoSelection
    }

    public var body: some View {
        Picker(name, selection: $selection) {
            if selection == nil || allowsNoSelection {
                Text("Select...").tag(T?.none)
            }
            ForEach(Array(T.allCases)) { someCase in
                Text(someCase.description).tag(someCase as T?)
            }
        }
    }
}
