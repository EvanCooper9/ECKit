import AuthenticationServices
import SwiftUI

public struct SignInWithAppleButton: UIViewRepresentable {

    @Environment(\.colorScheme) var colorScheme

    public func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(type: .signIn, style: colorScheme == .dark ? .white : .black)
    }

    public func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
