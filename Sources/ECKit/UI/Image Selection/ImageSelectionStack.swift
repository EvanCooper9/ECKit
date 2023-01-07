import SwiftUI

public struct ImageSelectionStack: View {

    @Binding var imageDatas: [Data]
    let max: Int
    
    @State private var internalImageDatas: [Data?]

    public init(imageDatas: Binding<[Data]>, max: Int) {
        internalImageDatas = Array(repeating: Data?.none, count: max)
        _imageDatas = imageDatas
        self.max = max
        
        internalImageDatas.insert(contentsOf: imageDatas.wrappedValue, at: 0)
        for _ in 0..<(max - internalImageDatas.count) {
            internalImageDatas.append(nil)
        }
    }

    public var body: some View {
        HStack {
            ForEach(0..<max, id: \.self) { index in
                let binding: Binding<Data?> = .init {
                    internalImageDatas[index]
                } set: {
                    internalImageDatas[index] = $0
                }

                ImageSelectionView(imageData: binding)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .onChange(of: internalImageDatas) { imageDatas = $0.compactMap { $0 } }
    }
}

struct ImageSelectionStack_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectionStack(imageDatas: .constant([]), max: 3)
            .padding()
    }
}
