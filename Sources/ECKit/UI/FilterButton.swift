import Popovers
import SwiftUI

public struct FilterButton<Content: View>: View {

    let text: String
    @ViewBuilder let content: () -> Content

    @State private var showFilter = false

    public init(_ text: String, content: @escaping () -> Content) {
        self.text = text
        self.content = content
    }

    public var body: some View {
        Button {
            showFilter.toggle()
        } label: {
            HStack {
                Text(text)
                Image(systemName: .chevronUp)
                    .rotationEffect(.degrees(showFilter ? 0 : 180))
            }
            .padding(.horizontal)
            .padding(.vertical, .small)
            .background(.secondarySystemFill)
            .clipShape(Capsule())
            .animation(.default, value: showFilter)
        }
        .buttonStyle(.plain)
        .allowsHitTesting(!showFilter)
        .popover(present: $showFilter) { attributes in
            attributes.dismissal.mode = .tapOutside
        } view: {
            content()
                .card()
        }
    }
}

#if DEBUG
struct FilterButton_Previews: PreviewProvider {


    static private var filterButton: some View {
        FilterButton("Test") {
            VStack {
                Text("Filter content 1")
                Divider()
                Text("Filter content 2")
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    static private var filterButtonRow: some View {
        HStack {
            filterButton
            Spacer()
            filterButton
            Spacer()
            filterButton
        }
    }

    static var previews: some View {
        VStack {
            filterButtonRow
            Spacer()
            filterButtonRow
            Spacer()
            filterButtonRow
        }
        .padding()
    }
}
#endif
