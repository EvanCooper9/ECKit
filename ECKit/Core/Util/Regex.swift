import Foundation

public struct Regex {
    
    public typealias Options = NSRegularExpression.Options
    
    public var pattern: String
    public var options: Options
    
    public init(pattern: String, options: Options) {
        self.pattern = pattern
        self.options = options
    }
    
    public func matches(in text: String) throws -> [NSTextCheckingResult] {
        let regex = try NSRegularExpression(pattern: pattern, options: options)
        return regex.matches(in: text, range: NSRange(location: 0, length: text.count))
    }
    
}
