import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeView()
        } else {
            // Light green background with an overlay
            Color.green.opacity(0.03)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 8) {
                        // App Logo
                        Image("smartbasket_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 500) d
                        
                        // Slogan
                        Text("“Your Shopping Made Smarter”")
                            .font(.system(size: 18, weight: .bold))
                            // Example greenish-gray color + subtle shadow
                            .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.4))
                            .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                        
                        // Developer Credits
                        Text("Built by Mobinasadat Zargary & Kevin Lapointe")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(red: 0.4, green: 0.45, blue: 0.4))
                            .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                        
                        Spacer() // Pushes everything up
                    }
                )
                .onAppear {
                    // Navigate to HomeView after 2 seconds
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
