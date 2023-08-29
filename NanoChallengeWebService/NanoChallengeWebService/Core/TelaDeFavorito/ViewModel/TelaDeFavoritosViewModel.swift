//
//  TelaDeFavoritosViewModel.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation

class TelaDeFavoritosViewModel: ObservableObject{
    @Published var listaFilmes:[Movie] = []
    @Published var listaAnimes:[AnimeModel] = []
    @Published var listaSerie:[TVEachSeries] = []
    var am = FavoriteAnimeViewModel()
    var fm = FavoriteMovieViewModel()
    var sm = FavoriteSerieViewModel()
    private var dataController = CoreDataController()
    
    init(){}
    
    func atualizarListas()async{
        dataController.fetch()
        for i in dataController.favoritos{
            if let idString = i.id{
                if let id = Int(idString){
                    do{
                        if i.type == "anime"{
                            let anime = try await am.fetchAnimeData(id: id)
                            if !listaAnimes.contains(anime){
                                DispatchQueue.main.async {
                                    self.listaAnimes.append(contentsOf: anime)
                                }
                            }
                        } else if i.type == "filme"{
                            let filme = try await fm.getMovie(id: id)
                            if !listaFilmes.contains(filme){
                                DispatchQueue.main.async {
                                    self.listaFilmes.append(filme)
                                }
                            }
                        }
//                            else{
//                            let serie = try await sm.fetchTVSerie(id: id)
//                            if !listaSerie.contains(where: serie){
//                                listaSerie.append(serie)
//                            }
//                        }
                    }catch{
                        print("erro")
                    }
                }
            }
        }
    }
}
