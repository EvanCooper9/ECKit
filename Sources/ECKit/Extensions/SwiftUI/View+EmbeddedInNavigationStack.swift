import SwiftUI

@available(iOS, introduced: 16)
extension View {
    func embeddedInNavigationStack<Data>(path: Binding<Data>) -> some View where Data : MutableCollection, Data : RandomAccessCollection, Data : RangeReplaceableCollection, Data.Element : Hashable {
        NavigationStack(path: path) {
            self
        }
    }
}
