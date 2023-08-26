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
                .frame(width: 120, height: 180)
            Text((anime.title.english ?? anime.title.romaji ?? anime.title.native) ?? "No name")
                .foregroundColor(.black)
                .lineLimit(2)
                .frame(maxWidth: 120)
        }
        .frame(maxWidth: 120, maxHeight: 200)
    }
}
