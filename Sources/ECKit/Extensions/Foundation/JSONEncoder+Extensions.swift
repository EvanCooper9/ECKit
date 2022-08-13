import Foundation

public extension JSONEncoder {
    static let shared: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.dateDashed)
        return encoder
    }()
}
