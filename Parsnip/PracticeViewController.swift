//
//  PracticeViewController.swift
//  Parsnip
//
//  Created by Sofia Knezevic on 2022-11-09.
//

import Foundation
import UIKit



class PracticeViewController: UIViewController {
    @IBOutlet weak var flashCardView: UIView!
    @IBOutlet weak var changeWordButton: UIButton!
    
    let titleView = UIView()
    let definitionView = UIView()
    
    var showTitle = Bool.random()
    let words = RealmManager().realm.objects(Word.self)
    var currentWord: Word?
    
    let titleLabel = UILabel()
    let definitionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWord = words.randomElement()
        setUpCueCard()
        updateCueCard(with: showTitle)
        titleView.backgroundColor = .white
        definitionView.backgroundColor = .white
    }

    @IBAction func changeWordButtonDidTap(_ sender: UIButton) {
        currentWord = words.randomElement()
        titleLabel.text = currentWord?.title ?? ""
        definitionTextView.text = currentWord?.definition ?? ""
        showTitle = Bool.random()
        updateCueCard(with: showTitle)
    }
    
    private func setUpCueCard() {
        titleLabel.text = currentWord?.title ?? ""
        definitionTextView.text = currentWord?.definition ?? ""
        
        flashCardView.clipsToBounds = true
        definitionTextView.clipsToBounds = true
        flashCardView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCueCard(_:)))
        flashCardView.addGestureRecognizer(tapGesture)
        
        flashCardView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.centerXAnchor.constraint(equalTo: flashCardView.centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: flashCardView.centerYAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: flashCardView.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalTo: flashCardView.heightAnchor).isActive = true
        
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        flashCardView.addSubview(definitionView)
        definitionView.translatesAutoresizingMaskIntoConstraints = false
        definitionView.centerXAnchor.constraint(equalTo: flashCardView.centerXAnchor).isActive = true
        definitionView.centerYAnchor.constraint(equalTo: flashCardView.centerYAnchor).isActive = true
        definitionView.widthAnchor.constraint(equalTo: flashCardView.widthAnchor).isActive = true
        definitionView.heightAnchor.constraint(equalTo: flashCardView.heightAnchor).isActive = true
        
        definitionView.addSubview(definitionTextView)
        definitionTextView.isEditable = false
        definitionTextView.translatesAutoresizingMaskIntoConstraints = false
        definitionTextView.centerXAnchor.constraint(equalTo: definitionView.centerXAnchor).isActive = true
        definitionTextView.centerYAnchor.constraint(equalTo: definitionView.centerYAnchor).isActive = true
        definitionTextView.widthAnchor.constraint(equalTo: definitionView.widthAnchor).isActive = true
        definitionTextView.heightAnchor.constraint(equalTo: definitionView.heightAnchor).isActive = true
    }
    
    private func updateCueCard(with showTitle: Bool) {
        if showTitle {
            definitionView.isHidden = true
            titleView.isHidden = false
        } else {
            definitionView.isHidden = false
            titleView.isHidden = true
            definitionTextView.setContentOffset(.zero, animated: true)
        }
    }
    
    @objc func flipCueCard(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: flashCardView, duration: 0.4, options: .transitionFlipFromRight) { [weak self] in
            guard let self = self else { return }
            self.updateCueCard(with: !self.showTitle)
            self.showTitle = !self.showTitle
        }
    }
}
