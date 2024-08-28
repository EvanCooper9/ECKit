import Foundation

public extension Encodable {
    func jsonDictionary(encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
    }
}

public extension Encodable {
    func encoded(using encoder: JSONEncoder = .shared) throws -> Data {
        try encoder.encode(self)
    }
}
