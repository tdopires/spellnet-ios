//
//  DeckListProtocols.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import UIKit

// MARK: - Protocols

// MARK: DeckListPresenterProtocol
// VIEW -> PRESENTER
protocol DeckListPresenterProtocol {
    // MARK: - Properties
    var view: DeckListViewProtocol? {get set}
    var interactor: DeckListInteractorInputProtocol? {get set}
    var router: DeckListRouterProtocol? {get set}
    var screenTitle: String {get}

    func viewDidLoad()
    func addDeck(with urlText: String?)
}

// MARK: DeckListViewProtocol
// PRESENTER -> VIEW
protocol DeckListViewProtocol: class {
    // MARK: - Properties
    var presenter: DeckListPresenterProtocol? {get set}

    func set(_ title: String?)
}


// MARK: DeckListRouterProtocol
// PRESENTER -> ROUTER
protocol DeckListRouterProtocol: class {

    // MARK: - Properties
    static func presentDeckListModule() -> UIViewController?
}

// MARK: DeckListInteractorInputProtocol
// PRESENTER -> INTERACTOR
protocol DeckListInteractorInputProtocol: class {
    // MARK: - Properties
    var presenter: DeckListInteractorOutputProtocol? { get set }
    var apiDataManager: DeckListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: DeckListLocalDataManagerInputProtocol? { get set }
    
    func downloadDeck(from url: URL)
}

// MARK: DeckListAPIDataManagerInputProtocol
// INTERACTOR -> APIDATAMANAGER
protocol DeckListAPIDataManagerInputProtocol: class {
    func downloadDeck(from database: DeckDataBase, completion: @escaping ((Response<Deck>) -> Void))
}

// MARK: DeckListLocalDataManagerInputProtocol
// INTERACTOR -> LOCALDATAMANAGER
protocol DeckListLocalDataManagerInputProtocol: class {
}

// MARK: DeckListInteractorOutputProtocol
// INTERACTOR -> PRESENTER
protocol DeckListInteractorOutputProtocol: class {
    func handle(_ response: Response<Deck>)
}
