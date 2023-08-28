//
//  MovieHomeViewModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

//Componente que exibe horizontalmente um array de Filmes, mostra o título e banner deles
struct ScrollMovies: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movies, id: \.self) { movie in
                    NavigationLink {
                        MovieItem(mv: MovieItemVM(movieItem: movie))
                    } label: {
                        MovieDesignScrollView(movie: movie)
                    }
                }
            }
        }
    }
}

class MovieItemVM: ObservableObject {
    private var service = MovieService()
    
    @Published var castResponce: CastResponse?
    @Published var movieItem: Movie
    
    @Published var isFavorite: Bool? = nil //Variável criada para favoritar filme

    init(movieItem: Movie) {

        self.movieItem = movieItem
        
    }
    
    func getMovie() async throws {
        do {
            let responce = try await service.getMovie(id: movieItem.id)
            await MainActor.run(body: {
                movieItem = responce
            })
        }
    }
    
    func getCasts() async throws {
        do {
            let responce = try await service.getCastMenber(idMovie: movieItem.id)
            await MainActor.run(body: {
                castResponce = responce
            })
        }
    }
}
