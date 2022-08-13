import Resolver
import SwiftUI

struct ___VARIABLE_productName___View: View {

    @StateObject private var viewModel = Resolver.resolve(___VARIABLE_productName___ViewModel.self)

//    init() {
//        let viewModel = Resolver.resolve(___VARIABLE_productName___ViewModel.self, args: )
//    }

    var body: some View {
        Text("Hello, World!")
    }
}

#if DEBUG
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View()
            .setupMocks()
    }
}
#endif
