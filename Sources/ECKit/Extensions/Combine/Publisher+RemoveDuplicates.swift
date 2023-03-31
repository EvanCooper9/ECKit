import Combine

public extension Publisher {
    func removeDuplicates<T: Equatable>(by keyPath: KeyPath<Output, T>) -> Publishers.RemoveDuplicates<Self> {
        removeDuplicates { lhs, rhs in
            lhs[keyPath: keyPath] == rhs[keyPath: keyPath]
        }
    }
}
