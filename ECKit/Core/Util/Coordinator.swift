import UIKit

public protocol Coordinator: AnyObject {
    
    associatedtype CoordinationResult
    
    typealias Completion<T> = ((T) -> Void)
    
    var childCoordinators: [AnyObject] { get set }
    func start(completion: Completion<CoordinationResult>?)
}

public extension Coordinator {
    
    func add<T: Coordinator>(child coordinator: T) {
        childCoordinators.append(coordinator)
    }
    
    func remove<T: Coordinator>(child coordinator: T) {
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func coordinate<T: Coordinator>(to coordinator: T, completion: Completion<T.CoordinationResult>? = nil) {
        add(child: coordinator)
        coordinator.start { [weak self] result in
            completion?(result)
            self?.remove(child: coordinator)
        }
    }
}
