//
//  DeckListPresenter.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

final class DeckListPresenter: DeckListPresenterProtocol {

    // MARK: - Properties
    weak var view: DeckListViewProtocol?
    var interactor: DeckListInteractorInputProtocol?
    var router: DeckListRouterProtocol?

    // TODO: Set the correct Screen Title
    var screenTitle: String = "Deck List"

    // MARK: Presentation logic
    func viewDidLoad() {
        view?.set(screenTitle)
    }
    
    func addDeck(with urlText: String?) {
        guard let urlText = urlText, let url = URL(string: urlText) else { return }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), nil)
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Downloading")
        interactor?.downloadDeck(from: url)
    }
}

// MARK: - DeckListInteractorOutputProtocol
extension DeckListPresenter: DeckListInteractorOutputProtocol {
    func handle(_ response: Response<Deck>) {
        switch response {
        case .value(let deck):
            print(deck)
        case .error(let error):
            print(error)
        }
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
