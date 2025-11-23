//
//  Post.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

