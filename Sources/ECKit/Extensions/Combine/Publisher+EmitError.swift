import Combine
import Foundation

public extension Publisher where Failure == Error {
    func emitError<Root>(to keyPath: ReferenceWritableKeyPath<Root, Error?>, on object: Root) -> AnyPublisher<Output, Never> {
        self
            .handleEvents(receiveOutput: { _ in
                DispatchQueue.main.async {
                    object[keyPath: keyPath] = nil
                }
            })
            .catch { error -> AnyPublisher<Output, Never> in
                DispatchQueue.main.async {
                    object[keyPath: keyPath] = error
                }
                return .never()
            }
            .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == String, Failure == Error {
    func emitResult<Root>(to keyPath: ReferenceWritableKeyPath<Root, Result<String, Error>?>, on object: Root) -> AnyPublisher<Void, Never> {
        self
            .handleEvents(receiveOutput: { string in
                DispatchQueue.main.async {
                    object[keyPath: keyPath] = .success(string)
                }
            })
            .catch { error -> AnyPublisher<Output, Never> in
                DispatchQueue.main.async {
                    object[keyPath: keyPath] = .failure(error)
                }
                return .never()
            }
            .mapToValue(())
            .eraseToAnyPublisher()
    }
}
