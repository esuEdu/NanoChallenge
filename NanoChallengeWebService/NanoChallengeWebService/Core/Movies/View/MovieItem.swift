//
//  MovieItem.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import SwiftUI

struct MovieItem: View {
    
    @State var movieItem:Movie?
    @State var movieServe: MovieService = MovieService()
    
    var body: some View {
        VStack {
            if let movieItem = movieItem {
                //Id do filme
                Text("\(movieItem.id)")
                
                //Adulto ou não
                Text(String(movieItem.adult))

                
                //Título do filme
                Text(movieItem.title ?? "NDA")
                
                //Gêneros do filme
                ForEach(movieItem.genres! , id: \.id) { genre in
                    Text(genre.name ?? "N genre")
                }
                
                //Homepage do filme
                Text(movieItem.homepage ?? "sem homepage")
                
                //Overview do filme
                Text(movieItem.overview ?? "sem overview")

            }
        }
        .padding()
        .task {
            do {
                movieItem = try await movieServe.getMovie(id: 654)
                
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
        MovieItem()
    }
}
