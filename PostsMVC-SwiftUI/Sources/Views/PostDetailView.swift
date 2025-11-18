//
//  PostDetailView.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post

       var body: some View {
           VStack(alignment: .leading, spacing: 16) {
               Text(post.title)
                   .font(.title2)
                   .bold()
               Text("By user: \(post.userId)")
                   .font(.caption)
                   .foregroundColor(.secondary)
               Divider()
               ScrollView {
                   Text(post.body)
                       .font(.body)
               }
               Spacer()
           }
           .padding()
           .navigationTitle("Post")
       }
}


