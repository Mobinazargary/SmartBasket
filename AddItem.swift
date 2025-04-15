//
//  AddItemView.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Integrated Core Data write for adding a new item with error validation and persistent categories, updated view to support list relationships
//  Kevin Lapointe (Student ID: 101452430) – Verified cancellation behavior, UI layout, and category persistence logic
//

import SwiftUI

struct AddItemView: View {
    // The shopping list to which this new item will belong
    let list: ShoppingListEntity
    
    // Input field states
    @State private var name: String = ""
    @State private var selectedCategory: String = "Food"
    @State private var price: String = ""
    @State private var quantity: String = ""
    
    // Category list persisted in AppStorage
    @AppStorage("categoriesList") private var storedCategories: String = "Food,Cleaning,Medication,Fruits & Vegetables,Beverages"
    
    private var categories: [String] {
        storedCategories.split(separator: ",").map { String($0) }
    }
    
    @State private var showNewCategoryField: Bool = false
    @State private var newCategoryName: String = ""
    
    // Error handling
    @State private var errorMessage: String? = nil
    @State private var showError: Bool = false
    
    // Presentation & context
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        Color.green.opacity(0.03)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Header
                    HStack(spacing: 10) {
                        Text("Shopping List")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1))
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
                    // Title under header
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Add new item:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                    
                    // Name input
                    Text("Name :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField("Enter item name", text: $name)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(4)
                    
                    // Category selector with add-new functionality
                    Text("Category :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Menu {
                        ForEach(categories, id: \.self) { cat in
                            Button(action: {
                                selectedCategory = cat
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
                            Text(selectedCategory)
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
                    
                    // New category text input
                    if showNewCategoryField {
                        HStack {
                            TextField("New category name", text: $newCategoryName)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(4)
                            
                            Button(action: {
                                let trimmed = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
                                guard !trimmed.isEmpty else { return }
                                if !categories.contains(trimmed) {
                                    storedCategories = storedCategories + "," + trimmed
                                }
                                selectedCategory = trimmed
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
                    
                    // Price
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
                    
                    // Quantity
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
                    
                    // Save and Cancel actions
                    HStack(spacing: 20) {
                        Button(action: saveItem) {
                            Text("Save")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
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
            .alert(isPresented: $showError) {
                Alert(title: Text("Validation Error"),
                      message: Text(errorMessage ?? ""),
                      dismissButton: .default(Text("OK")))
            }
    }
    
    // Saves the item to the correct list after validating the fields
    private func saveItem() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            errorMessage = "Item name cannot be empty."
            showError = true
            return
        }
        
        guard let quantityVal = Int16(quantity), quantityVal > 0 else {
            errorMessage = "Quantity must be a positive number."
            showError = true
            return
        }
        
        guard let priceVal = Double(price), priceVal >= 0 else {
            errorMessage = "Price must be a valid non-negative number."
            showError = true
            return
        }
        
        let newItem = ShoppingItemEntity(context: managedObjectContext)
        newItem.name = trimmedName
        newItem.category = selectedCategory
        newItem.quantity = quantityVal
        newItem.pricePerUnit = priceVal
        newItem.createdAt = Date()
        newItem.id = UUID()
        newItem.parentList = list  // Establish the relationship to the parent shopping list
        
        do {
            try managedObjectContext.save()
        } catch {
            errorMessage = "Failed to save new item: \(error.localizedDescription)"
            showError = true
            return
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddItemView(list: ShoppingListEntity())
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
