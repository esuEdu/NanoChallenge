//
//  AnimeHomeView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import SwiftUI

struct AnimeHomeView: View {
    
    @StateObject private var viewModel = AnimeHomeViewModel()
    
    var body: some View {
        VStack {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack() {
                    ForEach(viewModel.trendingAnimeList) { anime in
                        NavigationLink(value: anime) {
                            AnimeItemView(anime: anime)
                        }
                            .onAppear {
                                Task {
                                    if anime == viewModel.trendingAnimeList.last && viewModel.hasNextPage == true {
                                        try? await viewModel.fetchAnimeNextPage()
                                    }
                                }
                            }
                    }
                }
                .task {
                    try? await viewModel.fetchAnimeData()
                }
            }
        }
    }
}
struct AnimeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeHomeView()
    }
}
