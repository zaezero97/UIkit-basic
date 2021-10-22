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
// MARK: - CRUD func
extension CoreDataManager{
    func fetchData(){
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        do{
            todoList = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
    }
    func updateTodo(uuid: UUID?,title: String,date:Date,Priority:PriorityLevel?){
        guard let hasUuid = uuid else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUuid as CVarArg)
        
        do{
            let loadedData = try context.fetch(fetchRequest)
            loadedData.first?.title = title
            loadedData.first?.date = date
            loadedData.first?.priorityLevel = Priority?.rawValue ?? PriorityLevel.level1.rawValue
        }catch{
            print(error)
        }
        saveContext()
    }
    func savaTodo(title : String, date: Date,Priority: PriorityLevel?){
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {return}
        object.title = title
        object.date = date
        object.uuid = UUID()
        
        object.priorityLevel = Priority?.rawValue ?? PriorityLevel.level1.rawValue
        saveContext()
    }
    func deleteTodo(uuid : UUID?){
        guard let hasUuid = uuid else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUuid as CVarArg)
        
        do{
            let loadedData = try context.fetch(fetchRequest)
            if let hasData = loadedData.first{
                context.delete(hasData)
            }
        }catch{
            print(error)
        }
        saveContext()
    }
}
