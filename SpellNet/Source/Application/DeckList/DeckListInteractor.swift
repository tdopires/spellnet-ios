//
//  DeckListInteractor.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import Foundation

final class DeckListInteractor: DeckListInteractorInputProtocol {
    // MARK: - Properties
    weak var presenter: DeckListInteractorOutputProtocol?
    var apiDataManager: DeckListAPIDataManagerInputProtocol?
    var localDatamanager: DeckListLocalDataManagerInputProtocol?
    
    func downloadDeck(from url: URL) {
        guard let database = DeckDataBase.create(from: url) else {
            presenter?.handle(Response.error(DeckListErrors.deckLinkNotValid))
            return
        }
        
        apiDataManager?.downloadDeck(from: database, completion: { response in
            self.presenter?.handle(response)
        })
    }
}
