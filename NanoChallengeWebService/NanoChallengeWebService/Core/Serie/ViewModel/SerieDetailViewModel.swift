//
//  SerieDetailViewModel.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 17/08/23.
//

import Foundation

@MainActor
class SeriesDetailViewlModel: ObservableObject{

    var urlString = ""
    @Published var name = ""
    @Published var imageURL = ""
    @Published var isLoading = false

    @Published var _links: Links = Links(selfLink: Link(href: ""), previousepisode: Link(href: ""))
    @Published var genres: [String] = []
    @Published var status: String = ""
    @Published var summary: String = ""
    @Published var isFavorite:Bool = false

    func getData() async {
        isLoading = true
        guard let url = URL(string: urlString) else {isLoading = false; return}
                
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Series.self, from: data) else {
                print(" 👺 Erro em fazer o decode")
                isLoading = false
                return
            }
            self.name = returned.name
            self.imageURL = returned.image.original
            self.genres = returned.genres
            self.summary = returned.summary
            self.status = returned.status
            self._links = returned._links
            isLoading = false
            print("😎 Deu certo, url: \(url) ")
        } catch {
            print("👺 Erro nao pode usar o url")
            isLoading = false
        }
    }
    
    // DADOS da TMDB API
    @Published var overview: String = ""
    @Published var number_of_episodes: Int = 0
    @Published var backdrop_path: String = ""
    @Published var genresTV: [Genre] = []
    @Published var number_of_seasons: Int = 0
    @Published var vote_average: Double = 0.0
    @Published var nome:String = ""
    // Todos os eps
    @Published var allEpisodes: [Episode] = []
    
    let apiKey = "51b118788f608c33046a9420adb65886"
    
    var currentEpisode: Int = 1
    
    
    func fetchTVSerie(id: Int) async throws{
        let urlString = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(TVEachSeries.self, from: data)
        self.overview = response.overview
        self.genresTV = response.genres
        self.number_of_seasons = response.number_of_seasons
        self.number_of_episodes = response.number_of_episodes
        self.vote_average = response.vote_average / 2
        self.nome = response.name
    }
    
    func fetchEpisode(idSerie: Int, season: Int) async throws -> Episode{
        
        let urlString = "https://api.themoviedb.org/3/tv/\(idSerie)/season/\(season)/episode/\(currentEpisode)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response =  try decoder.decode(Episode.self, from: data)
        
        return response
    }
    
    func fetchAllEpisode(idSerie: Int, season: Int) async throws{
        var allEpisodes: [Episode] = []
        while true {
            do {
                let response = try await fetchEpisode(idSerie: idSerie, season: season)
                allEpisodes.append(response)
                currentEpisode += 1
            } catch {
                print("👺 Erro puxar todas as series")
                if let decodingError = error as? DecodingError {
                       print("Decoding error: \(decodingError)")
                   }
                break
            }
            DispatchQueue.main.async {
                self.allEpisodes = allEpisodes
            }
        }
    }
}

