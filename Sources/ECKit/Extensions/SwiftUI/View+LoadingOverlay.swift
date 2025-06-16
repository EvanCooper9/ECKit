import SwiftUI
import SwiftUIX

public extension View {
    @ViewBuilder
    func withLoadingOverlay(isLoading: Bool) -> some View {
        overlay {
            if isLoading {
                ProgressView()
                    .padding(.extraExtraLarge)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            }
        }
        .disabled(isLoading)
        .allowsHitTesting(!isLoading)
    }
}

struct LoadingOverlayPreviews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(0...10, id: \.self) { number in
                Text("\(number)")
            }
            Button("Test") {
                
            }
        }
        .navigationTitle("Example")
        .embeddedInNavigationView()
        .withLoadingOverlay(isLoading: true)
    }
}
