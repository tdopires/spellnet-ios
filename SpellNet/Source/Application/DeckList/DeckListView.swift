//
//  DeckListView.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import UIKit
//import Rswift

class DeckListView: UIViewController {
    var presenter: DeckListPresenterProtocol?
    var urlTextField: UITextField?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        
    }
    
    @IBAction func newDeckList(_ sender: Any) {
        showAddPrompt()
    }
    
    
    func showAddPrompt() {
        // create the alert
        let alert = UIAlertController(title: R.string.localizable.deck_list_alert_title(),
                                      message: R.string.localizable.deck_list_alert_message(),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: R.string.localizable.continue(),
                                      style: UIAlertActionStyle.default,
                                      handler: { alert in
            self.presenter?.addDeck(with: self.urlTextField?.text)
        }))
        
        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(),
                                      style: UIAlertActionStyle.cancel,
                                      handler: nil))
        
        //Add TextField
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = R.string.localizable.deck_list_alert_textfield_placeholder()
            self.urlTextField = textField
        }
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: DeckListViewProtocol
extension DeckListView : DeckListViewProtocol {
    // MARK: Display logic
    func set(_ title: String?) {
        self.title = title
    }
}
