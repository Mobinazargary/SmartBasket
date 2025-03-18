import SwiftUI

struct ShoppingListView: View {
    // Hardcoded data matching your screenshot
    let listName: String = "Weekly Groceries"
    let numberOfItems: Int = 10
    let totalCost: Double = 74.85
    
    var body: some View {
        VStack(spacing: 0) {
            // Title
            HStack {
                Text("Shopping List")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                Spacer()
            }
            .padding([.horizontal, .top])
            
            // Subheader: List name, number of items, total cost
            VStack(alignment: .leading, spacing: 4) {
                Text(listName)
                    .font(.title2)
                    .bold()
                HStack {
                    Text("Number if items: \(numberOfItems)")
                    Spacer()
                    Text("Total cost: $\(totalCost, specifier: "%.2f")")
                }
                .font(.subheadline)
            }
            .padding(.horizontal)
            .padding(.top, 4)
            
            // Filter button (top-right)
            HStack {
                Spacer()
                Button(action: {
                    // Filter logic here
                }) {
                    HStack {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                        Text("Filter")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 4)
            
            // Scrollable area for categories & items
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Category: Food
                    CategorySectionView(
                        categoryName: "Food",
                        total: 28.50,
                        items: [
                            ("Bread", 8.00),
                            ("Meat (1)", 20.50)
                        ]
                    )
                    
                    // Category: Cleaning
                    CategorySectionView(
                        categoryName: "Cleaning",
                        total: 29.35,
                        items: [
                            ("Dish Soap (1)", 10.30),
                            ("Toilet Cleaner (1)", 7.80),
                            ("Sponges (2)", 11.25)
                        ]
                    )
                    
                    // Category: Fruits & Vegetables
                    CategorySectionView(
                        categoryName: "Fruits & Vegetables",
                        total: 6.50,
                        items: [
                            ("Lettuce (1)", 6.50),
                            ("Bananas (3)", 5.30)
                        ]
                    )
                }
                .padding(.top, 8)
            }
            
            // Add new items button
            Button(action: {
                // Add item logic
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add new items")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
        }
        .navigationBarHidden(true) // Hide default nav bar if desired
    }
}

// MARK: - Category Section View
struct CategorySectionView: View {
    let categoryName: String
    let total: Double
    let items: [(String, Double)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Category header
            HStack {
                Text(categoryName)
                    .font(.headline)
                    .bold()
                Spacer()
                Text("Total : $\(total, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            // Items
            ForEach(items, id: \.0) { item in
                HStack {
                    Text(item.0)
                    Spacer()
                    Text("$\(item.1, specifier: "%.2f")")
                }
                .padding(.horizontal)
            }
            
            Divider()
        }
    }
}

// MARK: - Preview
struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShoppingListView()
        }
    }
}
