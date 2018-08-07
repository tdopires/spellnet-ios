//
//  Storyboardable.swift
//  SpellNet
//
//  Created by Túlio Bazan da Silva on 05/08/18.
//  Copyright © 2018 Spellnet. All rights reserved.
//

import UIKit

protocol Storyboardable {
    associatedtype ViewProtocol
    static var storyboardId: String {get}
    static var initialControllerID: String {get}
    
    static func createViewModule() -> ViewProtocol?
}

extension Storyboardable {
    
    static func createViewModule() -> ViewProtocol? {
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: initialControllerID)
        
        return controller as? ViewProtocol
    }
}
