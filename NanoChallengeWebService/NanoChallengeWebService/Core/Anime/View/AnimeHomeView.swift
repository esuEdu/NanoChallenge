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
        NavigationView{
            ScrollView{
                VStack(spacing: 30) {
                    //MARK: - Trending Anime list
                    HStack{
                        Text("Trending")
                            .font(.title)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 40) {
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
                    HStack{
                        Text("Populares")
                            .font(.title)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 40) {
                            ForEach(viewModel.popularAnimeList) { anime in
                                NavigationLink(value: anime, label: {
                                    AnimeItemView(anime: anime)
                                })
                                .onAppear {
                                    if anime == viewModel.popularAnimeList.last && viewModel.hasNextPagePopular == true {
                                        Task {
                                            try? await viewModel.fetchPopularAnimeData()
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
                    HStack{
                        Text("Score High")
                            .font(.title)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 40) {
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
                    }            }
            }
            .background(Color("BackGroundColor"))
            .navigationTitle("Anime")
        }
    }
}


struct AnimeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AnimeHomeView()
                .preferredColorScheme(.dark)
                .navigationDestination(for: AnimeModel.self ) { anime in
                    AnimeView(anime: anime)
                }
        }
    }
}
