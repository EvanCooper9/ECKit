import Foundation
import SwiftUI

public struct Alert {
    let title: String
    let message: String

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError

    var errorDescription: String? {
        underlyingError.errorDescription
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }

    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}

public extension View {
    @ViewBuilder
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        if let localizedAlertError = LocalizedAlertError(error: error.wrappedValue) {
            alert(isPresented: .constant(true), error: localizedAlertError) { _ in
                Button(buttonTitle) {
                    error.wrappedValue = nil
                }
            } message: { error in
                Text(error.recoverySuggestion ?? "")
            }
        } else {
            alert("Something went wrong", isPresented: .constant(error.wrappedValue != nil)) {
                Button(buttonTitle) {
                    error.wrappedValue = nil
                }
            } message: {
                Text(error.wrappedValue?.localizedDescription ?? "")
            }
        }
    }
}

public extension View {
    func alert(_ alertModel: Binding<Alert?>, buttonTitle: String = "OK") -> some View {
        alert(alertModel.wrappedValue?.title ?? "", isPresented: .constant(alertModel.wrappedValue != nil)) {
            Button(buttonTitle) {
                alertModel.wrappedValue = nil
            }
        } message: {
            if let message = alertModel.wrappedValue?.message {
                Text(message)
            }
        }
    }
}

public extension View {
    @ViewBuilder
    func result(_ result: Binding<Result<Alert, Error>?>, buttonTitle: String = "OK") -> some View {
        switch result.wrappedValue {
        case .failure(let error):
            let binding = Binding<Error?>(get: {
                error
            }, set: { error in
                if let error {
                    result.wrappedValue = .failure(error)
                } else {
                    result.wrappedValue = nil
                }
            })
            errorAlert(error: binding)
        case .success(let message):
            let binding = Binding<Alert?>(get: {
                message
            }, set: { message in
                if let message {
                    result.wrappedValue = .success(message)
                } else {
                    result.wrappedValue = nil
                }
            })
            alert(binding)
        case .none:
            self
        }
    }
}
