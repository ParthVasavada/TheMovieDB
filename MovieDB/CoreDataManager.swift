//
//  CoreDataManager.swift
//  MovieDB
//
//  Created by Parth Vasavada on 25/04/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private init() {}
    
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return CoreDataManager.persistentContainer.viewContext
    }
    
    
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: Constants.dbTitle)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                
                //TODO: - Add Error Handling for Core Data
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        })
        return container
    }()
    
    // MARK: - Save data into Coredata.
    class func saveContext(complition: (Bool) -> Void) {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Context - Data Saved")
                complition(true)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Delete all data in Coredata.
    class func deleteAllData(complition: ((Bool) -> Void)) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        fetchRequest.returnsObjectsAsFaults = false
        var isSuccessfull = false
        
        defer {
            complition(isSuccessfull)
        }
        
        do {
            let results = try Self.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                Self.persistentContainer.viewContext.delete(objectData)
            }
            isSuccessfull = true
        } catch let error {
            print("Detele all data in \(Constants.entityName) error :", error)
        }
    }

    
    // MARK: - Insert data in Coredata.
    class func insertDataToCoreData(_ object: [MovieModel], complition: ((Bool) -> Void) ) {
        
        defer {
            CoreDataManager.saveContext(complition: { isSucessFull in
                complition(isSucessFull)
            })
        }
        
        for obj in object {
            guard let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: CoreDataManager
                                                            .getContext())  else { return }
            let storeDic = NSManagedObject(entity: entity, insertInto: CoreDataManager.getContext())
    
            // Set the data to the entity
            storeDic.setValue(obj.adult, forKey: Constants.Keys.adult.rawValue)
            storeDic.setValue(obj.id, forKey: Constants.Keys.id.rawValue)
            storeDic.setValue(obj.originalTitle, forKey: Constants.Keys.originalTitle.rawValue)
            storeDic.setValue(obj.overview, forKey: Constants.Keys
                                .overview.rawValue)
            storeDic.setValue(obj.popularity, forKey: Constants.Keys.popularity.rawValue)
            storeDic.setValue(obj.releaseDate, forKey: Constants.Keys.releaseDate.rawValue)
            storeDic.setValue(obj.title, forKey: Constants.Keys.title.rawValue)
            storeDic.setValue(obj.posterImagePath, forKey: Constants.Keys.posterImagePath.rawValue)
            storeDic.setValue(false, forKey: Constants.Keys.favourite.rawValue)
    
        }
    }
    
    // MARK: - Get all data from Coredata.
    class func fetchAllData() -> [Movie] {
        print("=========== Retriving Movies from DB.=================")
        let all = NSFetchRequest<Movie>(entityName: Constants.entityName)
        var allData = [Movie]()
        
        do {
            let fetched = try CoreDataManager.getContext().fetch(all)
            allData = fetched
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
        
        return allData
    }

}
