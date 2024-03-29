import Foundation

public extension Encodable {
    func jsonDictionary() throws -> [String: Any] {
        let data = try JSONEncoder.shared.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
    }
}

public extension Encodable {
    func encoded(using encoder: JSONEncoder = .shared) throws -> Data {
        try encoder.encode(self)
    }
}
