//
//  RealmManager.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2023-01-05.
//

import Foundation
import RealmSwift

public class RealmManager {
    let realm = try! Realm()
    
    func saveWord(word: Word) {
        try! realm.write {
            realm.add(word)
        }
    }
    
    func getRandomWord() -> Word? {
        let words = realm.objects(Word.self)
        return words.randomElement()
    }
    
    func deleteEmptyDefinitionWord(word: Word) {
        try! realm.write {
            realm.delete(word)
        }
    }
}
