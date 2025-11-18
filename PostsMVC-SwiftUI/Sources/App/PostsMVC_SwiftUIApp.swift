//
//  PostsMVC_SwiftUIApp.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import SwiftUI

@main
struct PostsMVC_SwiftUIApp: App {
    // Compose dependencies and inject into controller
       init() {
           // Configure service locator / DI at startup
           let networkClient = NetworkClient(baseURL: URL(string: "https://jsonplaceholder.typicode.com")!)
           
           // add interceptors
           networkClient.addInterceptor(LoggingInterceptor())
           networkClient.addInterceptor(RetryInterceptor(retryCount: 2))

           let postService = PostServiceImpl(networkClient: networkClient)
           ServiceLocator.shared.register(service: postService as PostService)
       }

       var body: some Scene {
           WindowGroup {
               let controller = PostsController(postService: ServiceLocator.shared.resolve()!)
               PostsListView(controller: controller)
           }
       }
}
