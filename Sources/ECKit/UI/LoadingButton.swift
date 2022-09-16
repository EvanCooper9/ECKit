import SwiftUI

public struct LoadingButton: View {

    private let text: String
    private let loading: Bool
    private let action: () -> Void

    public init(_ text: String, loading: Bool, action: @escaping () -> Void) {
        self.text = text
        self.loading = loading
        self.action = action
    }

    public var body: some View {
        HStack {
            Button(text, action: action)
                .frame(maxWidth: .infinity, alignment: .leading)
            ProgressView()
                .hidden(!loading)
        }
        .disabled(loading)
    }
}

