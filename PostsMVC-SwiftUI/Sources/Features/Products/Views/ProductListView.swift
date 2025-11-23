//
//  ProductListView.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 23/11/25.
//

import SwiftUI
import SwiftUI

struct ProductListView: View {
    @ObservedObject var controller: ProductController
    
    var body: some View {
        NavigationView {
            Group {
                if controller.isLoading {
                    ProgressView("Loading...")
                } else if let err = controller.errorMessage {
                    VStack(spacing: 16) {
                        Text("Error: \(err)")
                        Button("Retry") { controller.refresh() }
                    }.padding()
                } else {
                    List(controller.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.title)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { controller.refresh() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .task {
            await controller.fetchProducts()
        }
    }
}

