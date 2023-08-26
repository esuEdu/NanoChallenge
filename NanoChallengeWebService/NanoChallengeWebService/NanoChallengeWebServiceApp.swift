//
//  NanoChallengeWebServiceApp.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import SwiftUI

@main
struct NanoChallengeWebServiceApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
                    .navigationDestination(for: AnimeModel.self ) { anime in
                        AnimeView(anime: anime)
                    }
            }
        }
    }
}
