import Foundation

public extension Data {
    mutating func append(_ value: UInt32) {
        let data = Swift.withUnsafeBytes(of: value) { Data($0) }
        append(data)
    }

    mutating func append(_ value: UInt16) {
        let data = Swift.withUnsafeBytes(of: value) { Data($0) }
        append(data)
    }

    mutating func append(_ value: Int32) {
        let data = Swift.withUnsafeBytes(of: value) { Data($0) }
        append(data)
    }

    mutating func append(_ value: Int16) {
        let data = Swift.withUnsafeBytes(of: value) { Data($0) }
        append(data)
    }
}

public extension Data {
    mutating func takeUInt8() -> UInt8 {
        let value = self.first!
        self = self.dropFirst()
        return value
    }

    mutating func takeUInt16() -> UInt16 {
        let value = UInt16(from: self)
        self = self.dropFirst(2)
        return value
    }

    mutating func takeUInt32() -> UInt32 {
        let value = UInt32(from: self)
        self = self.dropFirst(4)
        return value
    }

    mutating func takeInt16() -> Int16 {
        let value = Int16(from: self)
        self = self.dropFirst(2)
        return value
    }

    mutating func takeInt32() -> Int32 {
        let value = Int32(from: self)
        self = self.dropFirst(4)
        return value
    }
}
