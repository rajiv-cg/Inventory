//
//  ProductView.swift
//  TestProject
//
//  Created by Himani Gupta on 05/03/24.
//

import SwiftUI

struct ProductView: View {
    @StateObject private var vm = ProductListViewModel()
    @State var presentingModal = false
    let selectedCategory: String
    @State var isUpdate: Bool = true
    
    var body: some View {
        ZStack {
            if vm.isRefreshing {
                ProgressView()
            } else {
                List($vm.productList, id: \.id) { $product in
                    NavigationLink {
                        ProductDetailView(product: $product, productList: $vm.productList, navigationTitle: product.title)
                    } label: {
                        ProductCell(product: $product)
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.visible, edges: .all)
                    .swipeActions {
                        Button(role: .destructive) {
                            vm.deleteProductWith(productId: product.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }.accessibilityIdentifier("products list")
            }
        }
        .alert(isPresented: $vm.hasError,
               error: vm.error) {
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }
            Button {
                vm.fetchProductList(selectedCategory: selectedCategory)
            } label: {
                Text("Retry")
            }
        }
               .sheet(isPresented: $presentingModal) {
                   AddProductView(selectedCategory: selectedCategory,
                                  vm: vm,
                                  presentedAsModal: self.$presentingModal).accessibilityIdentifier("Add product")
               }
               .navigationTitle("Products")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           presentingModal = true
                           print("button pressed")
                       }) {
                           Image(systemName: "plus")
                       }
                   }
               }
               .onAppear(perform: {
                   if isUpdate {
                       vm.fetchProductList(selectedCategory: selectedCategory )
                       self.isUpdate = false
                   }
                   
               })
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(presentingModal: false, selectedCategory: "smartphones")
    }
}
