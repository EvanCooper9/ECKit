import Combine
import CombineExt

// Modified from https://medium.com/geekculture/from-combine-to-async-await-c08bf1d15b77

public extension AnyPublisher where Failure == Never {
    func async() async -> Output {
        await withCheckedContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first()
                .mapToResult()
                .sink { result in
                    cancellable?.cancel()
                    continuation.resume(with: result)
                }
        }
    }
}

public extension AnyPublisher where Failure == Error {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first()
                .mapToResult()
                .sink { result in
                    cancellable?.cancel()
                    continuation.resume(with: result)
                }
        }
    }
}
