import SwiftUI

///View que exibe os filmes
struct MovieHomeView: View {
    
    @StateObject var mv:MovieHomeViewModel = MovieHomeViewModel()
    @State var searchText: String = ""
    @State var isShowingSearchResults = false
    @State var showModal = false 
    
    
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    
                    if isShowingSearchResults {
                        // Mostrar resultados de pesquisa em uma nova tela ou visualização
                        SearchResultsView(searchText: $searchText, mv: self.mv)
                    } else {
                        HearderSrollMovie(title: "Movies") //Header do ScrollMovies (título e "All Movies")
                        ScrollMovies(movies:  mv.responseMovieDiscover?.results ?? []) //ScrollMovies exibindo todos os filmes.
                        
                        HearderSrollMovie(title: "Family")
                        ScrollMovies(movies:  mv.moviesFamily?.results ?? [])
                        
                        HearderSrollMovie(title: "Documentary")
                        ScrollMovies(movies:  mv.moviesDocumentary?.results ?? [])
                        
                        
                        HearderSrollMovie(title: GenreMovie.adventure.name)
                        ScrollMovies(movies:  mv.moviesAdventure?.results ?? [])
                        
                        HearderSrollMovie(title: GenreMovie.romance.name)
                        ScrollMovies(movies: mv.moviesRomance?.results ?? [])
                        
                    }
                    
                    
                    
                    
                }.task {
                    try? await mv.getDiscoverMovies()
                    try? await mv.getAdventure()
                    try? await mv.getRomance()
                    try? await mv.getFamily()
                    try? await mv.getDocumentary()
                    
                    
                }
                .navigationTitle("Movies")
                .background(
                    Image("backgroundMovieView")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all) // Certifique-se de ignorar as áreas seguras
                    )
                
            }
           
            
            
        }
        
        
        
    }
}


struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}

struct SearchResultsView: View {
    @Binding var searchText: String
    @StateObject var mv: MovieHomeViewModel

    var body: some View {
        VStack {
            Text("Search Results for: \(searchText)")
                .foregroundColor(.white)
            
            HearderSrollMovie(title: GenreMovie.romance.name) // Corrigido 'HearderSrollMovie' para 'HeaderScrollMovie'
            ScrollMovies(movies: mv.moviesByWorld?.results ?? [])
        }
        .task {
            if !searchText.isEmpty { // Verifica se o searchText não está vazio
                try? await mv.getMoviesByWorld(search: searchText)
            }
        }
    }
}
