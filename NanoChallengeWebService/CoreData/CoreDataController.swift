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
        if self.favoritos.contains(newFavorite){
            return
        }else{
            saveData()
            fetch()
            print("já está favoritado")
        }
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetch()
        }catch{
            print("erro ao salvar")
        }
    }
    
    func delete(id:String, type:String){
        for i in self.favoritos{
            if i.id == id && i.type == type{
                print("deletado")
                container.viewContext.delete(i)
                saveData()
            }
        }
    }
    
    func delete(index:IndexSet){
        
    }
}
