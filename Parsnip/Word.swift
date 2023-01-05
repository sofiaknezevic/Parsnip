//
//  Word.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2023-01-05.
//

import Foundation
import RealmSwift

class Word: Object {
    @Persisted var title: String
    @Persisted var definition: String
    
    convenience init(title: String, definition: String) {
        self.init()
        self.title = title
        self.definition = definition
    }
}
