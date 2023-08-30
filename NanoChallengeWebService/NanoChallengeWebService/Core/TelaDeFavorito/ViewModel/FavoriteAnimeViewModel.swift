//
//  FavoriteViewModel.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation

class FavoriteAnimeViewModel: ObservableObject {
    let service = AnimeDataService()
    
    func fetchAnimeData(id: Int) async throws -> [AnimeModel]{
        do {
            let response = try await service.getAnime(id: id)
            return response
        }catch {
            print("Decoding Error: \(error)")
        }
        return []
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
