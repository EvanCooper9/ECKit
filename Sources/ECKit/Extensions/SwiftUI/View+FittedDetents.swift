import SwiftUI

@available(iOS 16, *)
public extension View {
    func fittedDetents(defaultDetents: Set<PresentationDetent>? = nil) -> some View {
        FittedDetentsContainer(content: self, defaultDetents: defaultDetents)
    }
}

@available(iOS 16, *)
private struct FittedDetentsContainer<Content: View>: View {
    
    let content: Content
    let defaultDetents: Set<PresentationDetent>?
    
    @State private var contentSize: CGSize?
    private var presentationDetents: Set<PresentationDetent> {
        guard let contentSize else {
            guard let defaultDetents else { return [.height(.zero)] }
            return defaultDetents
        }
        return [.height(contentSize.height)]
    }
    
    var body: some View {
        content
            .readSize { contentSize = $0 }
            .presentationDetents(presentationDetents)
    }
}

#if DEBUG
@available(iOS 16, *)
struct FittedDetents_Previews: PreviewProvider {
    
    private struct Preview: View {
        
        @State private var height: CGFloat = 350
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.blue)
                    .padding(.small)
                Button("Change height") {
                    height = .random(in: 200...500)
                }
            }
            .height(height)
            .fittedDetents()
        }
    }
    
    static var previews: some View {
        Text("Preview")
            .sheet(isPresented: .constant(true), content: Preview.init)
    }
}
#endif
