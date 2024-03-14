//
//  ProductDetailView.swift
//  Inventory
//
//  Created by Himani Gupta on 05/03/24.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var isPresentingUpdateProductView = false
    @Binding var product: Product
    @Binding var productList: [Product]
    @State var presentingModal = false
    @State var navigationTitle = ""
    @State private var isWebViewPresented = false
    @State private var selectedImageURL: URL?
    @State private var isLoading = false

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing, content: {
                Button(action: {
                                   // Set the selected image URL and present the WebView
                                   if let thumbnailURLString = product.thumbnail, let thumbnailURL = URL(string: thumbnailURLString) {
                                       selectedImageURL = thumbnailURL
                                       isWebViewPresented.toggle()
                                   }
                }) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .padding(.horizontal)
                    }
                }
                Text("Ratings: " + String(format: "%.2f", product.rating ?? 0.00))
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .offset(x: -5, y: -5)
            })
            
            Text(product.description ?? "")
                .padding()
            
            HStack(content:{
                Text("Brand: \(product.brand)")
                    .font(.system(size: 15))
                    .bold()
                
                HStack(content:{
                    Text("|  Price: \(product.price)")
                        .font(.system(size: 15))
                        .bold()
                    Text("(\(product.discountPercentage ?? 0.00, specifier: "%.2f")% off)")
                        .font(.system(size: 15))
                        .foregroundStyle(.red)
                })
            })
            
            Spacer()
        }
        .navigationTitle ($navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
            isPresentingUpdateProductView.toggle()
            presentingModal = true
        }) {
            Text("Edit")
        }
        )
        .sheet(isPresented: $presentingModal) {
            UpdateProductView(product: $product, presentedAsModal: self.$presentingModal, productList: $productList, navigationTitle: $navigationTitle)
            
        }.sheet(isPresented: $isWebViewPresented) {
            if let selectedImageURL = selectedImageURL {
                WebView(url: selectedImageURL, isLoading: isLoading)
            }
        }.onAppear {
            print(self.productList.count)
        }
    }

}

//#Preview {
//    ProductDetailView()
//}
