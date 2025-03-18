import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeView() // Replace with your actual home screen view
        } else {
            VStack {
                Spacer()
                
                // App Logo
                Image("smartbasket_logo") // Add your logo to Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200) // Adjust size as needed
                
                // App Title
                Text("SMART BASKET")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(.darkGray))
                    .padding(.top, 8)
                
                // Tagline
                Text("DIGITAL SHOPPING LIST")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Slogan
                Text("“Your Shopping Made Smarter”")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(.darkGray))
                    .padding(.bottom, 4)
                
                // Developer Credits
                Text("Built by Mobinasadat Zargary & Kevin Lapointe")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                
                Text("Lapointe")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true // Navigate to HomeView after 2 seconds
                }
            }
        }
    }
}

// **Preview**
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
