import SwiftUI

///View que exibe os filmes
struct MovieHomeView: View {
    
    @StateObject var mv:MovieHomeViewModel = MovieHomeViewModel()
    @State var text: String = ""
    var body: some View {
        VStack {
            NavigationView {
                
                ScrollView {
                    
                    
                    //MARK: Filmes recentes
                    HearderSrollMovie(title: "Movies") //Header do ScrollMovies (título e "All Movies")
                    ScrollMovies(movies:  mv.responseMovieDiscover?.results ?? []) //ScrollMovies exibindo todos os filmes.
                    
                    HearderSrollMovie(title: "Family") //Header do ScrollMovies (título e "All Movies")
                    ScrollMovies(movies:  mv.moviesFamily?.results ?? []) //ScrollMovies exibindo todos os filmes.
                    
                    HearderSrollMovie(title: "Documentary") //Header do ScrollMovies (título e "All Movies")
                    ScrollMovies(movies:  mv.moviesDocumentary?.results ?? []) //ScrollMovies exibindo todos os filmes.
                    
                    
                    //MARK: Filmes de ação
                    HearderSrollMovie(title: GenreMovie.adventure.name) //GenreMovie.adventure.name = "adventure"
                    ScrollMovies(movies:  mv.moviesAdventure?.results ?? [])
                    
                    //MARK: Filmes de romancex
                    HearderSrollMovie(title: GenreMovie.romance.name)   //GenreMovie.romance.name = "romance"
                    
                    ScrollMovies(movies: mv.moviesRomance?.results ?? [])
                    
                    
                    
                }.task {
                    try? await mv.getDiscoverMovies()
                    try? await mv.getAdventure()
                    try? await mv.getRomance()
                    try? await mv.getFamily()
                    try? await mv.getDocumentary()
                }
                .background(CustomColor.black)
                .navigationTitle("Movies")
                //            }
                
            }
        }
    }
}


struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}

