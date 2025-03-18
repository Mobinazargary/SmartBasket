import SwiftUI

@main
struct smartbasketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView() // 🔹 Set SplashScreenView as the initial screen
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
