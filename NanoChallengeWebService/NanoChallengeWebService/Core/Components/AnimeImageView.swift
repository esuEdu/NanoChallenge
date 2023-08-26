//
//  AnimeImageView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 24/08/23.
//

import SwiftUI

struct AnimeImageView: View {
    
    @StateObject var viewModel: AnimeImageViewModel
    
    init(anime: AnimeModel) {
        _viewModel = StateObject(wrappedValue: AnimeImageViewModel(anime: anime))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    
            }else if viewModel.isLoading ?? false{
                ProgressView()
            }
        }.task {
            viewModel.fetchAnimeImage()
        }
    }
}

