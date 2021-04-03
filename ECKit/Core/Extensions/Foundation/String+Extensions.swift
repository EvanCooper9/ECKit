public extension String {
    func removing(suffix: String) -> String {
        guard ends(with: suffix) else { return self }
        return String(dropLast(suffix.count))
    }
    
    func removing(prefix: String) -> String {
        guard starts(with: prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func ends(with suffix: String) -> Bool {
        reversed().starts(with: suffix.reversed())
    }
}
