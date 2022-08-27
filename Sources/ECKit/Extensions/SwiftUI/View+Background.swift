import SwiftUI
import UIKit

public extension View {
    func background(_ uiColor: UIColor) -> some View {
        background(Color(uiColor: uiColor))
    }
}
