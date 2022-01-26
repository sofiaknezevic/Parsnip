//
//  NetworkManager.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2021-08-12.
//

import Foundation

typealias DefinitionCompletionBlock = ([Definition]?, Error?) -> Void

struct Root: Codable {
    let word: String
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition: String
    let partOfSpeech: String
}

public class NetworkManager {
    func getWordDefinition(with word: String, completion: @escaping DefinitionCompletionBlock) {

        let headers = [
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
            "x-rapidapi-key": "59ae1ae930msh13b0fa2b32fb5aep10eb47jsn4e44218a5176"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wordsapiv1.p.rapidapi.com/words/\(word)/definitions")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(nil, error)
            } else {
                guard let data = data else { return }
                let results = try! JSONDecoder().decode(Root.self, from: data)
                completion(results.definitions, nil)
            }
        })

        dataTask.resume()
        
    }
}


