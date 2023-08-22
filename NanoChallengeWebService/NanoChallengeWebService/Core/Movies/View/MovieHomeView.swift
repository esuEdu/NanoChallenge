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
                Text("\(responseMovieDiscover.page)")
                
                // Número total de páginas
                Text(String(responseMovieDiscover.totalPages))
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
