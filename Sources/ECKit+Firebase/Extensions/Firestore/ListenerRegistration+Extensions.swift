import Firebase
import FirebaseFirestore

public final class ListenerBag {
    
    private var registrations = [ListenerRegistration]()

    public init() {}
    
    deinit {
        registrations.forEach {
            $0.remove()
        }
    }
    
    public func store(_ listener: ListenerRegistration) {
        registrations.append(listener)
    }
}

public extension ListenerRegistration {
    func store(in bag: ListenerBag) {
        bag.store(self)
    }
}
