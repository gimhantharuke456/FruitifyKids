import SwiftUI
import PhotosUI
import FirebaseStorage

struct AddFoodItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminViewModel
    
    @State private var name = ""
    @State private var imageUrl = ""
    @State private var description = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isUploading = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                // Image Selection Section
                Section("Food Image") {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text(selectedImage == nil ? "Select Image" : "Change Image")
                        }
                    }
                }
                
                TextField("Description", text: $description)
                
                Button(action: {
                    if let image = selectedImage {
                        uploadImageAndSaveItem(image: image)
                    }
                }) {
                    if isUploading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Save")
                    }
                }
                .disabled(name.isEmpty || description.isEmpty || selectedImage == nil || isUploading)
            }
            .navigationTitle("Add Food Item")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
    
    private func uploadImageAndSaveItem(image: UIImage) {
        isUploading = true
        
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            print("Could not convert image to data")
            isUploading = false
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("food_images/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")
                isUploading = false
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error)")
                    isUploading = false
                    return
                }
                
                guard let downloadURL = url else {
                    print("Could not get download URL")
                    isUploading = false
                    return
                }
                
                let newItem = FoodItem(
                    name: name,
                    imageUrl: downloadURL.absoluteString,
                    description: description
                )
                
                viewModel.addFoodItem(newItem)
                isUploading = false
                dismiss()
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
