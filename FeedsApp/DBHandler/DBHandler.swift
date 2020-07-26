//
//  DBHandler.swift
//  FeedsApp
//
//  Created by Vishal on 05/07/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation
import CoreData

class DBHandler: NSObject{
    static let sharedDBHandler = DBHandler()
    private override init() {}
    
    typealias CompletionHandler = (_ success:[NSFetchRequestResult]?, _ error: String?) -> Void
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FeedsApp")
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
    
    fileprivate func getManagedObjectContext() -> NSManagedObjectContext? {
        let obj = persistentContainer.viewContext
        return obj
    }
    
    fileprivate func getFetchRequestObject(entityName:String) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        return fetchRequest
    }
    
    func saveDataForFeeds(entityModel: [FeedsInfoViewModel], entityName: String) {
        
        guard let managedContext = getManagedObjectContext() else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { return }
        for i in 0..<entityModel.count{
            let entityObject = entityModel[i]
            let dataRecord = NSManagedObject(entity: entity, insertInto: managedContext)
            dataRecord.setValue(entityObject.id, forKey: "id")
            dataRecord.setValue(entityObject.content, forKey: "content")
            dataRecord.setValue(entityObject.comments, forKey: "comments")
            dataRecord.setValue(entityObject.likes, forKey: "likes")
            dataRecord.setValue(entityObject.createdAt, forKey: "createdAt")
            dataRecord.setValue(entityObject.avatar, forKey: "avatar")
            dataRecord.setValue(entityObject.image, forKey: "image")
            dataRecord.setValue(entityObject.articleUrl, forKey: "articleUrl")
            dataRecord.setValue(entityObject.designation, forKey: "designation")
            dataRecord.setValue(entityObject.name, forKey: "name")
            dataRecord.setValue(entityObject.lastName, forKey: "lastName")
        }
        do{
            try managedContext.save()
            print("Saved")
        }catch let error{
            print("Failed \(error.localizedDescription)")
        }
    }
    
    func getDataForEntity(entityModelName: String, result: CompletionHandler){
        
        guard let managedContext = getManagedObjectContext() else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityModelName)
        request.returnsObjectsAsFaults = false
        //request.fetchLimit = 10
        do {
            guard let arrObject = try managedContext.fetch(request) as? [FeedsModel] else { return }
            //let arr = try managedContext.fetch(request) as! [NSManagedObject]
            result(arrObject,nil)
        } catch let error as NSError {
            result(nil,error.localizedDescription)
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
