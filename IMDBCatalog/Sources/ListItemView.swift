import SwiftUI

struct ListItemView: View {
    var movie: Movie

    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: movie.coverImageName)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                Text(movie.title)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 6)
                    .background(
                        Rectangle()
                            .fill(Color.black.opacity(0.7))
                    )
                    .cornerRadius(4)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: 100, height: 150)
            .cornerRadius(8)
            Spacer()
        }
        .padding(.vertical, 0)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(movie: Movie(title: "Sample Movie Test With Bigger title", coverImageName: "moviecover", releaseDate: "10-10-2024", overview: "Sample overview", popularity: 10))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
