import SwiftUI

struct HomeView: View {
    var body: some View {
        // Wrap everything in a NavigationView to enable NavigationLink
        NavigationView {
            ZStack {
                // Background Color
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.white]),
                               startPoint: .top, endPoint: .center)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 10) {
                    // App Logo & Title
                    VStack {
                        Text("Home Page")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.green)
                            .padding(.top, 20)
                        
                        Text("Welcome to SmartCart! Organize your shopping like never before. Create multiple lists, categorize your items, and track your total cost with tax calculations. Shopping has never been this simple and efficient—let’s get started!")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }

                    // Section Title
                    Text("My Lists:")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color.green)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    
                    // Shopping Lists
                    VStack(spacing: 10) {
                        // 1. Weekly Groceries
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Weekly Groceries", icon: "🛒", count: 18)
                        }
                        
                        // 2. Birthday Party Supplies
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Birthday Party Supplies", icon: "🎉", count: 6)
                        }
                        
                        // 3. Home Essentials
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Home Essentials", icon: "🏡", count: 10)
                        }
                    }
                    .padding(.horizontal)

                    // Create New List Button
                    Button(action: {
                        print("Create new list tapped")
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
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    Spacer()
                }
            }
            // If you want no default NavigationBar:
            .navigationBarHidden(true)
        }
    }
}

// List Item Component
struct ListItem: View {
    var title: String
    var icon: String
    var count: Int

    var body: some View {
        HStack {
            Text("\(icon) \(title)")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
            
            Text("Number of Items: \(count)")
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.5)) // Light textured background
                .shadow(radius: 3)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
