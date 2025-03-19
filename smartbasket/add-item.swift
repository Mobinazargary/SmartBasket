import SwiftUI

struct AddItemView: View{
    @State private var name: String = ""
    @State private var category: String = "Select Category"
    @State private var price: String = ""
    @State private var quantity: String = ""
    
    let categories = ["Food", "Cleaning", "Medication", "Fruits and Vegetables", "Beverages"]
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Item Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Select Category: \(category)", selection: $category){
                Text("Select Category").tag("Select Category")
                
                ForEach(categories, id: \.self){
                    category in Text(category).tag(category)
                }
            }
                .pickerStyle(.menu)
                .padding()
            
                TextField("Price", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                
                HStack {
                    Button(action: saveItem){
                        Text("Save")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                    
                    Button(action: cancelAction){
                        Text("Cancel")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                }
                
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Add Item")
        }
        
        private func saveItem(){
            print("Item Saved: \(name), Category: \(category), Price: \(price), Quantity: \(quantity)")
        }
        private func cancelAction(){
            name = ""
            category = "Select Category"
            price = ""
            quantity = ""
        }
    }
    
    struct AddItemView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                AddItemView()
            }
        }
    }

