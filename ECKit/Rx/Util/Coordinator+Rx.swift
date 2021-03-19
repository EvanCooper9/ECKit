import RxCocoa

public protocol RxCoordinator: AnyObject {
    
    associatedtype CoordinationResult
    
    var childCoordinators: [AnyObject] { get set }
    
    func start() -> Signal<CoordinationResult>
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
    
    func coordinate<T: RxCoordinator>(to coordinator: T) -> Signal<T.CoordinationResult> {
        add(child: coordinator)
        return coordinator.start()
            .do(onDispose: { [weak self, weak coordinator] in
                guard let self = self, let coordinator = coordinator else { return }
                self.remove(child: coordinator)
            })
    }
}
