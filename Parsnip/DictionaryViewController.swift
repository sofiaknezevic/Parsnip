//
//  ViewController.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2021-08-11.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var definitionTextView: UITextView!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        definitionTextView.isEditable = false
        definitionTextView.clipsToBounds = true
        definitionTextView.layer.cornerRadius = 10
    }
    
    private func saveWord(_ word: Word) {
        RealmManager().saveWord(word: word)
    }
}

extension DictionaryViewController: UITabBarDelegate { }

extension DictionaryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        networkManager.getWordDefinition(with: textField.text ?? "") { (meanings, error) in
            if error == nil {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    let definitions = meanings?.reduce([], +)
                    let definitionText = definitions?.map({$0.definition}).joined(separator: "\n\n")
                    let hasNoDefinition = definitionText?.count == 0 || definitionText == nil
                    
                    self.definitionTextView.text = hasNoDefinition ? "I don't think this is a word. 😮‍💨." : definitionText
                    self.definitionTextView.setContentOffset(.zero, animated: true)
                    if !hasNoDefinition {
                        self.saveWord(Word(title: textField.text ?? "", definition: definitionText ?? ""))
                    }
                }
            } else {
                self.definitionTextView.text = "something weird happened, sorry bubs 🥹"
            }
        }
    }
}
