import SwiftUI

struct AddItemView: View{
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Item Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Category", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Price", text: $price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            TextField("Quantity", text: $quantity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
        
                
        }
    }
    
}

