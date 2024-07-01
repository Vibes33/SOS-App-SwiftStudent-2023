import SwiftUI

struct ImageItem: Identifiable {
    var id = UUID()
    var name: String
    var title: String
}

struct NewsUpdates: View {
    var categoryName: String
    var items: [ImageItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { item in
                        VStack {
                            Image(item.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 155, height: 155)
                                .cornerRadius(5)
                            Text(item.title)
                                .font(.caption)
                        }
                        .padding(.leading, 15)
                    }
                }
            }
            .frame(height: 200)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var items: [ImageItem] = [
        ImageItem(name: "image1", title: "Title 1"),
        ImageItem(name: "image2", title: "Title 2"),
        ImageItem(name: "image3", title: "Title 3")
    ]

    static var previews: some View {
        NewsUpdates(
            categoryName: "July 2023",
            items: items
        )
    }
}
