//
//  TelaDeFavoritos.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import SwiftUI

struct TelaDeFavoritos: View {
    @StateObject private var vm = TelaDeFavoritosViewModel()
    @State private var selected = 0
    var body: some View {
        VStack{
            Picker("escolha o tipo", selection: $selected){
                Text("anime").tag(1)
                Text("filme").tag(2)
                Text("série").tag(3)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)
            .position(x: width * 0.45,y: height*0.05)
            .padding(25)
            
            if selected == 1{
                List{
                    ForEach(vm.listaAnimes){ i in
                        Text(i.title.romaji ?? i.title.native ?? "sem titulo")
                    }
                }
            }
            if selected == 2{
                ForEach(vm.listaFilmes){ i in
                    Text(i.title ?? "sem titulo")
                }
            }
        }.navigationTitle("Favoritos")
        Spacer()
    }
}


struct TelaDeFavoritos_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            TelaDeFavoritos()
        }
    }
}
