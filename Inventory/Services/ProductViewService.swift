//
//  ProductViewService.swift
//  SwiftUIDemo
//
//  Created by Mayur Rangari on 07/03/24.
//

import Foundation




protocol ProductViewServiceDelegate {
    func fetchProducts(url: String, completion: @escaping(Result<ProductListModel, DemoError>) -> Void)
    func updateProducts(url: String, parameters: [String:Any], completion: @escaping(Result<Product, DemoError>) -> Void)
    func addProducts(url: String, parameters: [String:Any], completion: @escaping(Result<Product, DemoError>) -> Void)
    func deleteProducts(url: String, completion: @escaping(Result<DeleteProduct, DemoError>) -> Void)

}

class ProductViewService: ProductViewServiceDelegate  {
    func fetchProducts(url: String, completion: @escaping(Result<ProductListModel, DemoError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        NetworkManager().fetchRequest(type: ProductListModel.self, url: url, completion: completion)
    }
    
    func updateProducts(url: String, parameters: [String:Any], completion: @escaping(Result<Product, DemoError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        
        NetworkManager().updateRequest(type: Product.self, url: url,requestType: RequestType.PUT, parameters: parameters, completion: completion)
    }
    
    func addProducts(url: String, parameters: [String:Any], completion: @escaping(Result<Product, DemoError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        
        NetworkManager().updateRequest(type: Product.self, url: url,requestType: RequestType.POST, parameters: parameters, completion: completion)
    }
    func deleteProducts(url: String, completion: @escaping(Result<DeleteProduct, DemoError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        
        NetworkManager().updateRequest(type: DeleteProduct.self, url: url,requestType: RequestType.DELETE, parameters: [:], completion: completion)

        
    }
}
