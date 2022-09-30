import SwiftUI

public struct Checkbox: View {

    @Binding var isChecked: Bool

    public init(isChecked: Binding<Bool>) {
        _isChecked = isChecked
    }

    public var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            if isChecked {
                Image(systemName: .checkmarkSquareFill)
            } else {
                Image(systemName: .square)
            }
        }
    }
}

struct Checkbox_Previews: PreviewProvider {

    private struct Preview: View {

        @State private var isCheckedFirst = false
        @State private var isCheckedSecond = true

        var body: some View {
            HStack {
                Checkbox(isChecked: $isCheckedFirst)
                Checkbox(isChecked: $isCheckedSecond)
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}
