//
//  HearderSrollMovie.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

///É o header das ScrollMovies, recebe como pariametro o nome da ScrollView, normalmente o gênero da Lista de filmes.
struct HearderSrollMovie: View {
    
    var title: String //Titulo da lista de filmes
    
    var body: some View {
        HStack {
            Text(title) //Título da lista de filmes
                .font(.title)
                .padding(.horizontal)
            Spacer()
            Button { //Botão ao lado do título (Tem função meramente visual)
                
            } label: {
                Text("View All")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding()

           
        }
    }
}

//struct HearderSrollMovie_Previews: PreviewProvider {
//    static var previews: some View {
//        HearderSrollMovie()
//    }
//}
