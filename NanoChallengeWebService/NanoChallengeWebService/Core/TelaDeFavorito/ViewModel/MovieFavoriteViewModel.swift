//
//  MovieFavoriteViewModel.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation

class FavoriteMovieViewModel: ObservableObject {
    
    let apiKey = "51b118788f608c33046a9420adb65886"
    let baseURL = "https://api.themoviedb.org/3/movie"
    
    ///Retorna um filme usando id como parâmetro
    func getMovie(id: Int) async throws -> Movie{
        let idString = String(id)
        
        let endpoint = "https://api.themoviedb.org/3/movie/\(idString)?api_key=\(apiKey)"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let m = try decoder.decode(Movie.self, from: data)
            return m
        } catch {
            throw GHError.invalidData
        }
    }
}
