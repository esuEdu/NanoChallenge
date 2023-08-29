//
//  AnimeView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 25/08/23.
//

import SwiftUI

struct AnimeView: View {
    
    @StateObject private var viewModel = AnimeViewModel()
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
            ScrollView(.vertical, showsIndicators: false){
                
                GeometryReader{ reader in
                    
                    if let anime = viewModel.anime.first {
                        AnimeImageView(anime: anime)
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    }
                }.frame(height: 480)
                
                VStack{
                    
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text((anime.title.english ?? anime.title.romaji ?? anime.title.native) ?? "No name")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack {
                                ForEach(0..<Int(viewModel.anime.first?.averageScore ?? 0)/20, id: \.self){
                                    image in
                                    Image("fillStar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 26, height: 26)
                                }
                            }
                                
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
                .frame(width: 360)
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color("BackGroundColor"))
                .cornerRadius(20)
                .offset(y: -35)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle((anime.title.english ?? anime.title.romaji ?? anime.title.native) ?? "null")
            //blablabla
        }
    }
}

//struct AnimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeView(anime: )
//    }
//}

//struct TVSerieDetail: View {
//    @StateObject var seriesDetailVM = SeriesDetailViewlModel()
//    var series: TVSeries
//
//
//    var body: some View {
//
//        ScrollView(.vertical, showsIndicators: false){
//            GeometryReader{ reader in
//                if let backDropPath = series.backdrop_path{
//                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)"))  {
//                        image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .offset(y: -reader.frame(in: .global).minY)
//                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
//
//
//                    } placeholder: {
//                        ProgressView()
//                        ProgressView()
//                            .scaleEffect(4)
//                            .frame(maxHeight: 96)
//                            .foregroundColor(.white)
//                            .offset(y: -reader.frame(in: .global).minY)
//                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
//                    }
//                }
//            }
//            .frame(height: 480)
//            VStack(alignment: .leading, spacing: 15){
//                Text(series.name)
//                    .font(.system(size: 35, weight: .bold))
//                    .foregroundColor(.white)
//                // Listar as estrelas
//                HStack {
//                    ForEach(0..<Int(seriesDetailVM.vote_average), id: \.self){
//                        image in
//                        Image("fillStar")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 26, height: 26)
//                    }
//                    // Verificar se é maior que 0.50 para por a estrela meia bomba
//                    if (seriesDetailVM.vote_average - Double(Int(seriesDetailVM.vote_average))) >= 0.5 {
//                        Image("semiFillStar")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 26, height: 26)
//                    }
//                    // Colocar o resto das estrelas - verifica se ja existe uma entrela meia boma
//                    if (seriesDetailVM.vote_average - Double(Int(seriesDetailVM.vote_average))) >= 0.5 {
//                        ForEach(0...(3 - Int(seriesDetailVM.vote_average)), id: \.self) {
//                            image in
//                            Image("notFillStar")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 26, height: 26)
//                        }
//                        // caso nao tenha ele bota todas normal, caso tenha ele bota uma a menos
//                    } else {
//                        ForEach(0...(4 - Int(seriesDetailVM.vote_average)), id: \.self) {
//                            image in
//                            Image("notFillStar")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 26, height: 26)
//                        }
//                    }
//                    Spacer()
//                    // Botaão de favoritos
//                    Button {
//
//                    } label: {
//                        Image("corazon")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 26, height: 26)
//                    }
//
//                }
//
//
//                // Listar todos os generos
//                HStack {
//                    ForEach(seriesDetailVM.genresTV, id: \.id){
//                        genre in
//                            GenresDesign(name: genre.name)
//                    }
//                }
//                // verifica se exisgte descricao no retorno da API
//                if seriesDetailVM.overview == ""{
//                    Text("Description not found")
//
//                        .foregroundColor(Color("TextColor"))
//                } else {
//                    Text(seriesDetailVM.overview)
//
//                        .foregroundColor(Color("TextColor"))
//                }
//
//                //Número de Temporadas
//                Text("Temporadas - \(seriesDetailVM.number_of_seasons)")
//                    .font(.system(size: 24, weight: .bold))
//                    .foregroundColor(.white)
//                //Número de episódios
//                Text("Episódios - \(seriesDetailVM.number_of_episodes)")
//                    .font(.system(size: 24, weight: .bold))
//                    .foregroundColor(.white)
//                //puxar todos os eps
//                ForEach(seriesDetailVM.allEpisodes, id: \.self) {
//                    episode in
//                    Text("\(episode.name)")
//                        .font(.system(size: 21, weight: .bold))
//                        .foregroundColor(.white)
//                    Text(episode.overview)
//                        .foregroundColor(Color("TextColor"))
//                }
//
//            } // MARK: VStack principal
//        //    .frame(width: 360)
//            .padding(.top, 25)
//            .padding(.horizontal)
//            .background(Color("BackGroundColor"))
//            .cornerRadius(20)
//            .offset(y: -35)
//        }
//        .edgesIgnoringSafeArea(.all)
//        .background(Color("BackGroundColor"))
//        .task {
//      //      seriesDetailVM.urlString = series._links.selfLink.href
//            do {
//                try await seriesDetailVM.fetchTVSerie(id: series.id)
//                try await seriesDetailVM.fetchAllEpisode(idSerie: series.id, season: 1)
//            } catch {
//                print("Erro ao puxar os dados do detalhe")
//                if let decodingError = error as? DecodingError {
//                       print("Decoding error: \(decodingError)")
//                   }
//
//            }
//        }
//    }
//}
