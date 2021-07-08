import Differentiator

public struct Section<Model> {
    public var id: AnyHashable?
    public var items: [Item]
    
    public init(items: [Item], id: AnyHashable? = nil) {
        self.id = id
        self.items = items
    }
}

extension Section: IdentifiableType, AnimatableSectionModelType where Model: Equatable, Model: IdentifiableType {
    public var identity: AnyHashable {
        id?.hashValue ?? items.map(\.identity).hashValue
    }
}

extension Section: SectionModelType {
    public typealias Item = Model
    
    public init(original: Section, items: [Model]) {
        self = original
        self.items = items
    }
}
