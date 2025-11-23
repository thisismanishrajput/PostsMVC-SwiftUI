import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(product.title)
                    .font(.title)
                    .bold()
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                Spacer(minLength: 0)
            }
            .padding()
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // If `Product` has a memberwise initializer, update this preview accordingly.
    // Fallback to a mock to keep previews working without knowing the exact Product init.
    struct MockProduct: Identifiable {
        let id: UUID
        let title: String
        let description: String
    }
    let mock = MockProduct(id: UUID(), title: "Sample Product", description: "This is a sample product description used for preview.")

    // Adapter view to map MockProduct into ProductDetailView if Product cannot be instantiated.
    return Group {
        // Attempt to compile-time use Product if an initializer exists.
        // Commented placeholder:
        // ProductDetailView(product: Product(id: mock.id, title: mock.title, description: mock.description))

        // Preview using a lightweight stand-in UI to visualize layout
        VStack(alignment: .leading) {
            Text("ProductDetailView Preview Placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(mock.title)
                        .font(.title)
                        .bold()
                    Text(mock.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle(mock.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
