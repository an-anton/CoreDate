//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Anton Anan'eV on 08.12.2021.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save(_ taskName: String) -> Task {
        let context = getContext()
        
        let task = Task(context: context)
        task.title = taskName
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        return task
    }
    
    func saveContext() {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteTask(task: Task) {
        let context = getContext()
        context.delete(task)
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func changeTask(task: Task) {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
    
}
