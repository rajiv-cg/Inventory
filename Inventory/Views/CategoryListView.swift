//
//  ContentView.swift
//  Inventory
//
//  Created by Himani Gupta on 04/03/24.
//

import SwiftUI

struct CategoryListView: View {
    
    @StateObject private var vm = CategoryViewModel()
    
    let colors = [.white, Color(white: 0.95)]
    
    var body: some View {
        
        NavigationView {
            if vm.isRefreshing {
                ProgressView()
            } else {
                List(vm.categories, id: \.self) { category in
                    NavigationLink {
                        ProductView(selectedCategory: category)
                    } label: {
                        Text(category)
                    }
                }
                .navigationTitle("Categories")
            }
        }
        .onAppear(perform: {
            vm.fetchCategories()
        })
        .alert(isPresented: $vm.hasError,
               error: vm.error) {
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }
            Button {
                vm.fetchCategories()
            } label: {
                Text("Retry")
            }
        }
    }
}

//#Preview {
//    CategoryListView()
//}
