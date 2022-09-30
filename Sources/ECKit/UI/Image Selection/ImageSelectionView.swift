import SwiftUI

public struct ImageSelectionView: View {

    public enum Source: String, CustomStringConvertible, Identifiable {
        case camera = "Camera"
        case library = "Library"

        public var id: RawValue { rawValue }
        public var description: String { rawValue }
    }

    @Binding private var imageData: Data?
    @State private var promptImageAction = false
    @State private var promptImageSource = false
    @State private var showImage = false
    @State private var showLibraryPicker = false
    @State private var showCameraPicker = false
    private let sources: [Source]

    public init(imageData: Binding<Data?>, sources: [Source] = [.camera, .library]) {
        _imageData = imageData
        self.sources = sources
    }

    public var body: some View {
        image
            .onTapGesture {
                if imageData == nil {
                    if sources.count > 1 {
                        promptImageSource.toggle()
                    } else {
                        switch sources.first {
                        case .camera:
                            showCameraPicker.toggle()
                        case .library:
                            showLibraryPicker.toggle()
                        case .none:
                            break
                        }
                    }
                } else {
                    promptImageAction.toggle()
                }
            }
            .confirmationDialog("View", isPresented: $promptImageAction) {
                Button("View") { showImage.toggle() }
                Button("Change") { promptImageSource.toggle() }
                Button("Delete", role: .destructive) { imageData = nil }
            }
            .confirmationDialog("View", isPresented: $promptImageSource) {
                ForEach(sources) { source in
                    Button(source.description) {
                        switch source {
                        case .camera:
                            showCameraPicker.toggle()
                        case .library:
                            showLibraryPicker.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $showImage) {
                if let imageData, let image = Image(data: imageData) {
                    ZStack {
                        Color.black
                            .maxWidth(.infinity)
                            .maxHeight(.infinity)
                            .ignoresSafeArea()
                        image
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    ProgressView()
                }
            }
            .sheet(isPresented: $showLibraryPicker) {
                PhotoPicker(imageData: $imageData)
            }
            .sheet(isPresented: $showCameraPicker) {
                CameraPicker(imageData: $imageData).ignoresSafeArea()
            }
    }

    @ViewBuilder
    private var image: some View {
        if let imageData {
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    Image(data: imageData)?
                        .resizable()
                        .scaledToFill()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: .photo)
                    .foregroundColor(.gray.opacity(0.2))
                    .font(.largeTitle)
                    .padding(5)
                Image(systemName: .plusCircleFill)
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5], dashPhase: 0))
            }
        }
    }
}

struct ImageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectionView(imageData: .constant(nil))
            .padding()
    }
}
