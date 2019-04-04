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
        let entry = DiaryEntry(context: context)
        entry.date = Date()
        entry.title = title
        entry.content = content
    }

    func diaryEntries() -> [DiaryEntry]? {
        let request: NSFetchRequest<DiaryEntry> = DiaryEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let diaryEntries = try? context.fetch(request)
        return diaryEntries
    }

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
