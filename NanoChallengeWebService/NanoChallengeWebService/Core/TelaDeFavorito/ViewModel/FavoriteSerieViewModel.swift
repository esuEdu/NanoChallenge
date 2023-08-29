//
//  FavoriteSerieViewModel.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation

class FavoriteSerieViewModel: ObservableObject{
    
    let apiKey = "51b118788f608c33046a9420adb65886"

    func fetchTVSerie(id: Int) async throws -> TVEachSeries{
        let urlString = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(TVEachSeries.self, from: data)
        return response
    }
}

