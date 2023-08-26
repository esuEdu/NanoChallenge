import SwiftUI

enum Strings: String {
    case imageError = "Image Error"
    case titleError = "Title Error"
}

///É o header das ScrollMovies, recebe como pariametro o nome da ScrollView, normalmente o gênero da Lista de filmes.
struct HearderSrollMovie_Component: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding(.horizontal)
            Spacer()
            Button {
                
            } label: {
                Text("View All")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding()

           
        }
    }
}

///Componente que exibe horizontalmente uma lista de Filmes, mostrando o título e banner deles
struct ScrollMovie_Component: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieItem(idMovie: movie.id)) {
                        MovieItemViewComponent(movie: movie)
                    }
                }
            }
        }
    }
}

///Componente que configura a aparência dos filmes na ScrollMovieComponent
struct MovieItemViewComponent: View {
    
    let movie: Movie
    
    //TODO: Colocar placeholder com animação de carregamento
    var body: some View {
        VStack {
            if let backDropPath = movie.backdropPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 185, maxHeight: 230)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(4)
                        .frame(maxHeight: 96)
                }
            }
            
            if let title = movie.title {
                Text(title)
            } else {
                Text(Strings.titleError.rawValue)
            }
        }
        .padding()
    }
}

///Vier que exibe os filmes
struct MovieHomeView: View {
    
    @State var responseMovieDiscover: responceDiscoverMovies?
    @State var movieService: MovieService = MovieService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HearderSrollMovie_Component(title: "Movies")
                        ScrollMovie_Component(movies: responseMovieDiscover?.results ?? [])
                    }
                    .task {
                        do {
                            responseMovieDiscover = try await movieService.getDiscoverMovies()
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                    
                    
                }
                .navigationTitle("Movies")
                
            }
        }
    }
}
struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
