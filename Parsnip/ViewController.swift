//
//  ViewController.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2021-08-11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.getWordDefinition()
    }


}

