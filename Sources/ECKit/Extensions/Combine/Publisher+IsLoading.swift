import Combine

public extension Publisher {
    func isLoading<Object: AnyObject>(set isLoading: WritableKeyPath<Object, Bool>, on object: Object, includeFinished: Bool = true) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveSubscription: { [weak object] _ in
            object?[keyPath: isLoading] = true
        }, receiveCompletion: { [weak object] _ in
            guard includeFinished else { return }
            object?[keyPath: isLoading] = false
        }, receiveCancel: { [weak object] in
            object?[keyPath: isLoading] = false
        })
    }

    func isLoading(includeFinished: Bool = true, _ isLoading: @escaping (Bool) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveSubscription: { _ in
            isLoading(true)
        }, receiveCompletion: { _ in
            guard includeFinished else { return }
            isLoading(false)
        }, receiveCancel: {
            isLoading(false)
        })
    }
}
