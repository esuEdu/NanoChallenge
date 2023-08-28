import SwiftUI

///View que exibe os filmes
struct MovieHomeView: View {
    
    @StateObject var mv:MovieHomeViewModel = MovieHomeViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    
                    HearderSrollMovie(title: "Recents") //Header do ScrollMovies (título e "All Movies")
                    ScrollMovies(movies:  mv.responseMovieDiscover?.results ?? []) //ScrollMovies exibindo todos os filmes.
                    
                    HearderSrollMovie(title: "Family")
                    ScrollMovies(movies:  mv.moviesFamily?.results ?? [])
                    
                    HearderSrollMovie(title: "Documentary")
                    ScrollMovies(movies:  mv.moviesDocumentary?.results ?? [])
                    
                    
                    HearderSrollMovie(title: GenreMovie.adventure.name)
                    ScrollMovies(movies:  mv.moviesAdventure?.results ?? [])
                    
                    HearderSrollMovie(title: GenreMovie.romance.name)
                    ScrollMovies(movies: mv.moviesRomance?.results ?? [])
                    
                    
                    
                }.task {
                    try? await mv.getDiscoverMovies()
                    try? await mv.getAdventure()
                    try? await mv.getRomance()
                    try? await mv.getFamily()
                    try? await mv.getDocumentary()
                }
                .background(Color("BackGroundColor"))
                .navigationTitle("Movies")
            }
        }.background(Color("BackGroundColor"))
    }
}


struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
            .preferredColorScheme(.dark)
    }
}

