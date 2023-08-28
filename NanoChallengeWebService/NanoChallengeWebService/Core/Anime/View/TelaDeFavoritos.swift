//
//  TelaDeFavoritos.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import SwiftUI

struct TelaDeFavoritos: View {
    private var dataController = CoreDataController()
    @StateObject private var vm = FavoriteViewModel()
    @State private var selected = 0
    var body: some View {
        VStack{
            Picker("escolha o tipo", selection: $selected){
                Text("anime").tag(1)
                Text("filme").tag(2)
                Text("série").tag(3)
            }
            .pickerStyle(.segmented)
            
            if !vm.anime.isEmpty{
                ForEach(vm.anime){ i in
                    Text(i.title.romaji ?? "sem romanji")
                }
            }
        }.navigationTitle("Favoritos")
        .onAppear{
            for i in dataController.favoritos{
                if let idString = i.id{
                    if let id = Int(idString){
                        print("entrou")
                        Task{
                            do{
                                try await vm.fetchAnimeData(id: id)
                            }catch{
                                print("erro")
                            }
                        }
                    }
                }
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
