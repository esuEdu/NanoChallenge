//
//  MoviesModel.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 18/08/23.
//

import Foundation
import SwiftUI

struct Movie: Codable, Identifiable {
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
    let voteAverage: Float?
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
    let totalPages: Int?
    let totalResults: Int?
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

