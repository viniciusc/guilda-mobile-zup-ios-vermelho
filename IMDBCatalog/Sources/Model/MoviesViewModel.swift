// // MoviewViewModel.swift
// IMDBCatalog
// // Created by Ewerton Pereira on 11/06/24.
import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovies() {
        // Substitua "YOUR_API_KEY" pela sua chave de API do TMDB
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=6843df26f45e3eed2352b62f54747473&language=en-US&page=1") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TMDBResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                let baseURL = "https://image.tmdb.org/t/p/w500" // URL base para as imagens
                self?.movies = response.results.map { 
                    Movie(title: $0.title, coverImageName: "\(baseURL)\($0.poster_path)") 
                }
            })
            .store(in: &cancellables)
    }
}

struct TMDBResponse: Codable {
    let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
    let title: String
    let poster_path: String
}
