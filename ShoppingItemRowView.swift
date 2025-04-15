//
//  ShoppingItemRowView.swift
//  smartbasket
//
//  Mobinasadat Zargary (Student ID: 101472495) – Created this component to display individual shopping items.
//  Kevin Lapointe (Student ID: 101452430) – Reviewed styling choices and formatting for readability.
//
//  This view displays a single row for a shopping item, showing the name, quantity, and price per unit.
//  It is designed to be reused within a list or section showing multiple shopping items.

import SwiftUI
import CoreData

struct ShoppingItemRowView: View {
    // Observes changes to this individual shopping item.
    @ObservedObject var item: ShoppingItemEntity

    // Custom color for text.
    private let darkGreen = Color(red: 0.0, green: 0.3, blue: 0.0)

    var body: some View {
        HStack {
            // Left side: item name with quantity in parentheses.
            Text("\(item.name ?? "Unnamed") (x\(item.quantity))")
                .foregroundColor(darkGreen)
                .lineLimit(1)
                .truncationMode(.tail)
                .layoutPriority(1)
            
            Spacer()
            
            // Right side: price per unit with currency formatting.
            Text("$\(item.pricePerUnit, specifier: "%.2f")")
                .foregroundColor(darkGreen)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}
