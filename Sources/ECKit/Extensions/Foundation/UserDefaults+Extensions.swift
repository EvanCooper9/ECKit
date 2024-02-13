import Foundation

public extension UserDefaults {
    func encode<T: Encodable>(_ data: T, forKey key: String, encoder: JSONEncoder = .shared) {
        set(try? encoder.encode(data), forKey: key)
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: String, decoder: JSONDecoder = .shared) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
}
