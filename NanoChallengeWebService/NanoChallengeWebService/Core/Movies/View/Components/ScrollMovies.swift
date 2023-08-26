//
//  ScrollMovies.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

////Componente que exibe horizontalmente um array de Filmes, mostra o título e banner deles
//struct ScrollMovies: View {
//    let movies: [Movie]
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack {
//                ForEach(movies) { movie in
//                    NavigationLink {
//                        MovieItem(movieItem: movie)
//                    } label: {
//                        MovieDesignScrollView(movie: movie)
//                    }
//                }
//            }
//        }
//    }
//}
/*
 var body: some View {
 
                         ScrollView(.horizontal, showsIndicators: false){
                             LazyHStack {
                                 ForEach(0 ..< seriesVM.tvSeriesArray.count, id: \.self){ index in
                                     NavigationLink {
                                         TVSerieDetail(series: seriesVM.tvSeriesArray[index])
                                         
                                     } label: {
                                         VStack {
                                             // if let para pegar o complemento da imagem do link
                                             if let backDropPath = seriesVM.tvSeriesArray[index].backdrop_path {
                                                 AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)")) {
                                                     image in
                                                     image
                                                         .resizable()
                                                         .scaledToFill()
                                                         .backgroundStyle(.white)
                                                         .frame(maxWidth: 185,maxHeight: 230)
                                                         .cornerRadius(16)
                                                         .shadow(radius: 8, x: 5, y: 5)
                                                         .overlay {
                                                             RoundedRectangle(cornerRadius: 16)
                                                                 .stroke(.gray.opacity(0.5), lineWidth: 1)
                                                         }
                                                 } placeholder: {
                                                     RoundedRectangle(cornerRadius: 16)
                                                         .stroke(.gray.opacity(0.5), lineWidth: 1)
                                                         .frame(width: 160, height: 230)
                                                         .overlay {
                                                             ProgressView()
                                                                 .scaleEffect(4)
                                                                 .frame(maxHeight: 96)
                                                                 .padding()
                                                         }
                                                 }
                                                 
                                             }
                                             Text("\(seriesVM.tvSeriesArray[index].name.capitalized)")
                                                 .font(.title2)
                                                 .foregroundColor(.black)
                                             Text("\(seriesVM.count2)")
                                             
                                         }
                                         .padding()
                                         
                                     } // MARK: LABEL
                                     
                                 }
                             }
                         }
                         
                     } // MARK: VSTACK SERIES
                     .navigationTitle("Series")
                 }
                 
             }
             
             .task {
                 await seriesVM.fetchAllTVSeries()
             }
             .ignoresSafeArea()
         } // MARK: Primeira VSTACK
         .ignores
 */


//struct ScrollMovies_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollMovies()
//    }
//}
