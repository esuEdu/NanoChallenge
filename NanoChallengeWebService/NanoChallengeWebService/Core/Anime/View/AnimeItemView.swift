//
//  AnimeItemView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import SwiftUI

struct AnimeItemView: View {
    
    let anime: AnimeModel
    
    var body: some View {
        VStack(alignment: .leading){
            AnimeImageView(anime: anime)
                .frame(width: 185, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 8, x: 5, y: 5)
            Text((anime.title.english ?? anime.title.romaji ?? anime.title.native) ?? "No name")
                .font(.custom("Poppins", size: 22))
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(maxWidth: 165)
        }
        .frame(maxWidth: 185, maxHeight: 280)
    }
}
