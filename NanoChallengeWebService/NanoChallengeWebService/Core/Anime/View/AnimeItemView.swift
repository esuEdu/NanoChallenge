//
//  AnimeItemView.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 17/08/23.
//

import SwiftUI

struct AnimeItemView: View {
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 8)
                .frame(maxWidth: 165, minHeight: 220, maxHeight: 200)
            Spacer()
            Text("")
                .padding(.leading, 5)
            Spacer()
        }
        .frame(maxWidth: 165, maxHeight: 280)
    }
}

struct AnimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            
            AnimeItemView()
                .previewLayout(.sizeThatFits)
            
            AnimeItemView()
        }

    }
}
