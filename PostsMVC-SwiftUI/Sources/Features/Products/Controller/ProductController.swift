//
//  ProductController.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 23/11/25.
//

import Foundation
import Combine

final class ProductController: ObservableObject{
    @Published private(set) var products: [Product] = []
    @Published var productResponse: ProductResponse? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let productService: ProductService
    private var cancellables: Set<AnyCancellable> = []
    
    init(productService: ProductService){
        self.productService = productService
    }
    
    @MainActor
    func fetchProducts() async{
        isLoading = true
        errorMessage = nil
        
        do{
            let fetched = try await productService.fetchProducts()
            products = fetched.products
            productResponse = fetched
        }catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    // helper to refresh
       func refresh() {
           Task {
               await fetchProducts()
           }
       }
    
}
