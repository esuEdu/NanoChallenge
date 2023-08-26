//
//  MovieItem.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import SwiftUI

struct MovieItem: View {
    
    @State var idMovie: Int
    @State var movieItem: Movie?
    @State var banner: String?
    @State var isFavorite: Bool? = nil
    
    @State var movieServe: MovieService? = MovieService()
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if (movieItem?.backdropPath) != nil {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movieItem?.backdropPath ?? "")")) { image in image
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
                Text(movieItem?.title ?? "")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white)
                
                                    // Listar todos os generos
//                                    HStack {
//                                        ForEach((movieItem?.genres)!, id: \.id){
//                                            genre in
//                                            GenresDesign(name: genre.name ?? "")
//                                        }
//                                    }
//                 verifica se exisgte descricao no retorno da API
                
                
                
                if movieItem?.overview == ""{
                    Text("Description not found")
                        .padding(.top)
                        .foregroundColor(Color.white)
                } else {
                    Text(movieItem?.overview ?? "Sem overview")
                        .padding(.top)
                        .foregroundColor(Color.white)
                }
                
                VStack(alignment: .leading, spacing: 15){
                    //                                Text(series.name)
                    //                                    .font(.system(size: 35, weight: .bold))
                    //                                    .foregroundColor(.white)
                    //                                // Listar as estrelas
                    HStack {
                        if let voteAverage = movieItem?.voteAverage {
//                            Text("\(voteAverage)")
//                                .foregroundColor(.yellow)
//
                            let average = voteAverage / 2
                            let fullStars = Int(average)
                            let hasHalfStar = (average - Double(fullStars)) >= 0.5
                            
                            ForEach(0..<5) { index in
                                if index < fullStars {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                } else if index == fullStars && hasHalfStar {
                                    Image(systemName: "star.leadinghalf.fill")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                } else {
                                    Image(systemName: "star")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                }
                            }
                        
                        }
                        Spacer()
//                         Botaão de favoritos
                        Button {
                            if isFavorite == nil {
                                isFavorite = false
                            }

                            isFavorite?.toggle()
                        } label: {
                            Image(systemName: isFavorite ?? false ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))

                        }
                        
                    }
                }

                
                
                
            } // MARK: VStack principal
            //    .frame(width: 360)
            .padding(.top, 25)
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(20)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(.black)
        .task {
            do {
                movieItem = try await movieServe?.getMovie(id: idMovie)
                
            } catch GHError.invalidURL {
                print("Invalid URL")
            } catch GHError.invalidData {
                print("Invalid response")
            } catch GHError.invalidResponse {
                print("Invalid data")
            } catch {
                print("Unexpected Error")
            }
        }
    }
}
        

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(idMovie: 298618)
    }
}

struct GenresDesign: View {
    
    var name: String
    
    var body: some View {
        Button(action: {}) {
            Text(name)
        }
        .border(Color.blue, width: 2)
    }
}
