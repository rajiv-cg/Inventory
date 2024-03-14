//
//  CategoryViewModel.swift
//  Inventory
//
//  Created by Himani Gupta on 04/03/24.
//

import Foundation

final class CategoryViewModel: ObservableObject {
 
    @Published var categories: [String] = []
    @Published var hasError = false
    @Published private(set) var isRefreshing = false
    @Published var error: Errors?

    func fetchCategories() {
        isRefreshing = true
        hasError = false 
        let categoryUrl = "https://dummyjson.com/products/categories"
        if let url = URL(string: categoryUrl) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.hasError = true
                            self?.error = Errors.custome(error: error)
                        } else {
                            
                            if let data = data, let object = try? JSONSerialization.jsonObject( with: data,options: []) as? [String] {
                                self?.categories = object
                                print("categories: ", self?.categories ?? "no response")
                            } else {
                                self?.hasError = true
                                self?.error = Errors.failedToDecode
                            }
                        }
                        self?.isRefreshing = false
                    }
                
                }.resume()
        }
    }
}

extension CategoryViewModel {
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
