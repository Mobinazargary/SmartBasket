//
//  smartbasketApp.swift
//  smartbasket
//
//  Created by Mobina Zargary on 2025-03-17.
//

import SwiftUI

@main
struct smartbasketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
