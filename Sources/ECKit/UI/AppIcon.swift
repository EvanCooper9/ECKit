import Foundation
import SwiftUI

public struct AppIcon: View {

    var size = 60.0
    private var cornerRadius: Double { size * 0.2237 }

    public init(size: Double = 60.0) {
        self.size = size
    }

    public var body: some View {
        Image(uiImage: Bundle.main.icon)
            .resizable()
            .frame(width: size, height: size)
            .cornerRadius(cornerRadius)
    }
}

struct AppIcron_Previews: PreviewProvider {
    static var previews: some View {
        AppIcon()
    }
}
