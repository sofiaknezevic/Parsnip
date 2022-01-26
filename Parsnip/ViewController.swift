//
//  ViewController.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2021-08-11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var definitionTextView: UITextView!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        networkManager.getWordDefinition(with: textField.text ?? "") { (definitions, error) in
            if error == nil {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.definitionTextView.text = definitions?.map({$0.definition}).joined(separator: "\n\n")
                }
            }
        }
    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        networkManager.getWordDefinition(with: textView.text) { [weak self] (definitions, error) in
//            guard let self = self else { return }
//            if error == nil {
//                self.definitionTextView.text = definitions?.map({$0.definition}).joined(separator: "\n")
//            }
//        }
//    }
}
