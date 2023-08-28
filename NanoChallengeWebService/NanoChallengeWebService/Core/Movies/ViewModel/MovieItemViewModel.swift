//
//  MovieItemViewModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import Foundation
import SwiftUI

class MovieHomeViewModel: ObservableObject {
    private var service = MovieService()
    @Published var responseMovieDiscover: responceDiscoverMovies?
    @Published var moviesAdventure: responceDiscoverMovies?
    @Published var moviesRomance: responceDiscoverMovies?
    
    /*
     para resolver a treta do movie único, crie uma view model para apenas para getMovieItem
     */
    func getMovie(idMovie: Int) async throws {
        do {
            let responce = try await service.getMovie(id: idMovie)
            await MainActor.run(body: {
                
            })
        }
    }
    
    func getDiscoverMovies() async throws {
        do {
            let responce = try await service.getDiscoverMovies()
            await MainActor.run(body: {//É aqui que colocamos dados dentro da published
                responseMovieDiscover = responce
            })
        }
    }
    
    /*
     criar uma unção para cada tipo de filme
     */
    
        func getAdventure() async throws {
            do {
                let responce = try await service.getDiscoverMoviesGenre(idGenre: GenreMovie.adventure.rawValue)
                await MainActor.run(body: {
                    moviesAdventure = responce
                })
            }
        }
    
        func getRomance() async throws {
            do {
                let responce = try await service.getDiscoverMoviesGenre(idGenre: GenreMovie.romance.rawValue)
                await MainActor.run(body: {
                    moviesRomance = responce
                })
            }
        }
    
    func getMoviesByWorld(search: String) async throws {
        do {
            let responce = try await service.getMoviesByWorld(search: search)
            await MainActor.run(body: {
                responseMovieDiscover = responce
            })
        }
    }

    
    
}


