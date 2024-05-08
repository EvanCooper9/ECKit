import Foundation

public extension Date {
    func addingTimeInterval(_ timeInterval: Int) -> Date {
        addingTimeInterval(TimeInterval(timeInterval))
    }

    var isToday: Bool {
        Calendar.current.isDate(self, equalTo: .now, toGranularity: .day)
    }

    func encodedToString(with formatter: DateFormatter = .dateDashed) -> String {
        formatter.string(from: self)
    }
    
    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }
}
