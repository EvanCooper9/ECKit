import UIKit

public extension NSLayoutConstraint {
    /// Activate the layouts defined in the result builder parameter `constraints`.
    static func activate(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) {
        activate(constraints())
    }
}

@resultBuilder
public struct AutoLayoutBuilder {
    public static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return components
    }

    public static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        components.flattened()
    }
}
