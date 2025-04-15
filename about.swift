//
//  AboutUsView.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Created the UI layout and content sections for About Us, including app overview and team section
//  Kevin Lapointe (Student ID: 101452430) – Improved view dismissal interaction and verified layout responsiveness
//

import SwiftUI

struct AboutUsView: View {
    
    // Custom dark green-black used for major titles and accents
    private let darkGreenBlack = Color(red: 0.1, green: 0.4, blue: 0.1)
    
    // Used to dismiss this view from a navigation context
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Background gradient from green to white
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.white]),
                startPoint: .top,
                endPoint: .center
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Custom back button
                HStack {
                    Button(action: {
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
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("About Us")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(darkGreenBlack)
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        // Welcome message
                        Text("Welcome to Smart Basket - Your Ultimate Shopping Companion!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(darkGreenBlack)
                        
                        Text("""
At Smart Basket, shopping becomes easier and more organized. This app is designed to help users manage shopping lists, track total costs, and simplify everyday errands.
""")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        Divider()
                        
                        // Key features section
                        Text("Why Choose Smart Basket?")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(darkGreenBlack)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Organized Shopping: Categorize and group your items clearly.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Total Cost Tracking: Calculates costs in real time, including taxes.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.system(size: 22))
                                    .foregroundColor(darkGreenBlack)
                                Text("Custom Categories: Add and personalize categories as needed.")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Divider()
                        
                        // Team member credits
                        Text("Meet Our Team:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(darkGreenBlack)
                        
                        Text("Mobinasadat Zargary")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        Text("Kevin Lapointe")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        Spacer().frame(height: 40)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutUsView()
        }
    }
}
