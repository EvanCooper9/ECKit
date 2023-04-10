import Combine

public extension Publisher where Failure == Error {
    func catchErrorJustReturn(_ output: Output) -> Publishers.Catch<Self, AnyPublisher<Self.Output, Never>> {
        self.catch { _ in AnyPublisher<Output, Never>.just(output) }
    }
}
