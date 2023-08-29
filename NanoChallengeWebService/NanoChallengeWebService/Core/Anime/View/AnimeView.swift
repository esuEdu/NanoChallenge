//
//  AnimeView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 25/08/23.
//

import SwiftUI

struct AnimeView: View {
    
    @StateObject private var viewModel = AnimeViewModel()
    private var dataController = CoreDataController()
    private var anime: AnimeModel
    
    
    init(anime: AnimeModel) {
        self.anime = anime
    }
    
    var body: some View {
        if viewModel.anime.isEmpty {
            ProgressView()  // Show loading indicator
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    // Fetch data when the view appears
                    Task {
                        do {
                            try await viewModel.fetchAnimeData(id: anime.id)
                        } catch {
                            print("Error fetching anime data: \(error)")
                        }
                    }
                }
        } else {
            ScrollView{
                VStack{
                    HStack(alignment: .top) {
                        
                        if let anime = viewModel.anime.first {
                            AnimeImageView(anime: anime)
                                .frame(width: 140, height: 200)
                        }
                        
                        Button{
                            let test = Favorito(context: dataController.container.viewContext)
                            test.id = String(anime.id)
                            test.type = "anime"
                            if !dataController.favoritos.contains(test){
                                dataController.addFavorite(id: String(anime.id), type: "anime")
                                viewModel.isFavorite.toggle()
                            }

                        }label: {
                            
                            if !dataController.favoritos.contains(where: { i in
                                i.id == String(anime.id)
                            }) || viewModel.isFavorite == true{
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                            }else{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Type:")
                            Text(viewModel.anime.first?.format ?? "")
                            
                            Text("Genre:")
                                .padding(.top, 0.5)
                            let genres = viewModel.anime.first?.genres
                            let allgenres = genres?.joined(separator: ", ")
                            Text(allgenres ?? "")
                            
                            Text("average Score:")
                                .padding(.top, 0.5)
                            Text(String((viewModel.anime.first?.averageScore ?? 0)))
                            
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
            .navigationTitle((anime.title.english ?? anime.title.romaji ?? anime.title.native) ?? "null")
        }
    }
}

//struct AnimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeView(anime: )
//    }
//}
