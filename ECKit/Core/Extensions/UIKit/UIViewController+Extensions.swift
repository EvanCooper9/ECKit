import UIKit

public extension UIViewController {
    var name: String {
        let fullName = NSStringFromClass(self.classForCoder)
        let className = fullName.components(separatedBy: ".")[1]
        let suffix = "ViewController"
        guard className.hasSuffix(suffix) else { fatalError("UIViewController class name is incorrectly formatted: \(className)") }
        return String(className.dropLast(suffix.count))
    }
    
    var top: UIViewController {
        guard let presentedViewController = presentedViewController else { return self }
        return presentedViewController.top
    }
    
    /// Scrolls the child UIScrollView when keyboard is shown or hidden to ensure the first responder is visible.
    func configureKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}

extension UIViewController {
    @objc func adjustForKeyboard(notification: Notification) {
        guard let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else { return }
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            
            guard let firstResponder = view.firstResponder,
                  let firstResponderViewFrame = firstResponder.superview?.convert(firstResponder.frame, to: view),
                  keyboardViewEndFrame.intersects(firstResponderViewFrame) else { return }
                
            let intersection = keyboardViewEndFrame.intersection(firstResponderViewFrame)
            let difference = intersection.maxY - keyboardViewEndFrame.minY
            scrollView.contentInset.bottom = difference
            scrollView.setContentOffset(.init(x: 0, y: difference), animated: true)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
