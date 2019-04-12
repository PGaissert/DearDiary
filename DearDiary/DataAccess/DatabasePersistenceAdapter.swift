//
//  DatabasePersistenceAdapter.swift
//  DearDiary
//
//  Created by Patrick Gaissert on 02.04.19.
//  Copyright © 2019 MaibornWolff GmbH. All rights reserved.
//

import UIKit
import CoreData

class DatabasePersistenceAdapter {
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func addDiaryEntry(title: String, content: String) {
        // New DiaryEntry: set date, title, content
    }

    /*
     func diaryEntries() -> [DiaryEntry]?
     let request: NSFetchRequest<DiaryEntry>
     NSSortDescriptor(key: "date", ascending: false)
     */

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DearDiary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Core Data changes saved.")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
