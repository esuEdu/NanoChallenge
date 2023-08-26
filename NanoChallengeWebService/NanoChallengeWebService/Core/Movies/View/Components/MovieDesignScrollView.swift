//
//  MovieDesignScrollView.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

///Design dos filmes que são exibidos em SrollMovies
struct MovieDesignScrollView: View {
    
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
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                        )
                } placeholder: {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
////                        .scaleEffect(4)
////                        .frame(maxHeight: 96)
//                        .frame(maxWidth: 185, maxHeight: 230)

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


//struct MovieDesignScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDesignScrollView()
//    }
//}
