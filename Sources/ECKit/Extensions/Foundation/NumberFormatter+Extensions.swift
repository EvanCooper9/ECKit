import Foundation

public extension NumberFormatter {
    static let decimal: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}
