import SwiftUI

enum Strings: String {
    case imageError = "Image Error"
    case titleError = "Title Error"
}



///Vier que exibe os filmes
struct MovieHomeView: View {
    @State var movieService: MovieService = MovieService()

    @State var responseMovieDiscover: responceDiscoverMovies?
    @State var moviesAdventure: responceDiscoverMovies?
    @State var moviesRomance: responceDiscoverMovies?
    
    var body: some View {
        VStack {
        NavigationView {
            ScrollView {
                VStack {

                    //MARK: Filmes recentes
                    HearderSrollMovie(title: "Movies")
                    ScrollMovies(movies: responseMovieDiscover?.results ?? [])
                
                    //MARK: Filmes de ação
                    HearderSrollMovie(title: GenreMovie.adventure.name)
                    ScrollMovies(movies: moviesAdventure?.results ?? [])
                    
                    //MARK: Filmes de romance
                    HearderSrollMovie(title: GenreMovie.romance.name)
                    ScrollMovies(movies: moviesRomance?.results ?? [])
                    
                    
                }
                .navigationTitle("Movies")
                .task { //Chamando API
                    do {
                        responseMovieDiscover = try await movieService.getDiscoverMovies()

                        moviesAdventure = try await movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.adventure.rawValue)
                        
                        moviesRomance = try await movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.romance.rawValue)

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
