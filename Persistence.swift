//
//  PersistenceController.swift
//
//  Mobinasadat Zargary (Student ID: 101472495) – Created Core Data support for initialization.
//  Kevin Lapointe (Student ID: 101452430) – Reviewed code and applied minor adjustments.
//
//  This file sets up the Core Data stack and provides a shared instance used throughout the app.
//  It initializes an NSPersistentContainer for the "smartbasket" data model, loads persistent stores,
//  and sets appropriate context policies to ensure safe data merging during background updates.

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "smartbasket")
        
        // If inMemory is true, use a temporary in-memory store (e.g., for previews or testing).
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Load the persistent store. If an error occurs, stop execution and print details.
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // Conflict resolution strategy: prioritize changes made in memory over persistent ones.
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Automatically merges background context changes into the main context.
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
