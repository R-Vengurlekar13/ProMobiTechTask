//
//  PersistentStorage.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation
import CoreData

// class to handle core data stack methods
final class PersistentStorage {
    
    private init() { }
    static let shared = PersistentStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "ProMobiTechTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
                debugPrint("Data saved successfully")
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type)-> [T]? {
        
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return result
            
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
}
