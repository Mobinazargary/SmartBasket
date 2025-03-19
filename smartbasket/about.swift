import SwiftUI

struct AboutUsView: View{
    var body: some View {
        
                ScrollView{
                    VStack(spacing:20){
                        Text("About Us")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top,40)
                        
                        Divider()
                        
                        Text("Welcome to Smart Basket - Your Ultimate Shopping Companion!")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Our Mission")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("To simplify shopping for everyone by offering an intuitive and smart way to create and manage shopping lists. We aim to save you time, reduce the hassle, and help you stay on budget.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Why Choose Smart Basket?")
                            .font(.headline)
                            .fontWeight(.semibold)
                    
                        
                        Text("Total Cost Tracking: Get real-time calculation of your shopping costs, including taxes.")
                        Text("Custom Categories: Personalize your lists with custom categories and items.")
                        Text("User-Friendly Design: Simple, clean, and easy to navigate.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Divider()
                        
                        Text("Our Vision")
                            .font(.headline)
                            .fontWeight(.semibold)
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
    




