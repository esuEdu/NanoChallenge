//
//  SeriesViewModel.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 17/08/23.
//

import Foundation

@MainActor
class SeriesViewModel: ObservableObject {
    
    struct Returned: Codable {
        var count = 0
        var series: [Series]
    }
    
     struct SeriesDetail: Codable {
        var id: Int
        var name: String
        var genres: [String]
        var status: String
        var image: Imagem
        var summary: String
    }
    
 
    @Published var urlString = "https://api.tvmaze.com/shows"
    @Published var count = 0
    @Published var seriesArray: [Series] = []
    
    func getSeries() async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard response is HTTPURLResponse else {
                print("👺 Erro no response")
                return
            }
       
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.seriesArray = try decoder.decode([Series].self, from: data)
            self.count = seriesArray.count
            print(count)


        } catch  {
            print("👺 Erro nao pode usar o url")
        }
    }
    
    // MARK: COMECA POR AQUI A API DA THEMOVIEDB
    
    let apiKey = "51b118788f608c33046a9420adb65886"
    var currentPage = 1
    var totalPages = 1
    
    @Published var tvSeriesArray: [TVSeries] = []
    @Published var popularSeries: [TVSeries] = []
    @Published var count2 = 1
    
    // ------------------------------------------------------------------------------------------------
    func getTVSeries(page: Int) async throws -> TVSeriesResponse {
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(TVSeriesResponse.self, from: data)
        
        if currentPage == 1 {
            self.popularSeries = response.results
        }
         return response
    }
    
    func fetchAllTVSeries(limit: Int) async {
        var allSeries: [TVSeries] = []
        
        while currentPage <= totalPages && allSeries.count <= limit {
            do {
                let response = try await getTVSeries(page: currentPage)
                allSeries.append(contentsOf: response.results)
                currentPage += 1
                totalPages = response.total_pages
            } catch {
                print("👺 Erro puxar todas as series")
                if let decodingError = error as? DecodingError {
                       print("Decoding error: \(decodingError)")
                   }
                return
            }
            DispatchQueue.main.async {
                self.tvSeriesArray = allSeries
                self.count2 = allSeries.count
            }
        }
    }
        
    func getImages(seriesId: Int) async throws -> SeriesImagesResponse {
        let urlString = "https://api.themoviedb.org/3/tv/\(seriesId)/images?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(SeriesImagesResponse.self, from: data)
        
        //                for var series in response.results {
        //                    do {
        //                        let imagesResponse = try await getImages(seriesId: series.id)
        //                        if let firstBacdrop = imagesResponse.backdrops.first {
        //                            series.backdrop_path = firstBacdrop.filePath
        //                        }
        //                        allSeries.append(contentsOf: response.results)
        //                    } catch {
        //                        print("👺 Erro ao obter imagens da série \(series.name)")
        //                        print("👺 \(series.name) com url \(series.backdrop_path)")
        //
        //                    }
        //                }
    }
}
