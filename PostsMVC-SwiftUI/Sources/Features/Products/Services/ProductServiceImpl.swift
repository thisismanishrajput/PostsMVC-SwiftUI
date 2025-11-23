//
//  ProductServiceImpl.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 23/11/25.
//

import Foundation

final class ProductServiceImpl:ProductService {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol){
        self.networkClient = networkClient
    }
    
    func fetchProducts() async throws -> ProductResponse {
        let (data, response ) = try await networkClient.request(endpoint: "products", method: "GET", queryItems: nil, headers: nil, body: nil)
        
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else{
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(ProductResponse.self, from: data)
        
    }
    
}
