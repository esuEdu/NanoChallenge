//
//  ListGenreSerie.swift
//  NanoChallengeWebService
//
//  Created by João Victor Bernardes Gracês on 26/08/23.
//

import SwiftUI

struct ListGenreSerie: View {
    var genreID: Int
    var genreName: String
    var serieArray: [TVSeries]
    var body: some View {
        VStack {
            HStack {
                Text(genreName)
                    .font(.title)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                Spacer()
                NavigationLink {
                    AllGenreSerie(genreID: genreID, genreName: genreName, serieArray: serieArray)
                } label: {
                    Text("Ver todas")
                        .font(.title2)
                        .padding(.horizontal)
                        .foregroundColor(Color("GreenCyan"))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(serieArray.filter({ $0.genre_ids.contains(genreID) }).prefix(20)) { series in
                        NavigationLink {
                            TVSerieDetail(series: series)
                        } label: {
                            VStack {
                                if let backDropPath = series.backdrop_path {
                                    SerieCard(name: series.name, url: "https://image.tmdb.org/t/p/original\(backDropPath)")
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        
    }
}

struct ListGenreSerie_Previews: PreviewProvider {
    static var previews: some View {
        ListGenreSerie(genreID: 10759, genreName: "Action & Adventure", serieArray: [TVSeries(id: 10, name: "idk", popularity: 10, vote_average: 10, genre_ids: [10759], posterPath: "")])
    }
}
