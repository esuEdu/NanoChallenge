import Foundation

class AnimeHomeViewModel: ObservableObject {
    
    @Published var trendingAnimeList: [AnimeModel] = []
    @Published var hasNextPageTrending: Bool?
    private var nextPageTrending: Int?
    
    @Published var popularAnimeList: [AnimeModel] = []
    @Published var hasNextPagePopular: Bool?
    private var nextPagePopular: Int?
    
    @Published var AnimeList: [AnimeModel] = []
    @Published var hasNextPage: Bool?
    private var nextPage: Int?
    
    let service = AnimeDataService()
    
    func fetchTrendingAnimeData(search: String?) async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nil, sort: ["TRENDING_DESC"], search: search)
            await MainActor.run(body: {
                trendingAnimeList.append(contentsOf: response)
                hasNextPageTrending = pageInfo.hasNextPage
                nextPageTrending = pageInfo.nextPage

            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    func fetchTrendingAnimeNextPage(search: String?) async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nextPageTrending, sort: ["TRENDING_DESC"], search: search)
            await MainActor.run(body: {
                trendingAnimeList.append(contentsOf: response)
                hasNextPageTrending = pageInfo.hasNextPage
                nextPageTrending = pageInfo.nextPage
            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    
    func fetchPopularAnimeData() async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nil, sort: ["POPULARITY_DESC"], search: nil)
            await MainActor.run(body: {
                popularAnimeList.append(contentsOf: response)
                hasNextPagePopular = pageInfo.hasNextPage
                nextPagePopular = pageInfo.nextPage

            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    func fetchPopularAnimeNextPage() async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nextPagePopular, sort: ["POPULARITY_DESC"], search: nil)
            await MainActor.run(body: {
                popularAnimeList.append(contentsOf: response)
                hasNextPagePopular = pageInfo.hasNextPage
                nextPagePopular = pageInfo.nextPage
            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    
    func fetchAnimeData() async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nil, sort: ["SCORE_DESC"], search: nil)
            await MainActor.run(body: {
                AnimeList.append(contentsOf: response)
                hasNextPage = pageInfo.hasNextPage
                nextPage = pageInfo.nextPage

            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    func fetchAnimeNextPage() async throws {
        do {
            let (response, pageInfo) = try await service.getAnime(page: nextPagePopular, sort: ["SCORE_DESC"], search: nil)
            await MainActor.run(body: {
                AnimeList.append(contentsOf: response)
                hasNextPage = pageInfo.hasNextPage
                nextPage = pageInfo.nextPage
            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    
}

