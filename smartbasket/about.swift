import SwiftUI

struct AboutUsView: View {
    
    // Dark green-black color for titles
    private let darkGreenBlack = Color(red: 0.1, green: 0.4, blue: 0.1)
    
    // For dismissing this view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Light gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.green.opacity(0.3),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .center
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Custom Back Button + Title
                HStack {
                    Button(action: {
                        // Dismiss this view (go back to Home)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.headline)
                        .foregroundColor(darkGreenBlack)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Scrollable content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // About Us Title
                        Text("About Us")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(darkGreenBlack)
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        // Introduction
                        Text("Welcome to Smart Basket - Your Ultimate Shopping Companion!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(darkGreenBlack)
                            .multilineTextAlignment(.leading)
                        
                        Text("""
At Smart Basket, we believe that shopping should be simple, organized, and enjoyable. Our app is designed to help you manage your shopping lists effortlessly, track your expenses, and categorize your items with ease.
""")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        // Why Choose Smart Basket?
                        Text("Why Choose Smart Basket?")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(darkGreenBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Organized Shopping: Easily categorize and organize your items by type.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Total Cost Tracking: Get real-time calculation of your shopping costs, including taxes.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Custom Categories: Personalize your lists with custom categories and items.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Divider()
                        
                        // Meet Our Team
                        Text("Meet Our Team:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(darkGreenBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Mobinasadat Zargary")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        Text("Kevin Lapointe")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        // Extra space at bottom
                        Spacer().frame(height: 40)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
            }
        }
        // Hide default nav bar
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutUsView()
        }
    }
}
