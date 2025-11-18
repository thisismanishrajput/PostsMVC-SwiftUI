//
//  PostService.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

protocol PostService {
    func fetchPosts() async throws -> [Post]
}

