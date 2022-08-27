import SwiftUI

public extension View {
    func withSuccessOverlay(isPresented: Bool) -> some View {
        overlay {
            Image(systemName: .checkmark)
                .font(.largeTitle)
                .padding(.extraExtraLarge)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .transition(.opacity)
                .visible(isPresented)
        }
        .disabled(isPresented)
        .allowsHitTesting(!isPresented)
    }
}

struct SuccessOverlay_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
            .withSuccessOverlay(isPresented: true)
    }
}
