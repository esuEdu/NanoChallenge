import SwiftUI

enum Strings: String {
    case imageError = "Image Error"
    case titleError = "Title Error"
}



///Vier que exibe os filmes
struct MovieHomeView: View {
    
    @State var responseMovieDiscover: responceDiscoverMovies?
    @State var moviesAdventure: responceDiscoverMovies?
    @State var movieService: MovieService = MovieService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    //Filmes recentes
                    VStack {
                        HearderSrollMovie(title: "Movies")
                        ScrollMovies(movies: responseMovieDiscover?.results ?? [])
                    }
//                    .task {
//                        do {
//                            responseMovieDiscover = try await movieService.getDiscoverMovies()
//                        } catch {
//                            print("Error: \(error)")
//                        }
//                    }
                    
                    //Filmes recentes
                    VStack {
                        HearderSrollMovie(title: GenreMovie.adventure.name)
                        ScrollMovies(movies: moviesAdventure?.results ?? [])
                    }
                    
                    
                    
                }
                .navigationTitle("Movies")
                .task {
                    do {
                        moviesAdventure = try await movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.adventure.rawValue)
                        responseMovieDiscover = try await movieService.getDiscoverMovies()

                    } catch {
                        print("Error: \(error)")
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


