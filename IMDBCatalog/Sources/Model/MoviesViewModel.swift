import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published var topRatedMovies: [MediaItem] = []
    @Published var upcomingMovies: [MediaItem] = []
    @Published var nowPlayingMovies: [MediaItem] = []

    private var cancellables = Set<AnyCancellable>()
    //private let apiKey = "6843df26f45e3eed2352b62f54747473" // Replace with your actual API key

    func fetchMovies() {
        fetchMovies(for: .movieTopRated) { [weak self] movies in
            self?.topRatedMovies = movies
        }
        fetchMovies(for: .movieUpcoming) { [weak self] movies in
            self?.upcomingMovies = movies
        }
        fetchMovies(for: .movieNowPlaying) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
    }

    private func fetchMovies(for category: MediaItemCategory, completion: @escaping ([MediaItem]) -> Void) {
        guard let url = category.url else { return }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MoviesResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { response in
                let baseURL = "https://image.tmdb.org/t/p/w500"
                let movies = response.results.map {
                    MediaItem(
                        title: $0.title,
                        coverImageName: "\(baseURL)\($0.posterPath)",
                        backdropImageName: "\(baseURL)\($0.backdropPath)",
                        releaseDate: $0.releaseDate,
                        overview: $0.overview,
                        popularity: $0.popularity
                    )
                }
                completion(movies)
            })
            .store(in: &cancellables)
    }
}

enum MediaItemCategory {
    case movieTopRated
    case movieUpcoming
    case movieNowPlaying
    case serie
    
    var url: URL? {
        let categoryPath: String
        switch self {
        case .movieTopRated:
            categoryPath = "movie/top_rated"
        case .movieUpcoming:
            categoryPath = "movie/upcoming"
        case .movieNowPlaying:
            categoryPath = "movie/now_playing"
        case .serie:
            categoryPath = "tv/popular"
        }
        return URL(string: "https://api.themoviedb.org/3/\(categoryPath)?api_key=6843df26f45e3eed2352b62f54747473&language=en-US&page=1")
    }
    
}

struct MoviesResponse: Codable {
    let results: [MovieItemResponse]
}

struct MovieItemResponse: Codable {
    let title: String
    let posterPath: String
    let backdropPath: String // New property
    let releaseDate: String
    let overview: String
    let popularity: Double
}

struct MediaItem: Identifiable {
    let id = UUID()
    let title: String
    let coverImageName: String
    let backdropImageName: String // New property
    let releaseDate: String
    let overview: String
    let popularity: Double
    
    var releaseDateFormatted: String { return releaseDate.toBrazilianDateFormat() }
}
