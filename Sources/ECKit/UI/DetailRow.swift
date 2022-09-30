import SwiftUI
import SwiftUIX

public struct DetailRow: View {

    private let symbol: SFSymbolName?
    private let description: String
    private let value: String

    public init(symbol: SFSymbolName? = nil, description: String, value: String) {
        self.symbol = symbol
        self.description = description
        self.value = value
    }

    public var body: some View {
        HStack {
            if let symbol {
                Image(systemName: symbol)
            }
            Text(description)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(symbol: .envelope, description: "email", value: "email@example.com")
    }
}
