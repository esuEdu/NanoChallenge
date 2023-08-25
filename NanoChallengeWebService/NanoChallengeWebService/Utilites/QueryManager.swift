//
//  QueryManager.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 20/08/23.
//

import Foundation

class QueryManager {
    
    let queryPages = """
query ($page: Int, $sort: [MediaSort], $search: String) {
    Page(page: $page) {
      pageInfo {
          hasNextPage
          lastPage
        }

    media(type: ANIME, sort: $sort, search: $search) {
            id
            title{
                english
                romaji
                native
                }
            coverImage {
                large
                }
            synonyms
        }
  }
}


"""
    
    let queryAnime = """
    query ($id: Int) {
      Page{
          pageInfo{
              hasNextPage
          }
          media(type: ANIME, id : $id) {
               id
        title {
          english
          romaji
          native
        }
        description
        format
        status
        startDate {
          year
          month
          day
        }
        endDate {
          year
          month
          day
        }
        episodes
        trailer {
          id
          site
          thumbnail
        }
        coverImage {
          large
        }
        bannerImage
        genres
        averageScore
        externalLinks {
            id
            url
            site
            icon
            }
        synonyms
        relations {
            nodes{
                    id
                    title{
                        english
                        romaji
                        native
                    }
                    coverImage{
                        large
                    }
            }
        }
        characters(sort: ROLE){
            nodes{
                id
                name{
                    full
                }
                image{
                    large
                }
            }
        }
        }
        }
    }

    """
    
    func RequestAnime(id: Int) throws -> URLRequest {
        let variables: [String: Any] = [
            "id": id
        ]
        
        guard let url = URL(string: "https://graphql.anilist.co") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Create the request body JSON data
        let requestBody: [String: Any] = [
            "query": queryAnime,
            "variables": variables
        ]
        if let requestBodyData = try? JSONSerialization.data(withJSONObject: requestBody) {
            request.httpBody = requestBodyData
        }
        return request
    }
    
    func RequestAnimePage(page: Int?, sort: [String]?, search: String?) throws -> URLRequest{
        
        let variables: [String: Any] = [
            "page" : page as Any,
            "sort" : sort as Any,
            "search": search as Any
        ]
        
        guard let url = URL(string: "https://graphql.anilist.co") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Create the request body JSON data
        let requestBody: [String: Any] = [
            "query": queryPages,
            "variables": variables
        ]
        if let requestBodyData = try? JSONSerialization.data(withJSONObject: requestBody) {
            request.httpBody = requestBodyData
        }
        return request
    }
}
