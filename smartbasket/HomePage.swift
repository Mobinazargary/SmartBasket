import SwiftUI

struct HomeView: View {
    
    // Define dark green-black color
    private let darkGreenBlack = Color(red: 0.1, green: 0.2, blue: 0.1)
    
    // Controls the sheet for creating a new list
    @State private var showCreatePopup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
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
                    
                    // App Title
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

                    // Section Title
                    Text("My Lists:")
                        .font(.headline)
                        .bold()
                        .foregroundColor(darkGreenBlack)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    // Shopping Lists
                    VStack(spacing: 20) {
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Weekly Groceries", icon: "🛒", count: 18)
                        }
                        
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Birthday Party Supplies", icon: "🎉", count: 6)
                        }
                        
                        NavigationLink(destination: ShoppingListView()) {
                            ListItem(title: "Home Essentials", icon: "🏡", count: 10)
                        }
                    }
                    .padding(.horizontal)

                    // Create New List Button
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

                    // About Us Link (dark green-black hyperlink style)
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .font(.headline)
                            .foregroundColor(darkGreenBlack)
                            .underline() // Give it a hyperlink look
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - List Item Component
struct ListItem: View {
    var title: String
    var icon: String
    var count: Int
    
    // Dark green-black for "Number of Items"
    private let darkGreenBlack = Color(red: 0.1, green: 0.2, blue: 0.1)

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // First line: icon + title
            HStack(spacing: 6) {
                Text(icon)
                Text(title)
            }
            .font(.headline)
            .bold()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Second line: "Number of Items"
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

// MARK: - Minimal popup
struct CreateNewListPopup: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newListName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a New List")
                .font(.title)
                .bold()
                .padding(.top, 20)
            
            TextField("Enter list name", text: $newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

// MARK: - AboutUsView placeholder
struct AboutUs: View {
    var body: some View {
        Text("About Us Page Here")
            .font(.title)
            .navigationBarTitle("About Us", displayMode: .inline)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
