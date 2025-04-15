//
//  HomeView.swift

//  Edited by: Mobinasadat Zargary (Student ID: 101472495)
//  - Integrated Core Data fetch functionality into HomeView
//  - Replaced horizontal scrolling with vertical List view
//  - Added swipe-to-delete support for lists
//  - Calculated item count based on quantity, not item count
//  - Removed icon usage from lists
//  - Added layout structure and color customization
//
//  Verified by: Kevin Lapointe (Student ID: 101412312)
//  - Confirmed navigation to ShoppingListView
//  - Reviewed swipe actions and Core Data binding logic
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    // Color used across header and buttons
    private let darkGreenBlack = Color(red: 0.1, green: 0.2, blue: 0.1)
    
    // Toggle state for showing the create-list popup
    @State private var showCreatePopup = false
    
    // Core Data context
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    // Fetch shopping lists in reverse chronological order
    @FetchRequest(
        entity: ShoppingListEntity.entity(),
        sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]
    ) private var shoppingLists: FetchedResults<ShoppingListEntity>
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.green.opacity(0.4),
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .center
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Top section: title and intro
                    VStack {
                        Text("Home Page")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(darkGreenBlack)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        Text("""
Welcome to SmartCart! Organize your shopping like never before. Create multiple lists, categorize your items, and track your total cost with tax calculations. Shopping has never been this simple and efficient—let’s get started!
""")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                    }
                    
                    // Section header
                    Text("My Lists:")
                        .font(.headline)
                        .bold()
                        .foregroundColor(darkGreenBlack)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    // List of ShoppingListEntity shown vertically
                    List {
                        ForEach(shoppingLists, id: \.self) { list in
                            NavigationLink(destination: ShoppingListView(list: list)) {
                                // Show total quantity of items instead of just number of entries
                                ListItem(
                                    title: list.title ?? "Untitled List",
                                    count: (list.items as? Set<ShoppingItemEntity>)?.reduce(0) { $0 + Int($1.quantity) } ?? 0
                                )
                            }
                            // Swipe to delete gesture
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteList(list)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle()) // Removes default list styling
                    
                    // Button to create a new list
                    Button(action: {
                        showCreatePopup = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                            Text("Create new list")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(darkGreenBlack)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .sheet(isPresented: $showCreatePopup) {
                        CreateNewListPopup()
                    }
                    
                    // About Us navigation link
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .font(.headline)
                            .foregroundColor(darkGreenBlack)
                            .underline()
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Deletes a ShoppingListEntity from Core Data
    private func deleteList(_ list: ShoppingListEntity) {
        managedObjectContext.delete(list)
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete list: \(error.localizedDescription)")
        }
    }
}

// MARK: - List Display Component
struct ListItem: View {
    var title: String
    var count: Int
    
    private let darkGreenBlack = Color(red: 0.1, green: 0.2, blue: 0.1)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Number of Items: \(count)")
                .font(.subheadline)
                .foregroundColor(darkGreenBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 300, height: 55, alignment: .leading)
        .padding()
        .background(
            GeometryReader { geo in
                Image("greenTexture-2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
            }
        )
        .padding(.bottom, 10)
    }
}

// MARK: - Preview for Xcode Canvas
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
