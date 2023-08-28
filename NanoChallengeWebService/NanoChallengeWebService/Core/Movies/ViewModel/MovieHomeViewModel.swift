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
                ForEach(movies) { movie in
                    NavigationLink {
                        MovieItem(movieItem: movie)
                    } label: {
                        MovieDesignScrollView(movie: movie)
                    }
                }
            }
        }
    }
}

class MovieItemVM: ObservableObject {
    private var movieServe: MovieService? = MovieService() //Classe que contém lógica de requisições de api.

    @Published var movie: MovieItem?
    @Published var isFavorite: Bool? = nil //Variável criada para favoritar filme
    @Published var movieServe: MovieService? = MovieService() //Classe que contém lógica de requisições de api.


}
