import Combine

public extension Publisher where Failure == Error {
    func debugErrorTrap() -> Publishers.HandleEvents<Self> {
        onError { error in
            assertionFailure(error.localizedDescription)
        }
    }
}
