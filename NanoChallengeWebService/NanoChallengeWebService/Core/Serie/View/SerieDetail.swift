//
//  TVSerieDetail.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 23/08/23.
//

import SwiftUI

struct TVSerieDetail: View {
    var dataController = CoreDataController()
    @StateObject var seriesDetailVM = SeriesDetailViewlModel()
    var series: TVSeries
   
    
    var body: some View {
     
        ScrollView(.vertical, showsIndicators: false){
            GeometryReader{ reader in
                if let backDropPath = series.backdrop_path{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)"))  {
                        image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                        
                        
                    } placeholder: {
                        ProgressView()
                            .scaleEffect(4)
                            .frame(maxHeight: 96)
                            .foregroundColor(.white)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    }
                }
            }
            .frame(height: 480)
            VStack(alignment: .leading, spacing: 15){
                Text(series.name)
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white)
                // Listar as estrelas
                HStack {
                    ForEach(0..<Int(seriesDetailVM.vote_average), id: \.self){
                        image in
                        Image("fillStar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }
                    // Verificar se é maior que 0.50 para por a estrela meia bomba
                    if (seriesDetailVM.vote_average - Double(Int(seriesDetailVM.vote_average))) >= 0.5 {
                        Image("semiFillStar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }
                    // Colocar o resto das estrelas - verifica se ja existe uma entrela meia boma
                    if (seriesDetailVM.vote_average - Double(Int(seriesDetailVM.vote_average))) >= 0.5 {
                        ForEach(0...(3 - Int(seriesDetailVM.vote_average)), id: \.self) {
                            image in
                            Image("notFillStar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                        }
                        // caso nao tenha ele bota todas normal, caso tenha ele bota uma a menos
                    } else {
                        ForEach(0...(4 - Int(seriesDetailVM.vote_average)), id: \.self) {
                            image in
                            Image("notFillStar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                        }
                    }
                    Spacer()
                    // Botaão de favoritos
                    Button {
                        let test = Favorito(context: dataController.container.viewContext)
                        test.id = String(series.id)
                        test.type = "serie"
                        if !dataController.favoritos.contains(where:{ i in
                            i.id == String(series.id)
                        }){
                            dataController.addFavorite(id: String(series.id), type: "serie")
                            seriesDetailVM.isFavorite = true
                        } else{
                            dataController.delete(id: String(series.id), type: "serie")
                            seriesDetailVM.isFavorite = false
                        }
                    } label: {
                        if dataController.favoritos.contains(where: { i in
                            i.id == String(series.id)
                        }) || seriesDetailVM.isFavorite == true{
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                        }else{
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                        }
                    }
              
                }
         
                
                // Listar todos os generos
                HStack {
                    ForEach(seriesDetailVM.genresTV, id: \.id){
                        genre in
                            GenresDesign(name: genre.name)
                    }
                }
                // verifica se exisgte descricao no retorno da API
                if seriesDetailVM.overview == ""{
                    Text("Description not found")
                        
                        .foregroundColor(Color("TextColor"))
                } else {
                    Text(seriesDetailVM.overview)
                        
                        .foregroundColor(Color("TextColor"))
                }
                
                //Número de Temporadas
                Text("Temporadas - \(seriesDetailVM.number_of_seasons)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                //Número de episódios
                Text("Episódios - \(seriesDetailVM.number_of_episodes)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                //puxar todos os eps
                ForEach(seriesDetailVM.allEpisodes, id: \.self) {
                    episode in
                    Text("\(episode.name)")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(.white)
                    Text(episode.overview)
                        .foregroundColor(Color("TextColor"))
                }
                
            } // MARK: VStack principal
        //    .frame(width: 360)
            .padding(.top, 25)
            .padding(.horizontal)
            .background(Color("BackGroundColor"))
            .cornerRadius(20)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("BackGroundColor"))
        .navigationTitle(series.name)
        .navigationBarTitleDisplayMode(.inline)
        
        
        .task {
            do {
                try await seriesDetailVM.fetchTVSerie(id: series.id)
                try await seriesDetailVM.fetchAllEpisode(idSerie: series.id, season: 1)
            } catch {
                print("Erro ao puxar os dados do detalhe")
                if let decodingError = error as? DecodingError {
                       print("Decoding error: \(decodingError)")
                   }
                
            }
        }
    }
}


struct TVSerieDetail_Previews: PreviewProvider {
    static var previews: some View {
        TVSerieDetail( series: TVSeries(id: 1, name: "Serie OHHH MY GOD", popularity: 20, vote_average: 1, genre_ids: [1, 4, 6], backdrop_path: "", posterPath: ""))
    }
}
