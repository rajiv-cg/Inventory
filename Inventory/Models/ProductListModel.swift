//
//  ProductListView.swift
//  Inventory
//
//  Created by Himani Gupta on 04/03/24.
//

import Foundation

struct ProductListModel: Codable {
    
    let products: [Product]
}

struct Product: Codable {
    
    let id: Int
    let title: String
    let description: String?
    let price: Int
    let discountPercentage: Double?
    let rating: Double?
    let brand: String
    let category: String?
    let thumbnail: String?

    
}

struct DeleteProduct: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Int?
    var discountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var brand: String?
    var category: String?
    var thumbnail: String?
    var isDeleted: Bool?
    var deletedOn: String?
}
