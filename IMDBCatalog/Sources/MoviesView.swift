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
            VStack(alignment: .leading) {
                Spacer()
                Text("Lançamentos").padding([.leading], 15)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(viewModel.movies) { movie in
                            ListItemView(movie: movie)
                        }
                    }
                    .padding()
                    .background(Color.black) // Fundo preto para o HStack
                }

                Text("Mais assistidos").padding([.leading], 15)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(viewModel.movies) { movie in
                            ListItemView(movie: movie)
                        }
                    }
                    .padding()
                    .background(Color.black) // Fundo preto para o HStack
                }
                Spacer()

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
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
