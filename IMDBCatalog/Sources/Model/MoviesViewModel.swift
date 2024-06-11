//
//  MoviewViewModel.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovies() {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/6843df26f45e3eed2352b62f54747473") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: IMDBResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.movies = response.items.map { Movie(title: $0.title, coverImageName: $0.image) }
            })
            .store(in: &cancellables)
    }
}

struct IMDBResponse: Codable {
    let items: [IMDBMovie]
}

struct IMDBMovie: Codable {
    let title: String
    let image: String
}
