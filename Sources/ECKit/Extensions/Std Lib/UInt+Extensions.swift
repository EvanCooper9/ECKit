import Foundation

public extension UInt16 {
    init(from data: Data) {
        self = data.withUnsafeBytes({ $0.bindMemory(to: UInt16.self) })[0]
    }
}

public extension UInt32 {
    init(from data: Data) {
        self = data.withUnsafeBytes({ $0.bindMemory(to: UInt32.self) })[0]
    }
}

public extension Int16 {
    init(from data: Data) {
        self = data.withUnsafeBytes({ $0.bindMemory(to: Int16.self) })[0]
    }
}

public extension Int32 {
    init(from data: Data) {
        self = data.withUnsafeBytes({ $0.bindMemory(to: Int32.self) })[0]
    }
}
