@resultBuilder
public enum ArrayBuilder<Element> {
    public static func buildEither(first component: [Element]) -> [Element] { component }
    public static func buildEither(second component: [Element]) -> [Element] { component }
    public static func buildOptional(_ component: [Element]?) -> [Element] { component ?? [] }
    public static func buildExpression(_ expression: Element) -> [Element] { [expression] }
    public static func buildExpression(_ expression: ()) -> [Element] { [] }
    public static func buildBlock(_ components: [Element]...) -> [Element] { components.flatMap { $0 } }
    public static func buildArray(_ components: [[Element]]) -> [Element] { Array(components.joined()) }
}

public extension Array {
    static func build(@ArrayBuilder<Element> _ builder: () -> [Element]) -> [Element] {
        self.init(builder())
    }
}
