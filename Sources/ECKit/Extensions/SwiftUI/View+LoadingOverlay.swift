import SwiftUI
import SwiftUIX

public extension View {
    func withLoadingOverlay(isLoading: Bool) -> some View {
        modifier(LoadingOverlayModifier(loading: isLoading))
    }
}

struct LoadingOverlayModifier: ViewModifier {

    let loading: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                if loading {
                    ProgressView()
                        .padding(.extraExtraLarge)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
            .disabled(loading)
            .allowsHitTesting(!loading)
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
