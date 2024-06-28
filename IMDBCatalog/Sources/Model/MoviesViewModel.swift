import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "6843df26f45e3eed2352b62f54747473" // Replace with your actual API key
    
    func fetchMovies() {
        fetchMovies(for: .topRated) { [weak self] movies in
            self?.topRatedMovies = movies
        }
        fetchMovies(for: .upcoming) { [weak self] movies in
            self?.upcomingMovies = movies
        }
        fetchMovies(for: .nowPlaying) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
    }
    
    private func fetchMovies(for category: MovieCategory, completion: @escaping ([Movie]) -> Void) {
        guard let url = url(for: category) else { return }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TMDBResponse.self, decoder: jsonDecoder)
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
                    Movie(
                        title: $0.title, 
                        coverImageName: "\(baseURL)\($0.posterPath)", 
                        releaseDate: $0.releaseDate, 
                        overview: $0.overview,
                        popularity: $0.popularity
                    ) 
                }
                completion(movies)
            })
            .store(in: &cancellables)
    }
    
    private func url(for category: MovieCategory) -> URL? {
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let categoryPath: String
        switch category {
        case .topRated:
            categoryPath = "top_rated"
        case .upcoming:
            categoryPath = "upcoming"
        case .nowPlaying:
            categoryPath = "now_playing"
        }
        return URL(string: "\(baseURL)\(categoryPath)?api_key=\(apiKey)&language=en-US&page=1")
    }
}

enum MovieCategory {
    case topRated
    case upcoming
    case nowPlaying
}

struct TMDBResponse: Codable {
    let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let popularity: Double // New property
}
