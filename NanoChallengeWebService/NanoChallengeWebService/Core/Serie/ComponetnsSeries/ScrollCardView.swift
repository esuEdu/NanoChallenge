//
//  ScrollCardsView.swift
//  TVMazeAPI
//
//  Created by João Victor Bernardes Gracês on 25/08/23.
//

import SwiftUI

struct ScrollCardsView: View {
    var arraySeries: [TVSeries]

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack {
                ForEach(0 ..< arraySeries.count, id: \.self){ index in
                    NavigationLink {
                        TVSerieDetail(series: arraySeries[index])
                    } label: {
                        VStack {
                            // if let para pegar o complemento da imagem do link
                            if let backDropPath = arraySeries[index].backdrop_path{
                                // Card padrao
                                SerieCard(name: arraySeries[index].name, url: "https://image.tmdb.org/t/p/original\(backDropPath)")
                            }
                        }
                        .padding()
                        
                    } // MARK: LABEL
                    
                }
            }
        }

    }
}

struct ScrollCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCardsView(arraySeries: [])
    }
}
