//
//  DeckListRouter.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import UIKit

final class DeckListRouter: DeckListRouterProtocol, Storyboardable {
    typealias ViewProtocol = DeckListViewProtocol
    static var storyboardId: String = "DeckList"
    static var initialControllerID: String = "DeckListView"
    

    // MARK: - Presenting
    static func presentDeckListModule() -> UIViewController? {

        guard let moduleView = createViewModule() else {return nil}
        
        // Generating module components
        let view: DeckListViewProtocol = moduleView
        var presenter: DeckListPresenterProtocol & DeckListInteractorOutputProtocol = DeckListPresenter()
        let interactor: DeckListInteractorInputProtocol = DeckListInteractor()
        let apiDataManager: DeckListAPIDataManagerInputProtocol = DeckListAPIDataManager()
        let localDataManager: DeckListLocalDataManagerInputProtocol = DeckListLocalDataManager()
        let router: DeckListRouterProtocol = DeckListRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        interactor.localDatamanager = localDataManager

        return view as? UIViewController
    }
}
