import UIKit

public protocol Sharable {
    var itemsToShare: [Any] { get }
}

public extension Sharable {
    func share() {
        let activityVC = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )
        activityVC.excludedActivityTypes = [.mail, .saveToCameraRoll, .print]

        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .filter(\.isKeyWindow)
            .first

        keyWindow?.rootViewController?
            .topViewController
            .present(activityVC, animated: true, completion: nil)
    }
}
