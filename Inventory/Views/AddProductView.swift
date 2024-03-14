//
//  AddProductView.swift
//  TestProject
//
//  Created by Maiti Soumi on 07/03/24.
//

import SwiftUI

struct AddProductView: View {
    @State private var productName: String = ""
    @State private var brand: String = ""
    @State private var price: Int = 0
    @State private var description: String = ""
    @State private var discount: Double = 0.0
    let selectedCategory: String

    @StateObject var vm: ProductListViewModel
    @Binding var presentedAsModal: Bool

    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading, content: {
                    Text("Model:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 5.0)
                    TextField("Model", text: $productName)
                        .font(.system(size: 15))
                        .padding(.all, 5.0)
                        .border(Color.gray, width: 1)
                        .frame(alignment: .top)
                    Text("Brand Name:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 5.0)

                    TextField("Brand", text: $brand)
                        .font(.system(size: 15))
                        .padding(.all, 5.0)
                        .border(Color.gray, width: 1)
                    Text("Price:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 5.0)

                    TextField("₹10000", value: $price, formatter: NumberFormatter())
                        .font(.system(size: 15))
                        .padding(.all, 5.0)
                        .border(Color.gray, width: 1)
                    Text("Discount:")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 5.0)

                    TextField("%", value: $discount, formatter: NumberFormatter())
                        .font(.system(size: 15))
                        .padding(.all, 5.0)
                        .border(Color.gray, width: 1)

                    Text("Please enter Description:")
                        .font(.system(size: 15))
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 5.0)

                    TextEditor(text: $description)
                        .font(.system(size: 15))
                        .padding(.all, 5.0)
                        .border(Color.gray, width: 1)
                        .frame(height: 100)
                    //Spacer()

                })
                .padding()

                VStack(alignment: .center, content: {
                    Button(action: {
                        print("Save")
                        self.presentedAsModal = false
                        let parameters: [String: Any] = [
                              "title": productName,
                              "brand": brand,
                              "price": Int(price),
                              "discountPercentage": Double(discount),
                              "description": description,
                              "thumbnail": "https://thumbnail.jpg"
                          ]

                        vm.addProduct(parameters: parameters, category: selectedCategory)
                    }, label: {
                        Text("Save")
                    })
                })
                
            }
        }
        .navigationTitle("Add Product")
    }
}

//#Preview {
//    AddProductView(selectedCategory: "Furniture", presentedAsModal: .constant(true))
//}
