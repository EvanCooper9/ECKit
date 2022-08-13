import UIKit

public extension UINavigationController {
    func popAllViewControllers(animated: Bool) {
        popToRootViewController(animated: true)
        popViewController(animated: false)
    }
}
