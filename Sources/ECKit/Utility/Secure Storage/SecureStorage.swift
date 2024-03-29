import Combine
import Foundation
import KeychainAccess
import SwiftUI

@propertyWrapper
public struct SecureStorage<Value: Codable>: DynamicProperty {

    private let publisher = PassthroughSubject<Value, Never>()
    @ObservedObject private var storage: KeychainStorage<Value>

    public var wrappedValue: Value {
        get { storage.value }

        nonmutating set {
            storage.value = newValue
            publisher.send(newValue)
        }
    }

    init(wrappedValue: Value, _ key: String) {
        storage = KeychainStorage(
            defaultValue: wrappedValue,
            for: key
        )
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}
