import SwiftUI

struct ___VARIABLE_productName___View: View {

    @StateObject private var viewModel = ___VARIABLE_productName___ViewModel()

//    init() {
//        let viewModel = ___VARIABLE_productName___ViewModel()
//        _viewModel = .init(wrappedValue: viewModel)
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
