//
//  PostsListView.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var controller: PostsController

       var body: some View {
           NavigationView {
               Group {
                   if controller.isLoading {
                       ProgressView("Loading...")
                   } else if let err = controller.errorMessage {
                       VStack(spacing: 16) {
                           Text("Error: \(err)").multilineTextAlignment(.center)
                           Button("Retry") {
                               controller.refresh()
                           }
                       }.padding()
                   } else {
                       List(controller.posts) { post in
                           NavigationLink(destination: PostDetailView(post: post)) {
                               VStack(alignment: .leading, spacing: 6) {
                                   Text(post.title)
                                       .font(.headline)
                                       .lineLimit(2)
                                   Text(post.body)
                                       .font(.subheadline)
                                       .foregroundColor(.secondary)
                                       .lineLimit(2)
                               }.padding(.vertical, 6)
                           }
                       }
                       .listStyle(PlainListStyle())
                   }
               }
               .navigationTitle("Posts")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           controller.refresh()
                       }, label: {
                           Image(systemName: "arrow.clockwise")
                       })
                   }
               }
           }
           .task {
               await controller.fetchPosts()
           }
       }
}

