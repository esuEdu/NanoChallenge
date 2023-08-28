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
    let maxCharCount = 15
    
    var body: some View {
        VStack {
            //MARK: - IMAGENS
            if let backDropPath = movie.backdropPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)")) { image in
                    image
                    //MARK: Estilização do banner dos filmes presentes na ScrollMovies
                        .resizable()
                        .scaledToFill()
                        .backgroundStyle(.white)
                        .frame(maxWidth: 180, maxHeight: 250)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                    
                    //MARK: Estilização do placeholder dos filmes da ScrollMovies (oq aparece enquanto não carrega a imagem)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                        .frame(width: 160, height: 230)
                        .overlay {
                            ProgressView()
                                .scaleEffect(4)
                                .frame(maxHeight: 96)
                                .padding()
                        }
                }
                
            }
            
            //MARK: - Título do filme
            if let title = movie.title {
                //                Text(title.prefix(18))
                if title.count > maxCharCount {
                    let title = title.prefix(maxCharCount) + "..."
                    Text(title)
                        .bold()
                        .foregroundColor(CustomColor.white)
                    
                    
                } else {
                    Text(title)
                        .bold()
                        .foregroundColor(CustomColor.white)
                    
                }
                
            } else {
                Text(" ") //Caso não haja título não aparece nada.
            }
        }
        .padding()
        
    }
}
