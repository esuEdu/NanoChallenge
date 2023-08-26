//
//  ScrollMovies.swift
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
                    NavigationLink(destination: MovieItem(idMovie: movie.id)) {
                        MovieDesignScrollView(movie: movie)
                    }
                }
            }
        }
    }
}


//struct ScrollMovies_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollMovies()
//    }
//}
