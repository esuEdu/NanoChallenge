import Foundation

class AnimeHomeViewModel: ObservableObject {
    
    @Published var trendingAnimeList: [AnimeModel] = []
    @Published var hasNextPage: Bool?
    private var nextPage: Int?
    
    
    let service = AnimeDataService()
    
    func fetchAnimeData() async throws {
        do {
            let (response, pageInfo) = try await service.getTrendingAnime(page: nil)
            await MainActor.run(body: {
                trendingAnimeList.append(contentsOf: response)
                hasNextPage = pageInfo.hasNextPage
                nextPage = pageInfo.nextPage

            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    func fetchAnimeNextPage() async throws {
        do {
            let (response, pageInfo) = try await service.getTrendingAnime(page: self.nextPage)
            await MainActor.run(body: {
                trendingAnimeList.append(contentsOf: response)
                hasNextPage = pageInfo.hasNextPage
                nextPage = pageInfo.nextPage
            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
}

