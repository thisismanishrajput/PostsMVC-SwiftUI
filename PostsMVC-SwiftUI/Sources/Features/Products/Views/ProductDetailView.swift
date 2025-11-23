import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 16) {
                       
                       // Network Image
                       AsyncImage(url: URL(string: product.thumbnail)) { image in
                           image
                               .resizable()
                               .scaledToFit()
                       } placeholder: {
                           ProgressView()
                       }
                       .frame(height: 250)
                       .cornerRadius(12)
                       
                       Text(product.title)
                           .font(.title)
                           .bold()

                       Text(product.description)
                           .font(.body)
                           .foregroundColor(.secondary)
                   }
                   .padding()
               }
               .navigationTitle(product.title)
               .navigationBarTitleDisplayMode(.inline)
    }
}

