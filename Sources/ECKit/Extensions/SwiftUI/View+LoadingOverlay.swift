import SwiftUI
import SwiftUIX

public extension View {
    @ViewBuilder
    func withLoadingOverlay(isLoading: Bool) -> some View {
        self
            .disabled(isLoading)
            .allowsHitTesting(!isLoading)
            .overlay {
                ProgressView()
                    .padding(.extraExtraLarge)
                    .background(.systemFill.opacity(0.75))
                    .cornerRadius(10)
                    .hidden(!isLoading)
            }
    }
}

struct LoadingOverlayPreviews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(0...10, id: \.self) { number in
                Text("\(number)")
            }
        }
        .navigationTitle("Example")
        .embeddedInNavigationView()
        .withLoadingOverlay(isLoading: true)
    }
}
