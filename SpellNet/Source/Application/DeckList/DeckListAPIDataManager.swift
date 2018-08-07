//
//  DeckListAPIDataManager.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright (c) 2018 Spellnet. All rights reserved.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

final class DeckListAPIDataManager: DeckListAPIDataManagerInputProtocol {
    func downloadDeck(from database: DeckDataBase, completion: @escaping ((Response<Deck>) -> Void)) {
        
        guard let url = database.molDeckURL else {
            completion(Response.error(DeckListErrors.urlNotValid))
            return
        }
        
        Alamofire.request(url).responseData { response in
            
            if let error = response.error {
                completion(Response.error(error))
                return
            }
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                completion(self.handleUTF8(utf8Text, from: database))
                return
            }
            
            completion(Response.error(DeckListErrors.responseNotValid))
            return
        }
    }
    
    private func handleUTF8(_ data: String, from database: DeckDataBase) -> Response<Deck> {
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Parsing Data")
        let cardlist = transformTextIntoDeck(data)
        return Response.value(Deck(cardList: cardlist, dataBase: database))
    }
    
    private func transformTextIntoDeck(_ data: String) -> [Card] {
        return data.split(separator: "\r\n").map(String.init).compactMap{transformLineIntoCard($0)}
    }

    private func transformLineIntoCard(_ line: String) -> Card? {
        var splitBySpace = line.split(separator: " ").map(String.init)
        guard let quantity: Int = Int(splitBySpace.removeFirst()) else {return nil}
        let cardName: String = splitBySpace.joined(separator: " ")
        return Card(name: cardName, quantity: quantity)
    }
}
