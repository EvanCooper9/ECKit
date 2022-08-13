import Foundation

public extension String {

    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }

    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }

    func after(prefix: String) -> String? {
        guard starts(with: prefix) else { return nil }
        return String(dropFirst(prefix.count))
    }

    func before(suffix: String) -> String? {
        guard hasSuffix(suffix) else { return nil }
        return String(dropLast(suffix.count))
    }

    func ifEmpty(_ string: String) -> String {
        isEmpty ? string : self
    }
}

public extension Optional where Wrapped == String {
    var emptyIfNil: String {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped
        }
    }
}
