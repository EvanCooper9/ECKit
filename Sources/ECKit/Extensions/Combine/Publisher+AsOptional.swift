import Combine

public extension Publisher {
    func asOptional() -> Publishers.Map<Self, Output?> {
        map { $0 as Output? }
    }
}
