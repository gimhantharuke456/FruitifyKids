import Foundation
import FirebaseFirestore

// Food Item Model
struct FoodItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var imageUrl: String
    var description: String
}
