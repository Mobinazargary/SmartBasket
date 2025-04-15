//
//  CreateNewListPopup.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Added Core Data write functionality to allow users to create new lists from the popup
//  Kevin Lapointe (Student ID: 101452430) – Reviewed dismiss logic and verified button actions and text field handling
//
import SwiftUI

struct CreateNewListPopup: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var managedObjectContext

    @State private var newListName: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create a New List")
                .font(.title)
                .bold()
                .padding(.top, 20)

            // Input field for the name of the new shopping list
            TextField("Enter list name", text: $newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)

            HStack {
                // Cancel button: dismisses the popup without saving
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }

                // Save button: creates a new list entity and saves to Core Data
                Button(action: {
                    guard !newListName.isEmpty else { return }

                    let newList = ShoppingListEntity(context: managedObjectContext)
                    newList.title = newListName
                    // Removed default icon assignment from database
                    newList.itemCount = 0
                    newList.createdAt = Date()

                    do {
                        try managedObjectContext.save()
                    } catch {
                        print("Failed to save new list: \(error.localizedDescription)")
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 40)

            Spacer()
        }
    }
}

// MARK: - Preview
struct CreateNewListPopup_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewListPopup().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
