//
//  SerieCard.swift
//  NanoChallengeWebService
//
//  Created by João Victor Bernardes Gracês on 25/08/23.
//

import SwiftUI

import SwiftUI

struct SerieCard: View {
    var name: String
    var url: String
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: url)) {
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
            Text(name)
                .font(.title2)
                .foregroundColor(.white)
        } // MARK: Primeira VSTACK
        .padding()
    }
}

struct SerieCard_Previews: PreviewProvider {
    static var previews: some View {
        SerieCard(name: "Abuluh", url: "heeee")
    }
}
