import UIKit

public struct Device {
    public static let modelName: String = { UIDevice.current.name }()
    public static let iOSVersion: String = { UIDevice.current.systemVersion }()
}
