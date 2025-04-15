//
//  EditItemView.swift
//  smartbasket
//
//  Author: Mobina Zargary (Student ID: 101472495)
//  Edited by: Mobinasadat Zargary – Updated to support Core Data editing with validation and a dropdown for categories using temporary state variables
//             Kevin Lapointe – Validated cost calculation and comments
//
import SwiftUI

struct EditItemView: View {
    // Observing the existing managed object.
    @ObservedObject var shoppingItem: ShoppingItemEntity
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    // Persisted categories via AppStorage.
    @AppStorage("categoriesList") private var storedCategories: String = "Food,Cleaning,Medication,Fruits & Vegetables,Beverages"
    
    private var categories: [String] {
        storedCategories.split(separator: ",").map { String($0) }
    }
    
    // Temporary local state to hold edits.
    @State private var tempName: String = ""
    @State private var tempCategory: String = ""
    @State private var tempPrice: Double = 0.0
    @State private var tempQuantity: Int16 = 1
    
    // State for showing the inline add-new-category field.
    @State private var showNewCategoryField: Bool = false
    @State private var newCategoryName: String = ""
    
    // Error validation state.
    @State private var errorMessage: String? = nil
    @State private var showError: Bool = false
    
    var body: some View {
        // Calculate cost details using temporary values.
        let totalWithoutTax = Double(tempQuantity) * tempPrice
        let taxRate = 0.13
        let tax = totalWithoutTax * taxRate
        let finalCost = totalWithoutTax + tax
        
        Color.green.opacity(0.03)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    // Header
                    HStack {
                        Text("Shopping List")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1))
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    .padding(.bottom, 7)
                    
                    // Subheading with pencil icon.
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
                    
                    // Name Field
                    Text("Name :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    TextField("Item name", text: $tempName)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(4)
                    
                    // Category Field with Dropdown Menu
                    Text("Category :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Menu {
                        ForEach(categories, id: \.self) { cat in
                            Button(action: {
                                tempCategory = cat
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
                            Text(tempCategory.isEmpty ? "Select category" : tempCategory)
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
                            TextField("New category", text: $newCategoryName)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(4)
                            Button("Add") {
                                let trimmed = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
                                guard !trimmed.isEmpty else { return }
                                if !categories.contains(trimmed) {
                                    // Append new category to persistent storage.
                                    storedCategories = storedCategories + "," + trimmed
                                }
                                tempCategory = trimmed
                                newCategoryName = ""
                                showNewCategoryField = false
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .cornerRadius(4)
                        }
                    }
                    
                    // Quantity Section with Minus/Plus Buttons
                    Text("Quantity :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    HStack(spacing: 0) {
                        Button(action: {
                            if tempQuantity > 1 {
                                tempQuantity -= 1
                            }
                        }) {
                            Text("-")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                        }
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.5))
                        Text("\(tempQuantity)")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 50)
                            .multilineTextAlignment(.center)
                        Divider()
                            .frame(height: 40)
                            .background(Color.white.opacity(0.5))
                        Button(action: {
                            tempQuantity += 1
                        }) {
                            Text("+")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(4)
                    
                    // Price Field for Price Per Unit
                    Text("Price / Per unit :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    TextField("Price",
                              value: $tempPrice,
                              formatter: NumberFormatter.currency)
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
                        Button(action: saveChanges) {
                            Text("Save")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        Button(action: {
                            managedObjectContext.delete(shoppingItem)
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print("Delete failed: \(error.localizedDescription)")
                            }
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
            .alert(isPresented: $showError) {
                Alert(title: Text("Validation Error"),
                      message: Text(errorMessage ?? ""),
                      dismissButton: .default(Text("OK")))
            }
        .onAppear {
            // Initialize temporary state with current object values.
            tempName = shoppingItem.name ?? ""
            tempCategory = shoppingItem.category ?? "Food"
            tempPrice = shoppingItem.pricePerUnit
            tempQuantity = shoppingItem.quantity
        }
    }
    
    private func saveChanges() {
        let trimmedName = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            errorMessage = "Item name cannot be empty."
            showError = true
            return
        }
        // Update the managed object with temporary values.
        shoppingItem.name = trimmedName
        shoppingItem.category = tempCategory
        shoppingItem.pricePerUnit = tempPrice
        shoppingItem.quantity = tempQuantity
        
        guard shoppingItem.quantity > 0 else {
            errorMessage = "Quantity must be a positive number."
            showError = true
            return
        }
        guard shoppingItem.pricePerUnit >= 0 else {
            errorMessage = "Price must be a non-negative number."
            showError = true
            return
        }
        do {
            try managedObjectContext.save()
            managedObjectContext.refreshAllObjects()
        } catch {
            errorMessage = "Failed to save changes: \(error.localizedDescription)"
            showError = true
            return
        }
        // Ensure changes are committed before dismissing.
        DispatchQueue.main.async {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(shoppingItem: ShoppingItemEntity())
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
