//
//  CategorySectionView.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Implemented UI section for grouped category items, total display with tax, and Core Data deletion per category
//  Kevin Lapointe (Student ID: 101452430) – Verified view rendering and deletion behavior, ensured edit navigation works for each item
//

import SwiftUI

struct CategorySectionView: View {
    let icon: String
    let categoryName: String
    let total: Double
    let items: [ShoppingItemEntity]
    
    private let darkRed = Color(red: 0.55, green: 0.0, blue: 0.0)
    
    @State private var showDeleteAlert = false
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // HEADER: Category icon and name on the left, total (with tax) on the right
            HStack(alignment: .center) {
                HStack(spacing: 8) {
                    Text(icon)
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    Text(categoryName)
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .layoutPriority(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Display pre-calculated total with tax
                Text("Total : $\(total, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .padding(.horizontal)
            .padding(.top, 6)
            
            Divider()
                .padding(.bottom, 4)
            
            // ITEM LIST: Each row is tappable and leads to the EditItemView
            VStack(spacing: 0) {
                ForEach(items, id: \.objectID) { shoppingItem in
                    NavigationLink(destination: EditItemView(shoppingItem: shoppingItem)) {
                        ShoppingItemRowView(item: shoppingItem)
                    }
                    // Add divider between items
                    if shoppingItem != items.last {
                        Divider()
                    }
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // DELETE BUTTON: Deletes all items in the current category
            HStack {
                Spacer()
                Button(action: {
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
                        message: Text("Delete category \"\(categoryName)\"?"),
                        primaryButton: .destructive(Text("Delete")) {
                            // Iterates through items in the category and removes each
                            items.forEach { managedObjectContext.delete($0) }
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print("Failed to delete items: \(error.localizedDescription)")
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}
