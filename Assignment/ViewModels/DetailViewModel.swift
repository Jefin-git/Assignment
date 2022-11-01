//
//  DetailViewModel.swift
//  Assignment
//
//  Created by Jefin on 01/11/22.
//

import Foundation
import CoreData

protocol DetailViewable {
    func saveItemToDatabase(_ item: Items) -> Bool
    func deleteItemFromDatabase(_ item: Items) -> Bool
}

class DetailViewModel: DetailViewable {
    
    var deleteSuccess: Bool = false
    
    //MARK: Method to save the current item to the database
    func saveItemToDatabase(_ item: Items) -> Bool {
        let context = PersistanceService.context
        let coreDataitem = Item(context: context)
        coreDataitem.itemTitle = item.title
        coreDataitem.itemDescription = item.description
        coreDataitem.itemImageUrl = item.imageUrl
        coreDataitem.itemId = Int32(item.id)
        
    
        if PersistanceService.saveContext() {
           return true
        }
        return false
    }
    
    //MARK: Method to delete the current item from the database
    func deleteItemFromDatabase(_ item: Items) -> Bool {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistanceService.context.fetch(fetchRequest)
            _ = items.map({ coreDataItem in
                if coreDataItem.itemId == item.id {
                        PersistanceService.context.delete(coreDataItem)
                        if PersistanceService.saveContext() {
                        self.deleteSuccess = true
                        }
                }
            })
            return deleteSuccess
        } catch {
            print(error.localizedDescription)
        }
        return deleteSuccess
    }
}
