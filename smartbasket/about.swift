import SwiftUI

struct AboutUsView: View{
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("About Us")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top,40)
            }
        }
    }
}
        
    
    struct AboutUsView_Previews: PreviewProvider {
        static var previews: some View {
                AboutUsView()
            }
        }
    




