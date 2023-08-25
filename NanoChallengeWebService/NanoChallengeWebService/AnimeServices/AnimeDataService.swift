//
//  AnimeDataService.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 20/08/23.
//

import Foundation

class AnimeDataService {
    
    let queryManager = QueryManager()
    let networkingManager = NetworkingManager()
    
    func getTrendingAnime(page: Int?) async throws -> ([AnimeModel], PageInfoModel) {
        do {
            let urlRequest = try queryManager.RequestAnimePage(page: page, sort: ["TRENDING_DESC"], search: nil)
            let response = try await networkingManager.downloadRequest(url: urlRequest)
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(responseAPI.self, from: response )
            
            return (apiResponse.data.page.media, apiResponse.data.page.pageInfo)
            
        } catch {
            throw URLError(.badURL)
        }
    }
    
    func getAnime(id: Int)async throws -> [AnimeModel] {
        do {
            let urlRequest = try queryManager.RequestAnime(id: id)
            let response = try await networkingManager.downloadRequest(url: urlRequest)
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(responseAPI.self, from: response )
            
            return apiResponse.data.page.media
            
        } catch {
            throw URLError(.badURL)
        }

    }
}
