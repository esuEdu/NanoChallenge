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
            VStack {
                AsyncImage(url: URL(string: url)) {
                    image in
                    image
                        .resizable()
                        .scaledToFill()
                    
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                        .overlay {
                            ProgressView()
                                .scaleEffect(4)
                                .frame(maxHeight: 96)
                                .padding()
                        }
                }
            }.frame(width: 185, height: 250, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 8, x: 5, y: 5)
            VStack {
                Text(name)
                    .font(.custom("Poppins", size: 22))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(maxWidth: 150)
                
                
            } // MARK: Primeira VSTACK
        }
    }
}

struct SerieCard_Previews: PreviewProvider {
    static var previews: some View {
        SerieCard(name: "Abuluh", url: "heeee")
    }
}
