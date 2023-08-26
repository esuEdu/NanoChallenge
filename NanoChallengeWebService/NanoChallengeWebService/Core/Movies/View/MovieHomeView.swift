import SwiftUI

///View que exibe os filmes
struct MovieHomeView: View {
    @State var movieService: MovieService = MovieService()  //Classe que contém lógica de requisições de api.

    @State var responseMovieDiscover: responceDiscoverMovies? //Recebe da API filmes recentes
    @State var moviesAdventure: responceDiscoverMovies? //Recebe da API filmes de aventura
    @State var moviesRomance: responceDiscoverMovies? //Recebe da API filmes de romance

//    @StateObject var viewModel:MovieHomeViewModel = MovieHomeViewModel()

    var body: some View {
        VStack {
        NavigationView {
            ScrollView {
                VStack {

                    //MARK: Filmes recentes
                    HearderSrollMovie(title: "Movies") //Header do ScrollMovies (título e "All Movies")
                    ScrollMovies(movies:  responseMovieDiscover?.results ?? []) //ScrollMovies exibindo todos os filmes.
                
                    //MARK: Filmes de ação
                    HearderSrollMovie(title: GenreMovie.adventure.name) //GenreMovie.adventure.name = "adventure"
                    ScrollMovies(movies:  moviesAdventure?.results ?? [])
                    
                    //MARK: Filmes de romance
                    HearderSrollMovie(title: GenreMovie.romance.name)   //GenreMovie.romance.name = "romance"

                    ScrollMovies(movies:  moviesRomance?.results ?? [])
                    
                    
                }
                .navigationTitle("Movies")
                .task { //Chamando API
                    do {
                         responseMovieDiscover = try await  movieService.getDiscoverMovies()

                         moviesAdventure = try await  movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.adventure.rawValue)
                        
                         moviesRomance = try await  movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.romance.rawValue)

                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            }
        }
    }
}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}

