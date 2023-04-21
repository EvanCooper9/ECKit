import Combine

public extension Publisher where Failure == Never {
    static func fromAsync(execute: @escaping () async -> Output) -> some Publisher<Output, Failure> {
        Future { promise in
            Task {
                let result = await execute()
                promise(.success(result))
            }
        }
    }
}

public extension Publisher where Failure == Error {
    static func fromAsync(execute: @escaping () async throws -> Output) -> some Publisher<Output, Failure> {
        Future { promise in
            Task {
                do {
                    let result = try await execute()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
