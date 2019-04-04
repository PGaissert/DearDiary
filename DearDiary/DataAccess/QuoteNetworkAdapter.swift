//
//  QuoteNetworkAdapter.swift
//  DearDiary
//
//  Created by Patrick Gaissert on 02.04.19.
//  Copyright © 2019 MaibornWolff GmbH. All rights reserved.
//

import Foundation

struct QuoteNetworkAdapter {
    let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en")!

    func quote(completion: @escaping (Quote?) -> Void) {
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            let quote = try? decoder.decode(Quote.self, from: data)
            completion(quote)
        }

        dataTask.resume()
    }
}
