import SwiftUI
import UIKit

public struct CameraPicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
    @Binding var imageData: Data?

    public init(imageData: Binding<Data?>) {
        _imageData = imageData
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraPicker>) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

public extension CameraPicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.imageData = uiImage.fixedOrientation.pngData()
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
