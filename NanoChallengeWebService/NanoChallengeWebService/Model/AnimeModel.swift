//
//  Anime.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import Foundation

struct AnimeModel: Codable, Identifiable {
    let id: Int
    let title: Title
    let description: String?
    let format: Format?
    let status: Status?
    let startDate: Date?
    let endDate: Date?
    let episodes: Int?
    let trailer: Trailer
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case format = "format"
        case status = "status"
        case startDate = "startDate"
        case endDate = "endDate"
        case episodes = "episodes"
        case trailer = "trailer"
    }
}

//MARK: - TITLE
struct Title: Codable {
    let english: String?
    let romaji: String?
}

//MARK: - FORMAT
enum Format: Codable {
    case TV
    case TV_SHORT
    case MOVIE
    case SPECIAL
    case OVA
    case ONA
    case MUSIC
    case MANGA
    case NOVEL
    case ONE_SHOT
}

//MARK: - STATUS
enum Status: Codable {
    case finished
    case releasing
    case notYetReleased
    case cancelled
    case hiatus
}

//MARK: - Date
struct Date: Codable {
    let day: Int
    let month: Int
    let year: Int
}

//MARK: - TRAIlER
struct Trailer: Codable {
    let id: String
    let site: String
    let thumbnail: String
}


