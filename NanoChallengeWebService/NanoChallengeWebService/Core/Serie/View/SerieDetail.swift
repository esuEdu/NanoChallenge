//
//  TVSerieDetail.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 23/08/23.
//

import SwiftUI

struct TVSerieDetail: View {
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
                Text("\(seriesDetailVM.vote_average)")
                    .foregroundColor(.white)
                // Listar as estrelas
                HStack {
                    ForEach(0...4, id: \.self){ image in
                        
                        Image("fillStar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }
                    Spacer()
                    // Botaão de favoritos
                    Button {
                        
                    } label: {
                        Image("corazon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
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
                        .padding(.top)
                        .foregroundColor(Color("TextColor"))
                } else {
                    Text(seriesDetailVM.overview)
                        .padding(.top)
                        .foregroundColor(Color("TextColor"))
                }
                
                Text("Temporadas - \(seriesDetailVM.number_of_episodes)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
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
        .background(.black)
        .task {
      //      seriesDetailVM.urlString = series._links.selfLink.href
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
