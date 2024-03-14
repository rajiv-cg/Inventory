//
//  ProductListViewModel.swift
//  Inventory
//
//  Created by Himani Gupta on 04/03/24.
//

import Foundation
import SwiftUI
final class ProductListViewModel: ObservableObject {
    
    @Published var product: Product?
    @Published var productList: [Product] = []
    @Published var hasError = false
    @Published var error: Errors?
    @Published private(set) var isRefreshing = false
    @Published private(set) var showsAlert = false


    let serviceHandler: ProductViewServiceDelegate
    init(serviceHandler: ProductViewServiceDelegate = ProductViewService()) {
        self.serviceHandler = serviceHandler
    }
    
   func fetchProductList(selectedCategory: String) {
        isRefreshing = true
        hasError = false
        let productListUrl = "https://dummyjson.com/products/category/" + selectedCategory
        print("productListUrl",productListUrl)
       
       serviceHandler.fetchProducts(url: productListUrl) { result in
           DispatchQueue.main.async{
               switch result {
               case .success(let data):
                   self.productList = data.products 
               case .failure(_):
                   self.isError()
               }
               self.isRefreshing = false
           }
       }
    }
    
    func isError() {
        self.hasError = true
        self.error = Errors.failedToDecode
    }
    
    func hasCustomError(error: Error) {
        self.hasError = true
        self.error = Errors.custome(error: error)
    }
    
    //POST
    func addProduct(parameters: [String:Any], category: String) {
        isRefreshing = true
        hasError = false

        let url = "https://dummyjson.com/products/add"
        
        serviceHandler.addProducts(url: url, parameters: parameters) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let data):
                    self.productList.append(data)
                case .failure(_):
                    self.isError()
                }
                self.isRefreshing = false
            }
        }
    }
    
    func deleteProductWith(productId: Int) {
        isRefreshing = true
        hasError = false

        let deleteProductUrl = "https://dummyjson.com/products/" + String(productId)
        serviceHandler.deleteProducts(url: deleteProductUrl) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let data):
                    if let isProductDeleted = data.isDeleted, isProductDeleted == true {
                        self.deleteProduct(withID: productId)
                        self.showsAlert = true
                    } else{
                        self.showsAlert = false
                    }
                case .failure(_):
                    self.isError()
                }
                self.isRefreshing = false
            }
        }
    }
    
    func deleteProduct(withID id: Int?) {
        if let index = productList.firstIndex(where: { $0.id == id }) {
            productList.remove(at: index)
            print("After Deletion: \(productList)")
        }
    }
    
    func updateProducts(parameters: [String:Any], selectedProductId: Int, productList: [Product]) {
        isRefreshing = true
        hasError = false
       let url = "https://dummyjson.com/products/\(selectedProductId)"
        serviceHandler.updateProducts(url: url, parameters: parameters) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let data):
                    self.replaceProduct(withID: data.id, newProduct: data, productList: productList)
                case .failure(_):
                    print("Something wrong")
                }
            }
        }
    }
    
    func replaceProduct(withID id: Int?, newProduct: Product, productList: [Product]) {
        self.product = newProduct
        self.productList = productList

            if let index = productList.firstIndex(where: { $0.id == id }) {
                self.productList[index] = newProduct
                print(productList)
               // self.productList = productList
            }
        }
}

extension ProductListViewModel {
    enum Errors: LocalizedError {
        case custome(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .custome(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Failed to decode"
            }
        }
    }
}
