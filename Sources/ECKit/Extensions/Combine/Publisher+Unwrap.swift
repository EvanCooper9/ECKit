import Combine

public extension Publisher {
    func unwrap<T>() -> AnyPublisher<T, Failure> where Output == Optional<T> {
        compactMap { $0 }.eraseToAnyPublisher()
    }
}
