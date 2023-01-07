import Combine
import Foundation
import SwiftUI

@propertyWrapper
public struct UserDefault<Value: Codable>: DynamicProperty {

    // MARK: - Public Properties

    public var wrappedValue: Value {
        get { storage.decode(Value.self, forKey: key) ?? defaultValue }
        set {
            storage.encode(newValue, forKey: key)
            subject.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let subject: CurrentValueSubject<Value, Never>
    private let storage = UserDefaults.standard
    private let key: String
    private let defaultValue: Value

    // MARK: - Lifecycle

    public init(wrappedValue: Value, _ key: String) {
        self.defaultValue = wrappedValue
        self.key = key
        self.subject = .init(wrappedValue)
    }
}
