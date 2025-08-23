import SwiftUI

struct ___VARIABLE_productName___View: View {

    @StateObject private var viewModel = ___VARIABLE_productName___ViewModel()

//    init() {
//        _viewModel = .init(wrappedValue: ___VARIABLE_productName___ViewModel())
//    }

    var body: some View {
        Text("Hello, World!")
    }
}

#if DEBUG
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        setupMocks()
        return ___VARIABLE_productName___View()
    }
}
#endif
