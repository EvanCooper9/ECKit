public extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

public extension Sequence {
    var array: Array<Element> {
        Array(self)
    }
}
