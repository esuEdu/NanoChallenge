import SwiftUI

///View que exibe os filmes
struct MovieHomeView: View {
//    @State var movieService: MovieService = MovieService()  //Classe que contém lógica de requisições de api.
//
//    @State var responseMovieDiscover: responceDiscoverMovies? //Recebe da API filmes recentes
//    @State var moviesAdventure: responceDiscoverMovies? //Recebe da API filmes de aventura
//    @State var moviesRomance: responceDiscoverMovies? //Recebe da API filmes de romance
//    @State var search: String = ""
//    @State var isModalVisible = false
    @StateObject var mv:MovieHomeViewModel = MovieHomeViewModel()

    var body: some View {
        VStack {
            NavigationView {
                
                ScrollView {
//
//                    TextField("Search", text: $search)
//                        .padding()
//
//                    Button(action: {
//                        // Use um bloco async para tratar a chamada assíncrona
//                        Task {
//                            do {
//                                let movies = try await movieService.getMoviesByWorld(search: search)
//                            } catch {
//                                print("Error fetching movies: \(error)")
//                            }
//                        }
//                    }) {
//                        Text("Search Movies")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    VStack {
                        
                        //MARK: Filmes recentes
                        HearderSrollMovie(title: "Movies") //Header do ScrollMovies (título e "All Movies")
                        ScrollMovies(movies:  responseMovieDiscover?.results ?? []) //ScrollMovies exibindo todos os filmes.
                        
                        //MARK: Filmes de ação
                        HearderSrollMovie(title: GenreMovie.adventure.name) //GenreMovie.adventure.name = "adventure"
                        ScrollMovies(movies:  moviesAdventure?.results ?? [])
                        
                        //MARK: Filmes de romance
                        HearderSrollMovie(title: GenreMovie.romance.name)   //GenreMovie.romance.name = "romance"
                        
                        ScrollMovies(movies: moviesRomance?.results ?? [])
                        
                        
                    }
                    .navigationTitle("Movies")
                    .task { //Chamando API
                        do {
                            responseMovieDiscover = try await  movieService.getDiscoverMovies()
                            
                            moviesAdventure = mv.getMoviesByGenrer(idGenre: GenreMovie.adventure.rawValue)
                            
                            moviesRomance = try await  movieService.getDiscoverMoviesGenre(idGenre: GenreMovie.romance.rawValue)
                            
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                }
//                .background(
//                    ZStack {
//                        if let cast = selectedMovie?.cast, isModalVisible {
//                            Color.black.opacity(0.5)
//                                .ignoresSafeArea()
//                                .onTapGesture {
//                                    isModalVisible = false
//                                }
//
//                            VStack {
//                                Text("Cast Members")
//                                    .font(.title)
//                                    .padding()
//
//                                ScrollView {
//                                    ForEach(cast) { member in
//                                        VStack(alignment: .leading) {
//                                            Text(member.name)
//                                                .font(.headline)
//                                            Text("Character: \(member.character ?? "N/A")")
//                                                .font(.subheadline)
//                                        }
//                                        .padding()
//                                    }
//                                }
//
//                                Button("Close") {
//                                    isModalVisible = false
//                                }
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(15)
//                            .shadow(radius: 5)
//                            .offset(y: isModalVisible ? 0 : UIScreen.main.bounds.height)
//                            .animation(.spring())
//                        }
//                    }
//                )

            }
        }
    }
//}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}

