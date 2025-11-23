//
//  PostsController.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation
import Combine

final class PostsController: ObservableObject {
    // MVC: Controller holds state, orchestrates service calls and transforms data for the View
    @Published private(set) var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let postService: PostService
    private var cancellables = Set<AnyCancellable>()

    init(postService: PostService) {
        self.postService = postService
    }

    @MainActor
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetched = try await postService.fetchPosts()
            posts = fetched
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    // helper to refresh
    func refresh() {
        Task {
            await fetchPosts()
        }
    }
}

