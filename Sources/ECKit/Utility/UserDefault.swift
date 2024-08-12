// https://www.avanderlee.com/swift/property-wrappers/
import Combine
import Foundation

/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

public extension UserDefault where Value: ExpressibleByNilLiteral {
    
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    init(_ key: String, _ container: UserDefaults = .standard) {
        self.init(key, defaultValue: nil, container: container)
    }
}

@propertyWrapper
public struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    private let publisher: CurrentValueSubject<Value, Never>
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(_ key: String, defaultValue: Value, container: UserDefaults = .standard, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
        self.encoder = encoder
        self.decoder = decoder

        let initialValue = container.decode(Value.self, forKey: key, decoder: decoder) ?? defaultValue
        publisher = .init(initialValue)
    }
    
    public var wrappedValue: Value {
        get { container.decode(Value.self, forKey: key, decoder: decoder) ?? defaultValue }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.encode(newValue, forKey: key, encoder: encoder)
            }
            publisher.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}
