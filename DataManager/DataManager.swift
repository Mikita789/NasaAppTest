//
//  DataManager.swift
//  NasaAppTest
//
//  Created by Никита Попов on 28.12.23.
//

import Foundation
import CoreData

class DataManager: ObservableObject{
    static let shared = DataManager()
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "ItemBase")
        container.loadPersistentStores { des, err in
            if let err = err{
                fatalError("Error load container")
            }
        }
    }
    
    private func saveContainer(_ context : NSManagedObjectContext) {
        do{
            try context.save()
        }catch{
            print("DEBUG : - save data error")
        }
    }
    
    func addPic(item: NasaUserItemModel, context: NSManagedObjectContext){
        if !self.isContainEl(item){
            let itemData = FavoriteObject(context: context)
            itemData.id = UUID()
            itemData.descr = item.descr ?? ""
            itemData.title = item.title ?? ""
            itemData.urlString = item.hdUrl ?? item.url
            
            self.saveContainer(context)
        }
        
    }
    
    func deleteItem(item: FavoriteObject, context: NSManagedObjectContext){
        context.delete(item)
        self.saveContainer(context)
    }
    
    func isContainEl(_ element: NasaUserItemModel)->Bool{
        let req: NSFetchRequest<FavoriteObject> = FavoriteObject.fetchRequest()
        do{
            let allPic = try container.viewContext.fetch(req)
            for im in allPic{
                if im.urlString ?? "" == element.url ?? "" || im.urlString ?? "" == element.hdUrl ?? ""{
                    return true
                }
            }
        }catch{
            print("DEBUG: - Не удалось получитьс FavoriteObjects")
            return false
        }
        return false
    }
    
    
}
