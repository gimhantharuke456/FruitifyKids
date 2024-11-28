import SwiftUI
import FirebaseStorage
struct FoodItemRow: View {
    let item: FoodItem
    let onDelete: () -> Void
    let onUpdate: (FoodItem) -> Void
    
    @State private var showingDeleteAlert = false
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: item.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .cornerRadius(10)
                    .overlay(
                        ProgressView()
                    )
            }
            
            Text(item.name)
                .font(.headline)
            
            Text(item.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    print("Edit called")
                    showingEditSheet = true
                }) {
                    Label("Edit", systemImage: "pencil")
                        .foregroundColor(.blue)
                }
                .frame(width: 100, height: 40)
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    print("Delete called")
                    showingDeleteAlert = true
                }) {
                    Label("Delete", systemImage: "trash")
                        .foregroundColor(.red)
                }
                .frame(width: 100, height: 40)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
        .alert("Delete Item", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to delete '\(item.name)'?")
        }
        .sheet(isPresented: $showingEditSheet) {
            EditFoodItemView(item: item, onUpdate: onUpdate)
        }
    }
}

struct EditFoodItemView: View {
    let item: FoodItem
    let onUpdate: (FoodItem) -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var description: String
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isUploading = false
    
    init(item: FoodItem, onUpdate: @escaping (FoodItem) -> Void) {
        self.item = item
        self.onUpdate = onUpdate
        _description = State(initialValue: item.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Item Name") {
                    Text(item.name)
                        .foregroundColor(.gray)
                }
                
                Section("Food Image") {
                    AsyncImage(url: URL(string: item.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    
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
                            Text("Change Image")
                        }
                    }
                }
                
                Section("Description") {
                    TextField("Description", text: $description)
                }
                
                Section {
                    Button(action: updateItem) {
                        if isUploading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Update")
                        }
                    }
                    .disabled(description.isEmpty || isUploading)
                }
            }
            .navigationTitle("Edit Food Item")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
    
    private func updateItem() {
        if let image = selectedImage {
            isUploading = true
            uploadImage(image) { result in
                switch result {
                case .success(let url):
                    let updatedItem = FoodItem(
                        id: item.id,
                        name: item.name,
                        imageUrl: url,
                        description: description
                    )
                    onUpdate(updatedItem)
                    isUploading = false
                    dismiss()
                    
                case .failure(let error):
                    print("Error uploading image: \(error)")
                    isUploading = false
                }
            }
        } else {
            let updatedItem = FoodItem(
                id: item.id,
                name: item.name,
                imageUrl: item.imageUrl,
                description: description
            )
            onUpdate(updatedItem)
            dismiss()
        }
    }
    
    private func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not convert image to data"])))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("food_images/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not get download URL"])))
                    return
                }
                
                completion(.success(downloadURL.absoluteString))
            }
        }
    }
}
