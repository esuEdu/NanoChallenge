//
//  MovieItem.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import SwiftUI

struct MovieItem: View {
    
    @State var idMovie: Int
    @State private var movieItem: Movie?
    @State private var banner: String?
    @State private var movieServe: MovieService? = MovieService()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if let backDropPath = movieItem?.backdropPath {
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
                
                //                    // Listar todos os generos
                //                    HStack {
                //                        ForEach((movieItem?.genres)!, id: \.id){
                //                            genre in
                //                            GenresDesign(name: genre.name ?? "")
                //                        }
                //                    }
                // verifica se exisgte descricao no retorno da API
                
                
                
                if movieItem?.overview == ""{
                    Text("Description not found")
                        .padding(.top)
                        .foregroundColor(Color("TextColor"))
                } else {
                    Text(movieItem?.overview ?? "Sem overview")
                        .padding(.top)
                        .foregroundColor(Color("TextColor"))
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
            
            
            //            VStack {
            //                if let movieItem = movieItem {
            //                    //Id do filme
            //                    Text("\(movieItem.id)")
            //
            //                    //String da url do banner do filme
            //                    Text(movieItem.backdropPath ?? "sem banner")
            //
            //                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movieItem.backdropPath ?? "")")) { image in
            //                        image.resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                    } placeholder: {
            //                        // Placeholder view enquanto a imagem está sendo carregada
            //                        Color.gray
            //                    }
            //
            //                    //Adulto ou não
            //                    Text(String(movieItem.adult))
            //
            //
            //                    //Título do filme
            //                    Text(movieItem.title ?? "NDA")
            //
            //                    //Gêneros do filme
            //                    ForEach(movieItem.genres! , id: \.id) { genre in
            //                        Text(genre.name ?? "N genre")
            //                    }
            //
            //                    //Homepage do filme
            //                    Text(movieItem.homepage ?? "sem homepage")
            //
            //                    //Overview do filme
            //                    Text(movieItem.overview ?? "sem overview")
            //
            //                }
            //            }
            //            .padding()
            
            
        }
        
        //              func getImage() async throws {
        //                  let endpoint = "https://image.tmdb.org/t/p/original\(banner)"
        //              }
    }
}
        

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(idMovie: 157336)
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
