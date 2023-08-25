//
//  AnimeView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 25/08/23.
//

import SwiftUI

struct AnimeView: View {
    
    @StateObject private var viewModel = AnimeViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                HStack(alignment: .top) {
                    Rectangle()
                        .frame(width: 140, height: 200)
                    VStack(alignment: .leading) {
                        Text("Type:")
                        Text(viewModel.anime.first?.format ?? "")
                        
                        Text("Genre:")
                            .padding(.top, 0.5)
                        let genres = viewModel.anime.first?.genres
                        let allgenres = genres?.joined(separator: ", ")
                        Text(allgenres ?? "")
                        
                        
                        Text("episodes:")
                            .padding(.top, 0.5)
                        Text(String((viewModel.anime.first?.episodes ?? 0)))
                    }
                    .padding(.top, 8)
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    if let description = viewModel.anime.first?.description {
                        Text(viewModel.removeHTMLTags(htmlString: description))
                    }
                    Divider()
                    if let romajiName = viewModel.anime.first?.title.romaji{
                        Text("Romaji:")
                            .padding(.top)
                        Text(romajiName)
                    }
                    
                    if let nativeName = viewModel.anime.first?.title.native{
                        Text("Native:")
                            .padding(.top)
                        Text(nativeName)
                    }
                    
                    if let otherNames = viewModel.anime.first?.synonyms {
                        let allNames = otherNames.joined(separator: ", ")
                        Text("Other Names: ")
                            .padding(.top)
                        Text(allNames)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(( viewModel.anime.first?.title.english ?? viewModel.anime.first?.title.romaji) ?? "")
        .task {
            try? await viewModel.fetchAnimeData()
        }
    }
}

struct AnimeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeView()
    }
}
