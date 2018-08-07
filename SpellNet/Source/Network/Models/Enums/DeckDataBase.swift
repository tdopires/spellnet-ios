//
//  DeckDataBase.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 06/08/18.
//  Copyright © 2018 Spellnet. All rights reserved.
//

import Foundation

enum DeckDataBase {
    case liga(url: URL)
    case goldfish(url: URL)
    case tappedOut(url: URL)
    
    static func create(from url: URL?) -> DeckDataBase?  {
        if let url = url, let urlFirstComponent = url.host {
            print(urlFirstComponent)
            switch urlFirstComponent {
            case "www.ligamagic.com.br":
                let liga = DeckDataBase.liga(url: url)
                guard let _ = liga.deckId, let _ = liga.molDeckURL else {break}
                return liga
            case "www.mtggoldfish.com":
                let goldfish = DeckDataBase.goldfish(url: url)
                guard let _ = goldfish.deckId, let _ = goldfish.molDeckURL else {break}
                return goldfish
            case "tappedout.net":
                let tappedOut = DeckDataBase.tappedOut(url: url)
                guard let _ = tappedOut.deckId, let _ = tappedOut.molDeckURL else {break}
                return tappedOut
            default:
                break
            }
        }
        return nil
    }
    
    var deckId: String? {
        switch self {
        case .liga(let url):
            if let last = url.query?.split(separator: "=").last{
                return String(last)
            }
            return nil
        case .goldfish(let url), .tappedOut(let url):
            return url.lastPathComponent
        }
    }
    
    var molDeckURL: URL? {
        guard let deckId = self.deckId else {return nil}
        switch self {
        case .liga(let url):
            guard let host = url.host else {return nil}
            return URL(string: "https://\(host)/decks/download.php?formato=mol&deck=\(deckId)")
        case .goldfish(let url):
            guard let host = url.host else {return nil}
            return URL(string: "https://\(host)/deck/download/\(deckId)")
        case .tappedOut(let url):
            guard let host = url.host else {return nil}
            return URL(string: "http://\(host)/mtg-decks/\(deckId)/?fmt=dec")
        }
    }
}
