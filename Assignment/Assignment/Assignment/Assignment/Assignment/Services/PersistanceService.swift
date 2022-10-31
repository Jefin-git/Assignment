//
//  PersistanceService.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import CoreData

class PersistanceService {
    
    static var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
     static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Assignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
}
