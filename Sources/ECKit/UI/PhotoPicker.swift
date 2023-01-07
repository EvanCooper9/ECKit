import Photos
import PhotosUI
import SwiftUI

public struct PhotoPicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    @Binding private var imageData: Data?

    public init(imageData: Binding<Data?>) {
        _imageData = imageData
    }

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.preferredAssetRepresentationMode = .current
        configuration.filter = .images
        configuration.selectionLimit = 1

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

public extension PhotoPicker {
    class Coordinator: PHPickerViewControllerDelegate {

        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }
                self.parent.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.async {
                    self.parent.imageData = (object as? UIImage)?.fixedOrientation.jpegData(compressionQuality: 0.25)
                }
            }
        }
    }
}
