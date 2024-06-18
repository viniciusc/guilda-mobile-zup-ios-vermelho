import SwiftUI

struct ContentView: View {
    init() {
        // Customizar a aparência da TabBar
        UITabBar.appearance().barTintColor = UIColor.black // Fundo preto
        UITabBar.appearance().unselectedItemTintColor = UIColor.white // Itens não selecionados brancos
    }

    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
                .background(Color.black) // Fundo preto para a View de filmes

            SeriesView()
                .tabItem {
                    Label("Series", systemImage: "tv")
                }
                .background(Color.black) // Fundo preto para a View de séries
        }
        .accentColor(Color(red: 242/255, green: 201/255, blue: 76/255)) // Item selecionado amarelo
        .background(Color.black) // Fundo preto para a TabView
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
