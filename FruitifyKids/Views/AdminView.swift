import SwiftUI

struct AdminView: View {
    @StateObject private var viewModel = AdminViewModel()
    @State private var showingAddForm = false
    
    var body: some View {
        List {
            ForEach(viewModel.foodItems) { item in
                FoodItemRow(
                            item: item,
                            onDelete: {
                                viewModel.deleteFoodItem(id: item.id)
                            },
                            onUpdate: { updatedItem in
                                viewModel.updateFoodItem(updatedItem)
                            }
                        )
            }
        }
        .navigationTitle("Food Items")
        .toolbar {
            Button(action: { showingAddForm = true }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddForm) {
            AddFoodItemView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchFoodItems()
        }
    }
}

// Admin ViewModel
class AdminViewModel: ObservableObject {
    private let service = FoodItemService()
    @Published var foodItems: [FoodItem] = []
    
    func fetchFoodItems() {
        service.getAllFoodItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.foodItems = items
                case .failure(let error):
                    print("Error fetching food items: \(error)")
                }
            }
        }
    }
    
    func addFoodItem(_ item: FoodItem) {
        service.createFoodItem(item) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchFoodItems()
                case .failure(let error):
                    print("Error adding food item: \(error)")
                }
            }
        }
    }
    
    func updateFoodItem(_ item: FoodItem) {
        service.updateFoodItem(item) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchFoodItems()
                case .failure(let error):
                    print("Error updating food item: \(error)")
                }
            }
        }
    }
    
    func deleteFoodItem(id: String) {
        service.deleteFoodItem(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchFoodItems()
                case .failure(let error):
                    print("Error deleting food item: \(error)")
                }
            }
        }
    }
}

#Preview {
    AdminView()
}
