import SwiftUI

struct AddItemView: View {
    // MARK: - State Variables
    @State private var name: String = ""
    @State private var category: String = "Food"
    @State private var price: String = ""
    @State private var quantity: String = ""
    
    @State private var categories: [String] = ["Food", "Cleaning", "Medication", "Fruits & Vegetables", "Beverages"]
    @State private var showNewCategoryField: Bool = false
    @State private var newCategoryName: String = ""
    
    // Dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // Main background: very light green (close to white)
        Color.green.opacity(0.03)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Header with only title, left-aligned
                    HStack(spacing: 10) {
                        Text("Shopping List")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1)) // Dark green-black
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom,15)
                    
                    // Subheading with plus icon
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Add new item:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                    // Thin separator line
                    Divider()
                    
                    // Name Field
                    Text("Name :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField("Enter item name", text: $name)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(8)
                        // Very light gray for the field background
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(4)
                    
                    // Category
                    Text("Category :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Menu {
                        ForEach(categories, id: \.self) { cat in
                            Button(action: {
                                category = cat
                            }) {
                                Text(cat)
                            }
                        }
                        Divider()
                        Button(action: {
                            showNewCategoryField = true
                        }) {
                            Label("Add new category", systemImage: "plus")
                        }
                    } label: {
                        HStack {
                            Text(category)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(4)
                    }
                    
                    if showNewCategoryField {
                        HStack {
                            TextField("New category name", text: $newCategoryName)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(4)
                            
                            Button(action: {
                                guard !newCategoryName.isEmpty else { return }
                                categories.append(newCategoryName)
                                category = newCategoryName
                                newCategoryName = ""
                                showNewCategoryField = false
                            }) {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.green)
                                    .cornerRadius(4)
                            }
                        }
                    }
                    
                    // Price Field
                    Text("Price :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField("Enter price", text: $price)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .keyboardType(.decimalPad)
                        .padding(8)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(4)
                    
                    // Quantity Field
                    Text("Quantity :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField("Enter quantity", text: $quantity)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                        .padding(8)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    // Save & Cancel Buttons
                    HStack(spacing: 20) {
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
                            // Cancel logic
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.bottom, 100)
                }
                .padding(.horizontal, 20)
            )
            .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddItemView()
        }
    }
}
