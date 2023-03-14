//
//  CoreDataSource.swift
//  ShoppingApp
//
//  Created by Jogendra on 18/03/2023.
//

import Foundation
import CoreData

final class CoreDataSource {

    lazy var context = persistentContainer.viewContext

    // MARK: - Initializer
    private init(){}

    // MARK: - Singleton
    static let shared = CoreDataSource()

    // MARK: - Core Data stack
    lazy public var persistentContainer: NSPersistentContainer = {
        let modelURL = Bundle.module.url(forResource:"ProductData", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        let container = NSPersistentContainer(name:"ProductData", managedObjectModel: model!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Helpers
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            let sharedContext = CoreDataSource.shared.context
            guard let result = try sharedContext.fetch(managedObject.fetchRequest()) as? [T] else {return nil}

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
}
