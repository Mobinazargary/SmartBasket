import SwiftUI

/*
 File: SplashScreenView.swift
 Mobinasadat Zargary – Student ID: 101472495 – Designed splash screen layout and timed transition to HomeView.
 Kevin Lapointe – Student ID: 101452430 – Added internal documentation and verified UI behavior.

 Description:
    Displays the splash screen with a logo, slogan, and developer credits.
    After a 2-second delay, this screen transitions to HomeView.
*/

struct SplashScreenView: View {
    // Controls whether to show the HomeView or remain on the splash screen.
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeView() // Display the main HomeView after splash delay.
        } else {
            // Background with overlay content (logo, slogan, credits).
            Color.green.opacity(0.03)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 8) {
                        Image("smartbasket_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 500)
                        
                        Text("“Your Shopping Made Smarter”")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.4))
                            .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                        
                        Text("Built by Mobinasadat Zargary & Kevin Lapointe")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.4))
                            .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                        
                        Spacer()
                    }
                )
                .onAppear {
                    // Automatically switch to HomeView after 2 seconds.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isActive = true
                    }
                }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
