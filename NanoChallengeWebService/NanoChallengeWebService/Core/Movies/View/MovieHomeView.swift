//
//  MovieHomeView.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 18/08/23.
//

import SwiftUI

struct MovieHomeView: View {
    
    @State var responseMovieDiscover: responceDiscoverMovies? // Renomeado para MovieResponse
    @State var movieService: MovieService = MovieService()
    
    var body: some View {
        VStack {
            if let responseMovieDiscover = responseMovieDiscover {
                // Id do filme
                Text(String(responseMovieDiscover.page ?? 999))
                
                // Número total de páginas
                Text(String(responseMovieDiscover.totalPages ?? 777))
                
                // Resultados da busca
                ForEach(responseMovieDiscover.results!, id: \.id) { movie in
//                    Text(String(movie.id))
////                    Text(movie.title)
//                    Text(String(movie.adult))
                    
                    if let title = movie.title {
                        Text("\(title)")
                    } else {
                        Text("❌ Título indisponível")
                    }
                    
                    //Gêneros do filme
//                    ForEach(movie.genres! , id: \.id) { genre in
//                        Text(genre.name ?? "N genre")
//                    }
//
                }
                
                
            }
        }
        .padding()
        .task {
            do {
                responseMovieDiscover = try await movieService.getDiscoverMovies()
            } catch GHError.invalidURL {
                print("Invalid URL")
            } catch GHError.invalidData {
                print("Invalid response")
            } catch GHError.invalidResponse {
                print("Invalid data")
            } catch {
                print("\(error)")
                print("Unexpected Error")
            }
        }
    }
}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
