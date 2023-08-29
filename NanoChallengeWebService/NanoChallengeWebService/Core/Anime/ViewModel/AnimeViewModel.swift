//
//  AnimeViewModel.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 25/08/23.
//

import Foundation

class AnimeViewModel: ObservableObject {
    @Published var anime: [AnimeModel] = []
    @Published var isFavorite = false
    let service = AnimeDataService()
    
    func fetchAnimeData(id: Int) async throws {
        do {
            let response = try await service.getAnime(id: id)
            await MainActor.run(body: {
                self.anime = response
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
