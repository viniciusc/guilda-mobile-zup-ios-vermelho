import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: movie.coverImageName)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text(movie.title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            HStack {
                Text("Data de Lançamento: \(formatDate(movie.releaseDate))")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(movie.popularity, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            
            Text(movie.overview)
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.black)
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
        return date
    }
}