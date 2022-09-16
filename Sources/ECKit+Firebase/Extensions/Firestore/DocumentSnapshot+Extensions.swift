import CodableFirebase
import ECKit
import Firebase
import FirebaseFirestore

public extension DocumentSnapshot {

    private static let decoder = FirestoreDecoder()

    func decoded<T: Decodable>(as type: T.Type) throws -> T {
        do {
            return try DocumentSnapshot.decoder.decode(T.self, from: data() ?? [:])
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
