import ECKit_Core
import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let sceneName = className.removing(suffix: "ViewController")
        let storyboard = UIStoryboard(name: sceneName, bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
