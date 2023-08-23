//
//  MovieItemViewModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import Foundation

class MovieService {
    private let apiKey = "51b118788f608c33046a9420adb65886"
    private let baseURL = "https://api.themoviedb.org/3/movie"
    
    ///Retorna um filme usando id como parâmetro
    func getMovie(id: Int) async throws -> Movie {
        let idString = String(id)
        
        let endpoint = "https://api.themoviedb.org/3/movie/\(idString)?api_key=\(apiKey)"
        //curl "https://api.themoviedb.org/3/movie/157336?api_key=51b118788f608c33046a9420adb65886"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let response = response as? HTTPURLResponse
            print(response?.statusCode)
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Movie.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    ///Retorna uma lista de filmes que foram alterados nas últimas 24 horas (normalmente filmes recentes)
    func getDiscoverMovies() async throws -> responceDiscoverMovies {
        let endpoint = "http://api.themoviedb.org/3/discover/movie/?api_key=51b118788f608c33046a9420adb65886"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let response = response as? HTTPURLResponse
            print(response?.statusCode)
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(responceDiscoverMovies.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
//    func getDiscoverMovies(id: Int) async throws -> responceDiscoverMovies {
//
//        let idString = String(id)
//
//        let endpoint = "https://api.themoviedb.org/3/movie/\(idString)/images?api_key=51b118788f608c33046a9420adb65886"
//
//        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            let response = response as? HTTPURLResponse
//            print(response?.statusCode)
//            throw GHError.invalidResponse
//        }
//
//        do {
//            let decoder = JSONDecoder()
//
//            return try decoder.decode(responceDiscoverMovies.self, from: data)
//        } catch {
//            throw GHError.invalidData
//        }
//    }
    

}
