//
//  TelaDeFavoritos.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import SwiftUI

struct TelaDeFavoritos: View {
    @StateObject private var vm = TelaDeFavoritosViewModel()
    @State var selected = 0
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
            
            List{
                if selected == 1{
                    ForEach(vm.listaAnimes){ i in
                        AnimeItemView(anime: i)
                    }.onDelete(perform: vm.dataController.remove)
                }
                
                if selected == 2{
                    ForEach(vm.listaFilmes){ i in
                        Text(i.title ?? "sem titulo")
                    }.onDelete(perform: vm.dataController.remove)
                }
                
                if selected == 3{
                    ForEach(vm.listaSerie){ i in
                        Text(i.name )
                    }.onDelete(perform: vm.dataController.remove)
                }
            }
            .listStyle(.plain)
            .position(x: width*0.5, y: height*0.05)
            .navigationTitle("Favoritos")
        }.task {
                do{
                    await vm.atualizarListas()
                }
            }
    }
}


struct TelaDeFavoritos_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            TelaDeFavoritos()
        }
    }
}
