//
//  Series.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 17/08/23.
//

import Foundation

struct Series: Codable{
   var id: Int
   var name: String
   var image: Imagem
    var _links: Links
    var genres: [String]
    var status: String
    var summary: String
}



struct Imagem: Codable {
    let medium: String
    let original: String
}

struct Links: Codable {
    let selfLink: Link
    let previousepisode: Link
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case previousepisode
    }
}

struct Link: Codable {
    let href: String
}


struct TVSeriesResponse: Codable {
    let page: Int
    var results: [TVSeries]
    let total_pages: Int
}

struct TVSeries: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let popularity: Double
    let vote_average: Double
    let genre_ids: [Int]
    var backdrop_path: String?
    let posterPath: String?
    var imageURL: URL?

}

struct TVEachSeries: Codable, Identifiable, Equatable {
    static func == (lhs: TVEachSeries, rhs: TVEachSeries) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let popularity: Double
    let vote_average: Double
    let posterPath: String?
    let genres: [Genre]
    var backdrop_path: String?
    var imageURL: URL?
    let number_of_episodes: Int
    let number_of_seasons: Int
    let overview: String
    
    let seasons: [Season]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Season: Codable {
    let id: Int
    let name: String
    let episode_count: Int
}

struct SeriesImagesResponse: Codable {
    let backdrops: [Backdrop]
}

struct Backdrop: Codable {
    let filePath: String
}

// EPISODES

struct Episode: Codable, Hashable {
    var name: String
    var overview: String
    var season_number: Int
}
