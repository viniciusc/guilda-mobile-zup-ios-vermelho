import SwiftUI

struct SeriesListItemView: View {
    var serie: MediaItem

    var body: some View {
        NavigationLink(destination: SeriesDetailView(serie: serie)) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: serie.coverImageName)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                }
                Text(serie.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    .padding([.leading, .bottom], 10)
            }
            .cornerRadius(10)
            .shadow(color: .white, radius: 5)
        }
    }
}

struct SeriesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListItemView(serie: MediaItem(
            title: "Sample Series", 
            coverImageName: "https://via.placeholder.com/500", backdropImageName: "https://via.placeholder.com/500",
            releaseDate: "2023-10-01",
            overview: "This is a sample overview of the series.",
            popularity: 8.5
        ))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
