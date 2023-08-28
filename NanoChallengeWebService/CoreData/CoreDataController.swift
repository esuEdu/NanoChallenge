//
//  CoreDataController.swift
//  NanoChallengeWebService
//
//  Created by Luca Lacerda on 28/08/23.
//

import Foundation
import CoreData

class CoreDataController{
    var favoritos:[Favorito] = []
    var animes:[AnimeModel] = []
    let container = NSPersistentContainer(name: "FavoriteDataModel")
    
    init(){
        container.loadPersistentStores { storeDescription, error in
            if let error = error{
                print("erro ao carregar o persistent store\(error)")
            }
        }
        fetch()
    }
    
    func fetch(){
        let request = NSFetchRequest<Favorito>(entityName: "Favorito")
        do{
            favoritos = try container.viewContext.fetch(request)
        }catch{
            print("erro ao fazer o fertch")
        }
    }
    
    func addFavorite(id:String, type:String){
        let newFavorite = Favorito(context: container.viewContext)
        newFavorite.id = id
        newFavorite.type = type
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetch()
        }catch{
            print("erro ao salvar")
        }
    }
}
