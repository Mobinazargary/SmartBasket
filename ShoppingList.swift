
//
//  ShoppingListView.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Implemented dynamic totals, inline filter field, layout fixes,
//  filtered fetch based on the selected list, and added live update handling via refreshID.
//  Kevin Lapointe (Student ID: 101452430) – Reviewed zero-state handling, verified scroll grouping by category,
//  and helped validate filtering and UI refresh logic.
//
import SwiftUI
import CoreData

struct ShoppingListView: View {
    // The selected ShoppingListEntity passed from the Home page.
    let list: ShoppingListEntity

    // Access to Core Data context.
    @Environment(\.managedObjectContext) private var managedObjectContext

    // Fetch items that belong to this specific list only.
    @FetchRequest private var allItems: FetchedResults<ShoppingItemEntity>

    // Search filter input from user.
    @State private var filterText: String = ""

    // State used to trigger full view refresh.
    @State private var refreshID = UUID()

    // Calculate total quantity of all items in this list (sum of all item quantities).
    private var computedNumberOfItems: Int {
        filteredItems.reduce(0) { $0 + Int($1.quantity) }
    }

    // Calculate total cost including 13% tax.
    private var computedTotalCost: Double {
        filteredItems.reduce(0) { $0 + (Double($1.quantity) * $1.pricePerUnit * 1.13) }
    }

    // Filtered list of items based on search input.
    private var filteredItems: [ShoppingItemEntity] {
        allItems.filter { item in
            if filterText.isEmpty { return true }
            let matchesCategory = (item.category?.localizedCaseInsensitiveContains(filterText)) ?? false
            let matchesName = (item.name?.localizedCaseInsensitiveContains(filterText)) ?? false
            return matchesCategory || matchesName
        }
    }

    // Track changes in key fields to force UI update.
    private var refreshMonitor: String {
        allItems.map { "\($0.name ?? "")\($0.category ?? "")\($0.quantity)\($0.pricePerUnit)" }
            .joined(separator: ",")
    }

    // Custom initializer to apply fetch predicate based on parent list.
    init(list: ShoppingListEntity) {
        self.list = list

        let request = NSFetchRequest<ShoppingItemEntity>(entityName: "ShoppingItemEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        request.predicate = NSPredicate(format: "parentList == %@", list.objectID)

        _allItems = FetchRequest<ShoppingItemEntity>(fetchRequest: request)
    }

    var body: some View {
        NavigationView {
            Color.green.opacity(0.03)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 0) {
                        // Header Section
                        HStack {
                            Text("Shopping List")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.1))
                            Spacer()
                        }
                        .padding([.horizontal, .top])
                        .padding(.bottom, 7)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(list.title ?? "Untitled List")
                                .font(.title2)
                                .bold()

                            HStack {
                                Text("Number of items: \(computedNumberOfItems)")
                                Spacer()
                                Text("Total cost: $\(computedTotalCost, specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)

                        // Search field
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Filter items...", text: $filterText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                            if !filterText.isEmpty {
                                Button(action: { filterText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)

                        Divider().padding(.horizontal)

                        // Group items by category and render CategorySectionView for each group
                        ScrollView {
                            let groupedItems = Dictionary(
                                grouping: filteredItems,
                                by: { ($0.category ?? "Uncategorized").trimmingCharacters(in: .whitespacesAndNewlines) }
                            )
                            let sortedCategoryKeys = groupedItems.keys.sorted { key1, key2 in
                                let date1 = groupedItems[key1]?.first?.createdAt ?? Date.distantPast
                                let date2 = groupedItems[key2]?.first?.createdAt ?? Date.distantPast
                                return date1 < date2
                            }

                            LazyVStack(spacing: 16) {
                                ForEach(sortedCategoryKeys, id: \.self) { categoryKey in
                                    if let itemsForCategory = groupedItems[categoryKey] {
                                        let categoryTotal = itemsForCategory.reduce(0.0) {
                                            $0 + (Double($1.quantity) * $1.pricePerUnit * 1.13)
                                        }
                                        CategorySectionView(
                                            icon: iconForCategory(categoryKey),
                                            categoryName: categoryKey,
                                            total: categoryTotal,
                                            items: itemsForCategory
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Add Item Navigation Button
                        NavigationLink(destination: AddItemView(list: list)) {
                            VStack(spacing: 2) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.1, green: 0.3, blue: 0.1))
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
                    .id(refreshID)
                )
                .navigationBarHidden(true)
                .onChange(of: refreshMonitor) { _ in
                    refreshID = UUID()
                }
        }
    }
}

// Icon helper based on category.
func iconForCategory(_ category: String) -> String {
    switch category {
    case "Food": return "🍽️"
    case "Cleaning": return "🧽"
    case "Fruits & Vegetables": return "🍎"
    case "Medication": return "💊"
    default: return "🛒"
    }
}
