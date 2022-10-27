import CodableFirebase
import FirebaseFunctions
import Foundation

public extension HTTPSCallableResult {

    enum Error: Swift.Error {
        case badData
    }

    private static let decoder = FirestoreDecoder()

    func decoded<T: Decodable>(asArrayOf type: T.Type) throws -> [T] {
        do {
            print("https result", data)
            guard let string = data as? String,
                  let data = string.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            else {
                throw Error.badData
            }
            return json.compactMap { object in
                try? HTTPSCallableResult.decoder.decode(T.self, from: object)
            }
        } catch {
            throw error
        }
    }
}