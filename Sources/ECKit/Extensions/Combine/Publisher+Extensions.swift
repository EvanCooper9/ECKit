import Combine
import CombineExt
import Foundation

public extension Publisher where Self.Failure == Never {
    func sinkAsync(receiveValue: @escaping (Output) async throws -> Void) -> AnyCancellable {
        sink { output in
            Task {
                try await receiveValue(output)
            }
        }
    }
}

public extension Publisher where Failure == Never {
    func flatMapAsync<T>(asyncFunction: @escaping (Output) async throws -> T) -> AnyPublisher<T, Never> {
        self
            .setFailureType(to: Error.self)
            .flatMapAsync(asyncFunction: asyncFunction)
            .ignoreFailure()
    }
}

public extension Publisher where Failure == Error {
    func flatMapAsync<T>(asyncFunction: @escaping (Output) async throws -> T) -> AnyPublisher<T, Error> {
        self.flatMap { output -> AnyPublisher<T, Error> in
            let subject = PassthroughSubject<T, Error>()
            Task {
                do {
                    let results = try await asyncFunction(output)
                    subject.send(results)
                } catch {
                    subject.send(completion: .failure(error))
                }
            }
            return subject
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output: Collection {
    func compactMapMany<Result>(_ transform: @escaping (Output.Element) -> Result?) -> Publishers.CompactMap<Self, [Result]> {
        compactMap { $0.compactMap(transform) }
    }
}

public extension Publisher {
    func sink() -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}

public extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        Empty().eraseToAnyPublisher()
    }

    static func error(_ error: Failure) -> AnyPublisher<Output, Failure> {
        Fail(error: error).eraseToAnyPublisher()
    }

    static func just(_ output: Output, completeImmediately: Bool = true) -> AnyPublisher<Output, Failure> {
        if completeImmediately {
            return Just(output)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        } else {
            return CurrentValueSubject(output).eraseToAnyPublisher()
        }
    }

    static func never() -> AnyPublisher<Output, Failure> {
        Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}
