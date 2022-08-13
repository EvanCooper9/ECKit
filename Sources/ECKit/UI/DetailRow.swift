import SwiftUI
import SwiftUIX

public struct DetailRow: View {

    let symbol: SFSymbolName
    let description: String
    let value: String

    public init(symbol: SFSymbolName, description: String, value: String) {
        self.symbol = symbol
        self.description = description
        self.value = value
    }

    public var body: some View {
        HStack {
            Image(systemName: symbol)
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
