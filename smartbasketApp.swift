import SwiftUI

/*
 File: smartbasketApp.swift
 Mobinasadat Zargary – Student ID: 101472495 – Set up SmartBasket app with Core Data integration and splash screen entry point.
 Kevin Lapointe – Student ID: 101452430 – Updated app structure to support shared persistence controller and view context injection.

 Description:
   Main entry point for the SmartBasket application. It connects the Core Data stack
   through PersistenceController and loads the initial view, which is SplashScreenView.
*/

@main
struct smartbasketApp: App {
    // Shared Core Data persistence controller used throughout the app.
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
