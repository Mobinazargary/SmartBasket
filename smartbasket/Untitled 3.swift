import Foundation

struct ShoppingList: Identifiable {
    let id = UUID()
    let name: String
    let numberOfItems: Int
    let totalCost: Double
}
