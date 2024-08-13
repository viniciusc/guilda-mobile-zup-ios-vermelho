import SwiftUI

struct SeriesDetailView: View {
    var serie: MediaItem

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: serie.backdropImageName)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text(serie.title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Text("Release Date: \(serie.releaseDateFormatted)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding([.leading, .trailing, .bottom])
            
            Text(serie.overview)
                .font(.body)
                .foregroundColor(.white)
                .padding([.leading, .trailing, .bottom])
            
            Spacer()
        }
        .background(Color.black)
        .navigationTitle(serie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SeriesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailView(serie: MediaItem(
            title: "Sample Series",
            coverImageName: "https://via.placeholder.com/500",
            backdropImageName: "https://via.placeholder.com/500", // Sample backdrop image
            releaseDate: "2023-10-01",
            overview: "This is a sample overview of the series.",
            popularity: 8.5
        ))
    }
}
