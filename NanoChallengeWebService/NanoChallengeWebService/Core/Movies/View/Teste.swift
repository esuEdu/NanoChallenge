//
//  Teste.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

struct Teste: View {
    
    @State var responseMovieDiscover: responceDiscoverMovies?
    @State var movieService: MovieService = MovieService()
    
    var body: some View {
        ScrollView {
            VStack {
                if let responseMovieDiscover = responseMovieDiscover {
                    
                    if let page = responseMovieDiscover.page {
                        Text("\(page)")
                    } else {
                        Text("page indisponível")
                    }
                    
                    ForEach(responseMovieDiscover.results ?? [], id: \.id) { movie in
                        VStack {
                            if let title = movie.title {
                                Text(title)
                            } else {
                                Text("Titulo indisponível")
                            }
                            
                            if let backdropPath = movie.backdropPath {
                                Text(backdropPath)
                            } else {
                                Text("background indisponível")
                            }
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            async {
                do {
                    responseMovieDiscover = try await movieService.getDiscoverMovies()
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct Teste_Previews: PreviewProvider {
    static var previews: some View {
        Teste()
    }
}
