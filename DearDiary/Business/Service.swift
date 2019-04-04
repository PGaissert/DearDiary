//
//  Service.swift
//  DearDiary
//
//  Created by Patrick Gaissert on 02.04.19.
//  Copyright © 2019 MaibornWolff GmbH. All rights reserved.
//

import Foundation

struct Service {
    let databasePersistenceAdapter = DatabasePersistenceAdapter()
    let quoteNetworkAdapter = QuoteNetworkAdapter()

    static let shared = Service()

    func quote(completion: @escaping (Quote?) -> Void) {
        quoteNetworkAdapter.quote { (quote) in
            DispatchQueue.main.async {
                completion(quote)
            }
        }
    }

    func addDiaryEntry(title: String, content: String) {
        databasePersistenceAdapter.addDiaryEntry(title: title, content: content)
        databasePersistenceAdapter.saveContext()
    }

    func diaryEntries(completion: @escaping ([DiaryEntry]?) -> Void) {
        let diaryEntries = databasePersistenceAdapter.diaryEntries()
        DispatchQueue.main.async {
            completion(diaryEntries)
        }
    }
}
