//
//  HearderSrollMovie.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 26/08/23.
//

import SwiftUI

///É o header das ScrollMovies, recebe como pariametro o nome da ScrollView, normalmente o gênero da Lista de filmes.
struct HearderSrollMovie: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding(.horizontal)
            Spacer()
            Button {
                
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
