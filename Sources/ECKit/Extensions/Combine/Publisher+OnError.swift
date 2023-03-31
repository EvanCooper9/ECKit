import Combine
import CombineExt

public extension Publisher where Failure == Error {
    func onError(handler: @escaping (Failure) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                handler(error)
            case .finished:
                break
            }
        })
    }

    func onError<Object: AnyObject>(withUnretained object: Object, handler: @escaping (Object, Failure) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveCompletion: { [weak object] completion in
            guard let object else { return }
            switch completion {
            case .failure(let error):
                handler(object, error)
            case .finished:
                break
            }
        })
    }
}
