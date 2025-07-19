import Foundation

public extension Bundle {
    var name: String {
        infoDictionary!["CFBundleName"] as! String
    }

    var displayName: String {
        infoDictionary!["CFBundleDisplayName"] as! String
    }

    var version: String {
        infoDictionary!["CFBundleShortVersionString"] as! String
    }

    var build: String {
        infoDictionary!["CFBundleVersion"] as! String
    }

    var id: String {
        infoDictionary!["CFBundleIdentifier"] as! String
    }
}

#if canImport(UIKit)
import UIKit

public extension Bundle {
    var icon: UIImage! {
        let icons = infoDictionary!["CFBundleIcons"] as! [String: Any]
        let primaryIcon = icons["CFBundlePrimaryIcon"] as! [String: Any]
        let iconFiles = primaryIcon["CFBundleIconFiles"] as! [String]
        return UIImage(named: iconFiles.last!)
    }
}
#endif
