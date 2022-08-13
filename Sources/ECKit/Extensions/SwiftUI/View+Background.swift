import SwiftUI
import UIKit

extension View {
    func background(_ uiColor: UIColor) -> some View {
        background(Color(uiColor: uiColor))
    }
}
