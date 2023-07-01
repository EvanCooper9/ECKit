import SwiftUI

public struct CustomListSection<Content: View, Header: View, Footer: View>: View {

    @ViewBuilder private let content: () -> Content
    @ViewBuilder private let header: (() -> Header)?
    @ViewBuilder private let footer: (() -> Footer)?

    @Environment(\.colorScheme) private var colorScheme

    private var background: Color {
        switch colorScheme {
        case .dark:
            return .secondarySystemBackground
        case .light:
            return .systemBackground
        @unknown default:
            return .systemBackground
        }
    }

    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder header: @escaping (() -> Header), @ViewBuilder footer: @escaping (() -> Footer)) {
        self.content = content
        self.header = header
        self.footer = footer
    }

    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder header: @escaping (() -> Header)) where Footer == EmptyView {
        self.content = content
        self.header = header
        self.footer = nil
    }

    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder footer: @escaping (() -> Footer)) where Header == EmptyView {
        self.content = content
        self.header = nil
        self.footer = footer
    }

    public init(@ViewBuilder content: @escaping () -> Content) where Header == EmptyView, Footer == EmptyView {
        self.content = content
        self.header = nil
        self.footer = nil
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if let header {
                header()
                    .foregroundColor(.secondaryLabel)
                    .font(.footnote)
                    .textCase(.uppercase)
                    .padding(.leading)
            }

            VStack(spacing: 0) {
                Divided {
                    content()
                        .padding(.vertical, 4)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 4)
                .padding(.leading)
            }
            .padding(.vertical, 4)
            .background(background)
            .cornerRadius(10)


            if let footer {
                footer()
                    .foregroundColor(.secondaryLabel)
                    .font(.footnote)
                    .padding(.leading)
            }
        }
        .padding()
    }
}

#if DEBUG
struct ScrollViewListSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollView {
                CustomListSection {
                    Text("Content 1")
                    Text("Content 2")
                    Text("Content 3")
                } header: {
                    Text("Header")
                } footer: {
                    Text("Footer")
                }
            }
            .maxWidth(.infinity)
            .background(.secondarySystemBackground)

            List {
                Section {
                    Text("Content 1")
                    Text("Content 2")
                    Text("Content 3")
                } header: {
                    Text("Header")
                } footer: {
                    Text("Footer")
                }
            }
        }
    }
}
#endif
