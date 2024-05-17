import SwiftUI

public extension View {
    @ViewBuilder 
    func `if`<TrueContent: View, FalseContent: View>(_ condition: Bool, transformTrue: (Self) -> TrueContent, else transformFalse: ((Self) -> FalseContent)? = nil) -> some View {
        if condition {
            transformTrue(self)
        } else if let transformFalse {
            transformFalse(self)
        } else {
            self
        }
    }

    @ViewBuilder 
    func `if`<TrueContent: View>(_ condition: Bool, transformTrue: (Self) -> TrueContent) -> some View {
        if condition {
            transformTrue(self)
        } else {
            self
        }
    }
}
