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
        ScrollView{
            VStack(spacing: 50) {
                //MARK: - Trending Anime list
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack() {
                        ForEach(viewModel.trendingAnimeList) { anime in
                            NavigationLink(value: anime, label: {
                                AnimeItemView(anime: anime)
                            })
                            .onAppear {
                                if anime == viewModel.trendingAnimeList.last && viewModel.hasNextPageTrending == true {
                                    Task {
                                        try? await viewModel.fetchTrendingAnimeNextPage(search: nil)
                                    }
                                }
                            }
                        }
                    }
                    .task {
                        try? await viewModel.fetchTrendingAnimeData(search: nil)
                    }
                }
                
                //MARK: - Popular Anime list
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack() {
                        ForEach(viewModel.popularAnimeList) { anime in
                            NavigationLink(value: anime, label: {
                                AnimeItemView(anime: anime)
                            })
                            .onAppear {
                                if anime == viewModel.popularAnimeList.last && viewModel.hasNextPagePopular == true {
                                    Task {
                                        try? await viewModel.fetchPopularAnimeNextPage()
                                    }
                                }
                            }
                        }
                    }
                    .task {
                        try? await viewModel.fetchPopularAnimeData()
                    }
                }
                
                //MARK: - Score high Anime list
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack() {
                        ForEach(viewModel.AnimeList) { anime in
                            NavigationLink(value: anime, label: {
                                AnimeItemView(anime: anime)
                            })
                            .onAppear {
                                if anime == viewModel.popularAnimeList.last && viewModel.hasNextPagePopular == true {
                                    Task {
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
}


struct AnimeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AnimeHomeView()
                .navigationDestination(for: AnimeModel.self ) { anime in
                    AnimeView(anime: anime)
                }
        }
    }
}
