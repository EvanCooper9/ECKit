public extension Array {
    func appending(_ element: Element) -> Self {
        var a = self
        a.append(element)
        return a
    }
    
    func appending(contentsOf sequence: Self) -> Self {
        var a = self
        a.append(contentsOf: sequence)
        return a
    }
}
