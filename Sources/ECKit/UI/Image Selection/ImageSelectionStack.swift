import SwiftUI

public struct ImageSelectionStack: View {

    @Binding var imageDatas: [Data]
    let max: Int

    public init(imageDatas: Binding<[Data]>, max: Int) {
        _imageDatas = imageDatas
        self.max = max
    }

    public var body: some View {
        HStack {
            ForEach(0..<max, id: \.self) { index in
                let binding: Binding<Data?> = .init {
                    guard imageDatas.count > index else { return nil }
                    return imageDatas[index]
                } set: { data in
                    if let data {
                        if imageDatas.count > index {
                            imageDatas.insert(data, at: index)
                        } else {
                            imageDatas.append(data)
                        }
                    } else {
                        imageDatas.remove(at: index)
                    }
                }

                ImageSelectionView(imageData: binding)
            }
        }
    }
}

struct ImageSelectionStack_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectionStack(imageDatas: .constant([]), max: 3)
            .padding()
    }
}
