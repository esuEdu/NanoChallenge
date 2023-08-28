//
//  FavoriteViewModel.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var anime: [AnimeModel] = []
    let service = AnimeDataService()
    
    func fetchAnimeData(id: Int) async throws {
        do {
            let response = try await service.getAnime(id: id)
            await MainActor.run(body: {
                self.anime.append(contentsOf: response)
            })
        }catch {
            print("Decoding Error: \(error)")
        }
    }
    
    func removeHTMLTags(htmlString: String) -> String {
        if let data = htmlString.data(using: .utf8) {
            if let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            ) {
                return attributedString.string
            }
        }
        return htmlString
    }
}
