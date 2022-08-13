import UIKit

extension UITableView {
    public func dequeue<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
