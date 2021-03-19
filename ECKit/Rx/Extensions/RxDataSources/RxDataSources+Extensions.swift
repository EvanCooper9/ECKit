import Differentiator

public struct Section<Model> {
    public var items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }
}

extension Section: IdentifiableType {
    public var identity: String { String(describing: type(of: self)) }
}

extension Section: SectionModelType {
    public typealias Item = Model

    public init(original: Section, items: [Model]) {
        self = original
        self.items = items
    }
}
