// MARK: - ShoppingItem Model
struct ShoppingItem: Identifiable {
    let id = UUID()
    var name: String
    var category: String
    var quantity: Int
    var pricePerUnit: Double
}

// MARK: - ShoppingListView
import SwiftUI

struct ShoppingListView: View {
    let listName: String = "Weekly Groceries"
    let numberOfItems: Int = 9
    let totalCost: Double = 59.62
    
    @State private var foodItems: [ShoppingItem] = [
        ShoppingItem(name: "Bread (1)", category: "Food", quantity: 1, pricePerUnit: 8.00),
        ShoppingItem(name: "Meat (1)", category: "Food", quantity: 1, pricePerUnit: 20.50)
    ]
    
    @State private var cleaningItems: [ShoppingItem] = [
        ShoppingItem(name: "Dish Soap (1)", category: "Cleaning", quantity: 1, pricePerUnit: 10.30),
        ShoppingItem(name: "Toilet Cleaner (1)", category: "Cleaning", quantity: 1, pricePerUnit: 7.80),
        ShoppingItem(name: "Sponges (2)", category: "Cleaning", quantity: 2, pricePerUnit: 5.625)
    ]
    
    @State private var fruitsVegItems: [ShoppingItem] = [
        ShoppingItem(name: "Bananas (3)", category: "Fruits & Vegetables", quantity: 3, pricePerUnit: 1.77)
    ]
    
    var body: some View {
        NavigationView {
            // Main background: very light green (close to white)
            Color.green.opacity(0.03)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 0) {
                        
                        // Title
                        HStack {
                            Text("Shopping List")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1)) // Dark green-black
                            Spacer()
                        }
                        .padding([.horizontal, .top])
                        .padding(.bottom, 7)
                        
                        // Subheader
                        VStack(alignment: .leading, spacing: 4) {
                            Text(listName)
                                .font(.title2)
                                .bold()
                            
                            HStack {
                                Text("Number of items: \(numberOfItems)")
                                Spacer()
                                Text("Total cost: $\(totalCost, specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                        
                        // Filter button
                        HStack {
                            Spacer()
                            Button(action: {
                                // Filter logic
                            }) {
                                HStack {
                                    Image(systemName: "line.horizontal.3.decrease.circle")
                                    Text("Filter")
                                }
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.7)) // Dark gray color
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 12)
                        
                        // Scrollable categories
                        ScrollView {
                            VStack(spacing: 1) {
                                CategorySectionView(
                                    icon: "🍽️",
                                    categoryName: "Food",
                                    total: 28.50,
                                    items: $foodItems
                                )
                                
                                CategorySectionView(
                                    icon: "🧽",
                                    categoryName: "Cleaning",
                                    total: 29.35,
                                    items: $cleaningItems
                                )
                                
                                CategorySectionView(
                                    icon: "🍎",
                                    categoryName: "Fruits & Vegetables",
                                    total: 1.77,
                                    items: $fruitsVegItems
                                )
                            }
                            .padding(.top, 8)
                        }
                        
                        // "Add new items" button
                        NavigationLink(destination: AddItemView()) {
                            VStack(spacing: 2) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.1, green: 0.3, blue: 0.1)) // Dark green-black
                                        .frame(width: 40, height: 40)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                Text("Add new items")
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                    .shadow(color: .gray, radius: 1, x: 0, y: 1)
                            }
                        }
                        .padding(.vertical, 0)
                    }
                )
                .navigationBarHidden(true)
        }
    }
}

// MARK: - CategorySectionView with Delete Confirmation
struct CategorySectionView: View {
    let icon: String
    let categoryName: String
    let total: Double
    @Binding var items: [ShoppingItem]
    
    private let darkRed = Color(red: 0.55, green: 0.0, blue: 0.0)
    private let darkGreen = Color(red: 0.0, green: 0.3, blue: 0.0)
    
    // State to show the deletion alert
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Header
            HStack {
                Text("\(icon) \(categoryName)")
                    .font(.headline)
                    .bold()
                Spacer()
                Text("Total : $\(total, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.bottom, 4)
            
            // Items
            VStack(spacing: 0) {
                ForEach($items) { $shoppingItem in
                    NavigationLink(destination: EditItemView(shoppingItem: $shoppingItem)) {
                        HStack {
                            Text(shoppingItem.name)
                                .foregroundColor(darkGreen)
                            Spacer()
                            Text("$\(shoppingItem.pricePerUnit, specifier: "%.2f")")
                                .foregroundColor(darkGreen)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    }
                    if shoppingItem.id != items.last?.id {
                        Divider()
                    }
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // Trash icon with confirmation
            HStack {
                Spacer()
                Button(action: {
                    // Show the delete alert
                    showDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 14))
                        .foregroundColor(darkRed)
                        .padding(.trailing)
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Delete Confirmation"),
                        message: Text("Are you sure you want to delete the \(categoryName) category?"),
                        primaryButton: .destructive(Text("Delete")) {
                            // Actual delete logic goes here
                            print("Deleting \(categoryName) category...")
                            // e.g., remove items from the array, etc.
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}
import SwiftUI

struct EditItemView: View {
    @Binding var shoppingItem: ShoppingItem
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // Calculate costs
        let totalWithoutTax = Double(shoppingItem.quantity) * shoppingItem.pricePerUnit
        let taxRate = 0.13
        let tax = totalWithoutTax * taxRate
        let finalCost = totalWithoutTax + tax
        
        // Very light green background
        Color.green.opacity(0.03)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack(alignment: .leading, spacing: 10) {
                    
                    // Header: Title only, left-aligned (no logo)
                    HStack {
                        Text("Shopping List")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1)) // Dark green-black
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    .padding(.bottom, 7)
                    
                    // Subheading with pencil icon
                    HStack(spacing: 8) {
                        Image(systemName: "pencil.circle")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Edit the item:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                    
                    // Name
                    Text("Name :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    TextField("Item name", text: $shoppingItem.name)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(4)
                    
                    // Category
                    Text("Category :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    TextField("Category", text: $shoppingItem.category)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(4)
                    
                    // Quantity
                    Text("Quantity :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    // Minus / Plus + Text Field
                    HStack(spacing: 0) {
                        // Minus Button
                        Button(action: {
                            if shoppingItem.quantity > 1 {
                                shoppingItem.quantity -= 1
                            }
                        }) {
                            Text("-")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                        }
                        
                        // Divider
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.5))
                        
                        // Quantity Field
                        TextField("", value: $shoppingItem.quantity, formatter: NumberFormatter())
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .frame(width: 50)
                        
                        // Divider
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.5))
                        
                        // Plus Button
                        Button(action: {
                            shoppingItem.quantity += 1
                        }) {
                            Text("+")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(4)
                    
                    // Price / Per unit
                    Text("Price / Per unit :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    TextField("Price", value: $shoppingItem.pricePerUnit, formatter: NumberFormatter.currency)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(4)
                    
                    // Cost Details
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total cost without tax : $\(totalWithoutTax, specifier: "%.2f")")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Text("Tax (\(Int(taxRate * 100))%) : $\(tax, specifier: "%.2f")")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Text("Final : $\(finalCost, specifier: "%.2f")")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 8)
                    
                    // Save & Delete Buttons
                    HStack {
                        Button(action: {
                            // Save logic
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Delete logic
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Delete the Item")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            )
            .navigationBarHidden(true)
    }
}

// MARK: - NumberFormatter Extension
extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}


// MARK: - Preview
struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
