//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit
import CoreData
class CoreDataManager{
    static let shared = CoreDataManager()
    
    var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    var todoList = [TodoList]()
    private init(){
        
    }
    
    
    func fetchData(){
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        do{
             try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
