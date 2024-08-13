import SwiftUI
import Combine

class SeriesViewModel: ObservableObject {
    @Published var series: [MediaItem] = []

    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "6843df26f45e3eed2352b62f54747473" // Replace with your actual API key

    func fetchSeries() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            return
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SeriesResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching series: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { response in
                let baseURL = "https://image.tmdb.org/t/p/w500"
                self.series = response.results.map { 
                    MediaItem(
                        title: $0.name, 
                        coverImageName: "\(baseURL)\($0.posterPath)",
                        backdropImageName: "\(baseURL)\($0.backdropPath)",
                        releaseDate: $0.firstAirDate,
                        overview: $0.overview,
                        popularity: $0.popularity
                    ) 
                }
            })
            .store(in: &cancellables)
    }
}

struct SeriesResponse: Codable {
    let results: [SerieItemResponse]
}

struct SerieItemResponse: Codable {
    let name: String
    let posterPath: String
    let backdropPath: String // New property
    let firstAirDate: String
    let overview: String
    let popularity: Double
}
