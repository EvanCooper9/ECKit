import ECKit
import Firebase
import FirebaseFirestore

public extension DocumentSnapshot {

    private static let decoder = JSONDecoder()

    func decoded<T: Decodable>(as type: T.Type) throws -> T {
        do {
            let json = try JSONSerialization.data(withJSONObject: data() ?? [:])
            return try DocumentSnapshot.decoder.decode(T.self, from: json)
        } catch {
            print(error)
            throw error
        }
    }
}

public extension Array where Element: DocumentSnapshot {
    func decoded<T: Decodable>(asArrayOf type: T.Type) -> [T] {
        compactMap { try? $0.decoded(as: T.self) }
    }
}
