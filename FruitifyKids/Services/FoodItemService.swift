import Foundation
import FirebaseFirestore
class FoodItemService {
    private let db = Firestore.firestore()
    private let collectionName = "foodItems"
    
    // Create
    func createFoodItem(_ foodItem: FoodItem, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection(collectionName).document(foodItem.id).setData(from: foodItem) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // Read
    func getAllFoodItems(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let foodItems = snapshot?.documents.compactMap { document in
                try? document.data(as: FoodItem.self)
            } ?? []
            
            completion(.success(foodItems))
        }
    }
    
    // Update
    func updateFoodItem(_ foodItem: FoodItem, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection(collectionName).document(foodItem.id).setData(from: foodItem) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // Delete
    func deleteFoodItem(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collectionName).document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getFoodItemByName(_ name: String, completion: @escaping (Result<FoodItem?, Error>) -> Void) {
       let lowercaseName = name
       
       db.collection(collectionName)
         .whereField("name", isEqualTo: lowercaseName)
         .limit(to: 1)
         .getDocuments { snapshot, error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             
             let foodItem = snapshot?.documents.first.flatMap {
                 try? $0.data(as: FoodItem.self)
             }
             
             completion(.success(foodItem))
         }
    }
}
