//
//  MoviesModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 18/08/23.
//

import Foundation
import SwiftUI

struct Movie: Codable, Identifiable {
    var isFavorite: Bool? = false
    let adult: Bool
    let backdropPath: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
//    let imdbID: String
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let releaseDate: String?
    let revenue: Int? //receita arrecadado pelos filmes
    let runtime: Int? // duração
    let spokenLanguages: [SpokenLanguage]?
    let status: String? // em produção, concluído, cancelado...
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

}

struct Collection: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
}

struct Genre: Codable {
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

//struct GenresDesign: PreviewProvider {
//    typealias Previews = <#type#>
//
//    var name: String?
//
////    static var previews: some View {
////        GenresDesign(name: "Ação")
////    }
//
//    var body: some View {
//        Button(action: {}) {
//            if let nameGenre = name {
//                Text(nameGenre)
//            } else {
//                Text("Gênero inexistente")
//            }
//        }
//    }
//}


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
