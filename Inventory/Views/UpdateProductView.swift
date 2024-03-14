//
//  UpdateProductView.swift
//  Inventory
//
//  Created by Himani Gupta on 12/03/24.
//

import SwiftUI

struct UpdateProductView: View {
    
    @State private var title = ""
    @State private var brandName = ""
    @State private var price = "0"
    @State private var discount = "0.00"
    @State private var description = ""

    @Binding var product: Product
    @ObservedObject private var viewModel = ProductListViewModel()
    @Binding var presentedAsModal: Bool
    @Binding var productList: [Product]
    @Binding var navigationTitle : String

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                LabeledTextField(title: "Model", placeholder: "Model", text: $title)
                LabeledTextField(title: "Brand Name", placeholder: "Brand", text: $brandName)
                LabeledTextField(title: "Price", placeholder: "Price", text: $price)
                    .keyboardType(.decimalPad)
                
                LabeledTextField(title: "Discount", placeholder: "Discount", text: $discount)
                    .keyboardType(.phonePad)
                LabeledTextView(title: "Description", placeholder: "Description", text: $description)
                    .frame(height: 150.0)
                Button(action: {
                                   // Action for the button
                    let parameters: [String: Any] = [
                          "title": title,
                          "brand": brandName,
                          "price": Int(price) ?? 0,
                          "discountPercentage": Double(discount) ?? 0.00,
                          "description": description
                      ]
                    self.presentedAsModal = false
                    viewModel.updateProducts(parameters: parameters, selectedProductId: product.id, productList: productList)
                               }) {
                                   Text("Submit")
                                       .font(.title2)
                                       .foregroundColor(.blue)
                                       .padding()
                                       //.background(Color.blue)
                                       .cornerRadius(8)
                                   
                        }
                               .onReceive(viewModel.$product) { updatedProduct in
                                    // Handle the updated product data here
                                    if let updatedProduct = updatedProduct {
                                        print("Updated Product: \(updatedProduct)")
                                        product = updatedProduct
                                        navigationTitle = updatedProduct.title
                                    }
                                }
                               .onReceive(viewModel.$productList) { productList in
                                   // Handle the updated product list here
                                   print("Updated Product List: \(productList)")
                                   
                               }
                Spacer()
            }.onAppear{
                //viewModel.fetchProducts()
                // Set data from the product model
                title = product.title 
                brandName = product.brand 
                price = "$ \(product.price )"
                discount = "\(product.discountPercentage ?? 0.0) %"
                description = product.description ?? ""
            }
            .navigationTitle("Update Product")
            .padding(.top, 30)
            .padding(.horizontal)
        }
    }
}

//struct AddProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProductView()
//    }
//}
