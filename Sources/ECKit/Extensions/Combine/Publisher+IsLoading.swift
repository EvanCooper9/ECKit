import Combine
import Foundation

public extension Publisher {
    func isLoading<Object: AnyObject>(set isLoading: WritableKeyPath<Object, Bool>, on object: Object, includeFinished: Bool = true) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveSubscription: { [weak object] _ in
            DispatchQueue.main.async {
                object?[keyPath: isLoading] = true
            }
        }, receiveCompletion: { [weak object] _ in
            guard includeFinished else { return }
            DispatchQueue.main.async {
                object?[keyPath: isLoading] = false
            }
        }, receiveCancel: { [weak object] in
            DispatchQueue.main.async {
                object?[keyPath: isLoading] = false
            }
        })
    }

    func isLoading(includeFinished: Bool = true, _ isLoading: @escaping (Bool) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveSubscription: { _ in
            DispatchQueue.main.async {
                isLoading(true)
            }
        }, receiveCompletion: { _ in
            guard includeFinished else { return }
            DispatchQueue.main.async {
                isLoading(false)
            }
        }, receiveCancel: {
            DispatchQueue.main.async {
                isLoading(false)
            }
        })
    }
}
