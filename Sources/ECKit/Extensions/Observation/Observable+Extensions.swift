import Observation

@available(iOS 17.0, *)
extension Observable {
    public func onChange<Value>(of keyPath: KeyPath<Self, Value>, perform action: @escaping (Value) -> Void) {
        _ = withObservationTracking {
            self[keyPath: keyPath]
        } onChange: {
            Task {
                action(self[keyPath: keyPath])
            }
        }
    }
}
