//
//  MoviesModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 18/08/23.
//

import Foundation
import SwiftUI

struct Movie: Codable, Identifiable, Hashable {
    var isFavorite: Bool? = false
    let adult: Bool
    let backdropPath: String?
    let genres: [GenreMovieResponce]?
    let homepage: String?
    let id: Int
    // let imdbID: String
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let releaseDate: String?
    let revenue: Int? // receita arrecadado pelos filmes
    let runtime: Int? // duração
    let spokenLanguages: [SpokenLanguage]?
    let status: String? // em produção, concluído, cancelado...
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    // Implementação do método hash(into:) para conformar ao protocolo Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Combine com o id ou outros atributos relevantes
    }
    
    // Implementação da função '==' para conformar ao protocolo Equatable
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}


struct Collection: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
}

struct GenreMovieResponce: Codable {
    let id: Int?
    let name: String?
}

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?
}

///Struct que serve para armazanear a resposta da função discover movies
struct responceDiscoverMovies: Codable {
    let page: Int?
    let results: [Movie]?
//    let totalPages: Int?
//    let totalResults: Int?
}

///Enum usado para gerênciar erros
enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum GenreMovie: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    var name: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .tvMovie: return "TV Movie"
        case .thriller: return "Thriller"
        case .war: return "War"
        case .western: return "Western"
        }
    }
}

///Resposta da requisição que retorna os CastMember
struct CastResponse: Codable {
    let id: Int
    let cast: [CastMember]
}

///Um CastMemer (ator)
struct CastMember: Codable, Identifiable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let name: String
    let originalName: String
    let popularity: Double?
    let profilePath: String?
    let character: String?
    let order: Int?
}

struct CustomColor {
    static let black = Color(red: 0, green: 0, blue: 0)
    static let white = Color(red: 1, green: 1, blue: 1)
    static let secondary = Color(red: 0.29, green: 0.69, blue: 0.72)
}
