//
//  PostServiceImpl.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

final class PostServiceImpl: PostService {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchPosts() async throws -> [Post] {
        let (data, response) = try await networkClient.request(endpoint: "posts", method: "GET", queryItems: nil, headers: nil, body: nil)
        
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode([Post].self, from: data)
    }
}

