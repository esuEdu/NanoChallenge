//
//  ContentView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            AnimeHomeView()
            .tabItem{
                Label("Anime", systemImage: "pawprint.fill")
            }
            MovieHomeView()
                .tabItem {
                    Label("Movies", systemImage: "pawprint.fill")
                }
                .tabItem{
                    Label("Anime", systemImage: "pawprint.fill")
                }
            MainSerieView()
                .tabItem{
                    Label("Serie", systemImage: "tv")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
