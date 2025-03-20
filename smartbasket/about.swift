import SwiftUI

struct AboutUsView: View{
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
                ScrollView{
                    VStack(spacing:20){
                        
                        VStack{
                            Text("About Us")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top,30)
                        }
                    }
                       
                        Divider()
                        
                        Text("Welcome to Smart Basket - Your Ultimate Shopping Companion!")
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("At Smart Basket, we believe that shopping should be simple, organized, and enjoyable. Out app is designed to help you manage your shopping lists effortlessly, track your expenses, and categorize your items with ease. Whether you're planning weekly groceries or preparing for a special event, Smart Basket has your covered.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Our Mission")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("To simplify shopping for everyone by offering an intuitive and smart way to create and manage shopping lists. We aim to save you time, reduce the hassle, and help you stay on budget.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Why Choose Smart Basket?")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text("•")
                                    .font(.system(size:30))
                                Text("Organized Shopping: Easily categorize and organize your items by type.")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                            HStack{
                                Text("•")
                                    . font(.system(size:30))
                                Text("Total Cost Tracking: Get real-time calculation of your shopping costs, including taxes.")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                            HStack{
                                Text("•")
                                    . font(.system(size:30))
                                Text("Custom Categories: Personalize your lists with custom categories and items.")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                            HStack{
                                Text("•")
                                    . font(.system(size:30))
                                Text("User-Friendly Design: Simple, clean, and easy to navigate.")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }                        }
                        
                        Divider()
                        
                        Text("Our Vision")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("We strive to become the most trusted shopping assistant, helping people all around the world organize their lives better.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Meet Our Team:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Mobinasadat Zargary")
                        Text("Kevin Lapointe")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                            .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("About Us")
            }
        }
    
    
        struct AboutUsView_Previews: PreviewProvider{
            static var previews: some View {
                AboutUsView()
            }
        }
    




