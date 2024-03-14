//
//  ProductCell.swift
//  Inventory
//
//  Created by Himani Gupta on 05/03/24.
//

import SwiftUI

struct ProductCell: View {
    
    @Binding var product: Product
    var body: some View {
        
        HStack(alignment: .center
               , content: {
            AsyncImage(url: URL(string: product.thumbnail ?? "https://thumbnail.jpg")){
                    image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80,height: 60)
                .padding(.horizontal)

       
            VStack(alignment: .leading ,content: {
                Text("\(product.title)").textCase(.uppercase)
                    .font(.system(size: 15))

                Text("Brand: \(product.brand)")
                    .font(.system(size: 15))
                HStack(content:{
                    Text("Price: \(product.price)")
                        .font(.system(size: 12))
                    Text(" (\(product.discountPercentage ?? 0,specifier: "%.2f")% off)")
                        .font(.system(size: 12))
                })
                Text("Rating: \(product.rating ?? 0.0, specifier: "%.1f")")
                    .font(.system(size: 12))
            .multilineTextAlignment(.leading)
            }).padding(.trailing)
    
                

        })
    }

    
}

//#Preview {
//    ProductCell(product: Product(id: 1, title: "iphone", description: "apple iphone", price: 30, discountPercentage: 10.9,rating: 4.2, brand: "apple", category: "smartPhones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg") )
//}
