//
//  MovieItemViewModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import Foundation
import SwiftUI

//class MovieHomeViewModel: ObservableObject {
//    @Published var movieService: MovieService = MovieService()
//    @Published var responseMovieDiscover: responceDiscoverMovies?
//    @Published var moviesAdventure: responceDiscoverMovies?
//    @Published var moviesRomance: responceDiscoverMovies?
//}


///Classe que contém todas as funções de consulta de api
class MovieService {
    let apiKey = "51b118788f608c33046a9420adb65886"
    let baseURL = "https://api.themoviedb.org/3/movie"
    
    ///Retorna um filme usando id como parâmetro
    func getMovie(id: Int) async throws -> Movie {
        let idString = String(id)
        
        let endpoint = "https://api.themoviedb.org/3/movie/\(idString)?api_key=\(apiKey)"
        //curl "https://api.themoviedb.org/3/movie/157336?api_key=51b118788f608c33046a9420adb65886"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let response = response as? HTTPURLResponse
//            print(response?.statusCode)
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
//            print(response?.statusCode)
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(responceDiscoverMovies.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    ///Retorna filmes de um gênero específico, tem como parâmetro o id do gênero
    func getDiscoverMoviesGenre(idGenre: Int) async throws -> responceDiscoverMovies {

        let endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=\(idGenre)"

        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let response = response as? HTTPURLResponse
//            print(response?.statusCode)
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(responceDiscoverMovies.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    ///Faz uma pesquisa de filmes com base em palavras fornecidas pelo usuário
    func getMoviesByWorld(search: String) async throws -> responceDiscoverMovies {

        let endpoint = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(search)"

        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let response = response as? HTTPURLResponse
//            print(response?.statusCode)
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(responceDiscoverMovies.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}
