public extension Array {
    func appending(_ element: Element) -> Array<Element> {
        var a = self
        a.append(element)
        return a
    }

    func appending(contentsOf elements: Array<Element>) -> Array<Element> {
        var a = self
        a.append(contentsOf: elements)
        return a
    }
    
    var isNotEmpty: Bool { !isEmpty }
}

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        remove(at: index)
    }

    func removing(_ element: Element) -> Array<Element> {
        var a = self
        a.remove(element)
        return a
    }

    mutating func toggle(_ element: Element) {
        contains(element) ? remove(element) : append(element)
    }
}

public extension Array where Element: Collection {
    func flattened() -> [Element.Element] { reduce([], +) }
}

public extension Array {
    subscript(safe index: Index) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
