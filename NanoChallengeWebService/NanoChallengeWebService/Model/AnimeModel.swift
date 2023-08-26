//
//  Anime.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import Foundation

struct responseAPI: Codable {
    let data: DataAPI
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct DataAPI: Codable {
    let page: Page
    enum CodingKeys: String, CodingKey {
        case page = "Page"
    }
}

struct Page: Codable {
    var media: [AnimeModel]
    var pageInfo: PageInfoModel
    enum CodingKeys: String, CodingKey {
        case media = "media"
        case pageInfo = "pageInfo"
    }
}


struct PageInfoModel: Codable {
    var hasNextPage: Bool
    var nextPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case hasNextPage
        case nextPage = "lastPage"
    }
}

struct AnimeModel: Codable, Identifiable, Equatable, Hashable {
    
    static func == (lhs: AnimeModel, rhs: AnimeModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: Title
    let description: String?
    let format: String?
    let status: String?
    let startDate: Date?
    let endDate: Date?
    let episodes: Int?
    let trailer: Trailer?
    let coverImage: CoverImage
    let bannerImage: String?
    let genres: [String]?
    let averageScore: Int?
    let characters: Characters?
    let externalLinks: [ExternalLink]?
    let synonyms: [String]?
    let relations: relations?
    
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
        case coverImage = "coverImage"
        case bannerImage = "bannerImage"
        case genres = "genres"
        case averageScore = "averageScore"
        case characters = "characters"
        case externalLinks = "externalLinks"
        case synonyms = "synonyms"
        case relations = "relations"
    }
}

//MARK: - TITLE
struct Title: Codable, Hashable {
    let english: String?
    let romaji: String?
    let native: String?
}

//MARK: - DATE
struct Date: Codable, Hashable {
    let day: Int?
    let month: Int?
    let year: Int?
}

//MARK: - TRAIlER
struct Trailer: Codable, Hashable {
    let id: String?
    let site: String?
    let thumbnail: String?
}

//MARK: - COVER IMAMGE
struct CoverImage: Codable, Hashable {
    let large: String
}

//MARK: - COVER IMAGE
struct Characters: Codable, Hashable {
    let id: Int?
    let name: Name?
    let image: CoverImage?
}

//MARK: - EXTERNAL LINK
struct Name: Codable, Hashable {
    let full: String?
}

//MARK: - EXTERNAL LINK
struct ExternalLink: Codable, Hashable {
    let id: Int?
    let url: String?
    let site: String?
    let icon: String?
}

//MARK: - RECOMMENDATIONS
struct relations: Codable, Hashable {
    let nodes: [AnimeModel]?
}

//MARK: - characters
struct CharacterConnection: Codable, Hashable {
    let nodes: [Characters]?
}
