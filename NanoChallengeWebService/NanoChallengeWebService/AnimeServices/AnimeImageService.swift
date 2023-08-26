//
//  AnimeImageService.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 24/08/23.
//

import Foundation
import SwiftUI

class AnimeImageService {
    
    @Published var image: UIImage? = nil
    
    private let netWorkingManger = NetworkingManager()
    private let anime: AnimeModel
    
    init(anime: AnimeModel) {
        self.anime = anime
    }
    
    func getImage() async throws -> UIImage? {
        guard let url = URL(string: anime.coverImage.large) else { return nil }
        do {
            let data = try await netWorkingManger.download(url: url)
            let image = UIImage(data: data)
            return image
        }catch {
            throw URLError(.badURL)
        }
    }
}
