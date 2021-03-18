import RxSwift

public protocol RxCoordinator: AnyObject {
    
    associatedtype CoordinationResult
    
    var childCoordinators: [AnyObject] { get set }
    
    func start() -> Single<CoordinationResult>
}

public extension RxCoordinator {
    
    func add<T: RxCoordinator>(child coordinator: T) {
        childCoordinators.append(coordinator)
    }
    
    func remove<T: RxCoordinator>(child coordinator: T) {
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func coordinate<T: RxCoordinator>(to coordinator: T) -> Single<T.CoordinationResult> {
        coordinator.start()
            .do(onSubscribe: { [weak self] in
                self?.add(child: coordinator)
            }, onDispose: { [weak self] in
                self?.remove(child: coordinator)
            })
    }
}
