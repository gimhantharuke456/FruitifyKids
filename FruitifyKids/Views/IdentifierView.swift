import SwiftUI
import CoreML
import Vision
import PhotosUI

struct IdentifierView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var predictedLabel: String = ""
    @State private var isImageSelected: Bool = false
    @State private var showBottomSheet: Bool = false
    @State private var selectedFoodItem: FoodItem?
    let model: FruitImageClassifier = {
        // Load the Core ML model
        do {
            let configuration = MLModelConfiguration()
            return try FruitImageClassifier(configuration: configuration)
        } catch {
            fatalError("Couldn't load model: \(error)")
        }
    }()

    var body: some View {
 
            ZStack {
                // Background image
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    Spacer()
                    
                    // "Let's Find" Button
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Let's Find!")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 80)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.blue)
                                    .shadow(radius: 10)
                            )
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrieve selected asset
                            guard let selectedItem else { return }
                            // Retrieve selected asset’s data
                            if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                                self.selectedImageData = data
                                self.isImageSelected = true
                                self.predictLabel(from: data)
                            }
                        }
                    }
                    .buttonStyle(.bouncy)
                    
                    Spacer()
                    
                    // Admin Button
                    NavigationLink(destination: AdminLoginView()) {
                        Text("I am Admin")
                            .font(.system(size: 18, design: .rounded))
                            .foregroundColor(.gray)
                            .padding()
                            .background(
                                Capsule()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding(.bottom, 20)
                }
                
                // Bottom Sheet for Predicted Label
                if showBottomSheet, let foodItem = selectedFoodItem  {
                    VStack {
                        Spacer()
                        VStack {
                            AsyncImage(url: URL(string: foodItem.imageUrl)) { image in
                                        image.resizable().scaledToFit().frame(height: 200)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(foodItem.name)
                                        .font(.title2)
                                    Text(foodItem.description)
                                        .font(.body)
                                        .padding()
                                    Button("Close") {
                                        showBottomSheet = false
                                    }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding()
                    }
                    .ignoresSafeArea()
                }
            }
        
    }

    func predictLabel(from imageData: Data) {
        guard let model = try? VNCoreMLModel(for: self.model.model) else {
            print("Failed to load the CoreML model.")
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Prediction failed: \(error.localizedDescription)")
                return
            }
            guard let observations = request.results as? [VNClassificationObservation],
                          let topPrediction = observations.first else {
                        print("No results found.")
                        return
                    }
            let predictedFruit = topPrediction.identifier
                    
                    // Fetch food item details
                    FoodItemService().getFoodItemByName(predictedFruit) { result in
                        switch result {
                        case .success(let foodItem):
                            DispatchQueue.main.async {
                                self.predictedLabel = predictedFruit
                                self.selectedFoodItem = foodItem
                                self.showBottomSheet = true
                            }
                        case .failure(let error):
                            print("Error fetching food item: \(error)")
                        }
                    }
        }

        // Convert the selected image to the required format (CGImage)
        guard let image = UIImage(data: imageData)?.cgImage else {
            print("Unable to convert UIImage to CGImage.")
            return
        }

        // Perform the classification request on the image
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        try? handler.perform([request])
    }
}

#Preview {
    IdentifierView()
}
