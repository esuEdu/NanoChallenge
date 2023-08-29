//
//  CoinImageViewModel.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 24/08/23.
//

import Foundation
import SwiftUI

class AnimeImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool? = false
    
    private let anime: AnimeModel
    private let dataService: AnimeImageService
    
    init(anime: AnimeModel) {
        self.anime = anime
        self.dataService = AnimeImageService(anime: anime)
    }
    
    func fetchAnimeImage() {
        isLoading = true
        
        Task {
            do {
                let image = try await dataService.getImage()
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print("Error fetching anime image: \(error)")
            }
            
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
