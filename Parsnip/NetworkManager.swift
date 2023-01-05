//
//  NetworkManager.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2021-08-12.
//

import Foundation

typealias DefinitionCompletionBlock = ([[Definition]]?, Error?) -> Void

struct Root: Codable {
    let word: String
    let meanings: [Meaning]
}

struct Meaning: Codable {
    let definitions: [Definition]
    let partOfSpeech: String
}

struct Definition: Codable {
    let definition: String
}

public class NetworkManager {
    func getWordDefinition(with word: String, completion: @escaping DefinitionCompletionBlock) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else { return completion(nil, nil) }
        
        let request = NSMutableURLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(nil, error)
            } else {
                guard let data = data else { return }
                let results = try? JSONDecoder().decode([Root].self, from: data)
                let definitions = results?.first?.meanings.map { $0.definitions }
                completion(definitions, nil)
            }
        })

        dataTask.resume()
        
    }
}


