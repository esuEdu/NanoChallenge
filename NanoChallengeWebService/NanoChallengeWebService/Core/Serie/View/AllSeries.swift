//
//  AllSeries.swift
//  NanoChallengeWebService
//
//  Created by João Victor Bernardes Gracês on 28/08/23.
//

import SwiftUI

struct AllSeries: View {
    @StateObject var serieVM = SeriesViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 15) {
                    ForEach(serieVM.tvSeriesArray) { serie in
                        NavigationLink {
                            TVSerieDetail(series: serie)
                        } label: {
                            if let backDropPath = serie.backdrop_path{
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)")) {
                                        image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                        
                                    } placeholder: {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                                            .overlay {
                                                ProgressView()
                                                    .scaleEffect(4)
                                                    .frame(maxHeight: 96)
                                                    .padding()
                                            }
                                    }
                                }.frame(width: 175, height: 250, alignment: .top)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(radius: 8, x: 5, y: 5)
                                   
                            }
                        }
                      
                    }
                    .padding(.horizontal)
                   
                }
               
            }
            .background(Color("BackGroundColor"))
            .task {
                do {
                     await serieVM.fetchAllTVSeries(limit: 10000)
                } catch {
                    print("Erro ao puxar os dados do detalhe")
                    if let decodingError = error as? DecodingError {
                        print("Decoding error: \(decodingError)")
                    }
                }
        }
        }
    }
}

struct AllSeries_Previews: PreviewProvider {
    static var previews: some View {
        AllSeries()
    }
}
