import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    init() {
        // Customizar a aparência da NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    createMovieSection(title: "Lançamentos", movies: viewModel.nowPlayingMovies)
                    createMovieSection(title: "Mais assistidos", movies: viewModel.topRatedMovies)
                    createMovieSection(title: "Em Breve", movies: viewModel.upcomingMovies)
                }
            }
            .background(Color.black) // Fundo preto para o ScrollView
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
        .background(Color.black) // Fundo preto para a NavigationView
        .foregroundColor(.white) // Texto branco para o conteúdo da NavigationView
    }
    
    private func createMovieSection(title: String, movies: [Movie]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold)) // Tamanho maior e negrito
                .foregroundColor(Color(red: 242/255, green: 201/255, blue: 76/255)) // Cor personalizada usando RGB
                .padding([.leading], 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            ListItemView(movie: movie)
                        }
                    }
                }
                .padding()
                .background(Color.black) // Fundo preto para o HStack
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
